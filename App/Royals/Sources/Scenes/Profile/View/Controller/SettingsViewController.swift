//
//  SettingsViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 18/09/21.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Private attributes

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
    private lazy var contentVisibility: SettingToggleView = {
        .init(title: Strings.Localizable.ProfileScene.SettingsView.ContentVisibility.title)
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

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }

    private func setupHierarchy() {
        view.addSubview(profilePicture)
        view.addSubview(editUserHandleStack)
        view.addSubview(editUsernameStack)
        view.addSubview(contentVisibility)
    }

    private func setupConstraints() {
        profilePicture.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(profilePicture.frame.size) // FIXME: Why is this needed?
            make.top.equalToSuperview()
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
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        private static let profilePicDiameter: CGFloat = 104

        static let profilePictureSize: CGSize = .init(width: profilePicDiameter, height: profilePicDiameter)
        static let viewTopOffset: CGFloat = 20
        static let horizontalPadding: CGFloat = 18
        static let verticalSpacing: CGFloat = 24
        static let iconFontSize: CGFloat = 24
        static let editLabelFontSize: CGFloat = 14
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
