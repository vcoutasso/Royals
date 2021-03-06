//
//  SettingsViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 18/09/21.
//

import FirebaseAuth
import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Private attributes

    private var sendDoneButtonTappedEvent: (() -> Void)?
    private var sendLogoutButtonTappedEvent: (() -> Void)?

    // TODO: This should be user interactable in order to change the profile pic
    private lazy var profilePicture: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: LayoutMetrics.profilePictureSize))
        view.backgroundColor = .white

        let font = UIFont.systemFont(ofSize: LayoutMetrics.iconFontSize, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)

        let icon = UIImageView(image: UIImage(systemName: Strings.Names.Icons.camera, withConfiguration: configuration)!
            .imageWithColor(color: Assets.Colors.darkSystemGray1.color))
        let subtitle = UILabel()
        subtitle.text = Strings.Localizable.ProfileScene.SettingsView.ChangePicture.description
        subtitle.font = .systemFont(ofSize: LayoutMetrics.editLabelFontSize, weight: .regular)
        subtitle.textColor = Assets.Colors.darkSystemGray1.color

        let stack = UIStackView(arrangedSubviews: [icon, subtitle])
        stack.axis = .vertical
        stack.alignment = .center

        view.addSubview(stack)

        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        view.makeRounded()

        return view
    }()

    // TODO: Button toggles, but thats all it does. Needs a handler for state changes
    private lazy var contentVisibility: UIStackView = {
        let setting = SettingToggleView(title: Strings.Localizable.ProfileScene.SettingsView.ContentVisibility.title)

        let description = UILabel()
        description.text = Strings.Localizable.ProfileScene.SettingsView.ContentVisibility.description
        description.font = .systemFont(ofSize: LayoutMetrics.descriptionFontSize, weight: .light)
        description.textColor = Assets.Colors.lightGray.color
        description.numberOfLines = 0
        description.textAlignment = .left

        let stack = UIStackView(arrangedSubviews: [setting, description])
        stack.axis = .vertical
        stack.spacing = LayoutMetrics.descriptionVerticalSpacing

        return stack
    }()

    private lazy var editUserHandleStack: SettingsTextFieldView = {
        .init(delegate: self,
              textFieldTitle: Strings.Localizable.ProfileScene
                  .SettingsView.NameTextField.title,
              placeholderText: Strings.Localizable
                  .ProfileScene.SettingsView.NameTextField
                  .placeholder)

    }()

    private lazy var editUsernameStack: SettingsTextFieldView = {
        .init(delegate: self,
              textFieldTitle: Strings.Localizable.ProfileScene
                  .SettingsView.UserTextField.title,
              placeholderText: Strings.Localizable.ProfileScene
                  .SettingsView.UserTextField.placeholder)
    }()

    // FIXME: Fix design
    private lazy var logoutButton: UIButton = {
        let btn = UIButton()

        btn.setTitle(Strings.Localizable.ProfileScene.LogoutButton.title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: LayoutMetrics.logoutButtonFontSize, weight: .medium)
        btn.setTitleColor(Assets.Colors.red.color, for: .normal)
        btn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        return btn
    }()

    // MARK: - Initialization

    init(sendDoneButtonTappedEvent: @escaping () -> Void, sendLogoutButtonTappedEvent: @escaping () -> Void) {
        self.sendDoneButtonTappedEvent = sendDoneButtonTappedEvent
        self.sendLogoutButtonTappedEvent = sendLogoutButtonTappedEvent
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    @objc private func doneButtonTapped() {
        CurrentUser.shared.updateUserData(handle: editUserHandleStack.getTextFieldText(),
                                          username: editUsernameStack.getTextFieldText())

        sendDoneButtonTappedEvent?()
    }

    @objc private func logoutButtonTapped() {
        try? Auth.auth().signOut()

        sendLogoutButtonTappedEvent?()
    }

    private func setupView() {
        view.backgroundColor = Assets.Colors.darkSystemGray6.color

        let titleView = UILabel()
        titleView.text = Strings.Localizable.ProfileScene.SettingsView.NavigationItem.title
        navigationItem.titleView = titleView

        let rightBarButton = UIBarButtonItem(title: Strings.Localizable.ProfileScene
            .SettingsView.NavigationItem.DoneButton.title,
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        navigationItem.setRightBarButton(rightBarButton, animated: false)
    }

    private func setupHierarchy() {
        view.addSubview(profilePicture)
        view.addSubview(editUserHandleStack)
        view.addSubview(editUsernameStack)
        view.addSubview(contentVisibility)
        view.addSubview(logoutButton)
    }

    private func setupConstraints() {
        profilePicture.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(profilePicture.frame.size) // FIXME: Why is this needed? Seems redundant
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutMetrics.viewTopOffset)
        }

        editUserHandleStack.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.bottom)
                .offset(LayoutMetrics.verticalSpacing)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.horizontalPadding)
        }

        editUsernameStack.snp.makeConstraints { make in
            make.top.equalTo(editUserHandleStack.snp.bottom)
                .offset(LayoutMetrics.verticalSpacing)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.horizontalPadding)
        }

        contentVisibility.snp.makeConstraints { make in
            make.top.equalTo(editUsernameStack.snp.bottom)
                .offset(LayoutMetrics.verticalSpacing)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.horizontalPadding)
        }

        logoutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .inset(LayoutMetrics.viewBottomOffset)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        private static let profilePicDiameter: CGFloat = 104

        static let profilePictureSize: CGSize = .init(width: profilePicDiameter, height: profilePicDiameter)
        static let viewTopOffset: CGFloat = 20
        static let viewBottomOffset: CGFloat = viewTopOffset / 2
        static let horizontalPadding: CGFloat = 18
        static let verticalSpacing: CGFloat = 24
        static let iconFontSize: CGFloat = 24
        static let editLabelFontSize: CGFloat = 14
        static let descriptionFontSize: CGFloat = 16
        static let descriptionVerticalSpacing: CGFloat = 14
        static let logoutButtonCornerRadius: CGFloat = 14
        static let logoutButtonFontSize: CGFloat = 18
        static let logoutButtonHeight: CGFloat = 50
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
