//
//  SettingsViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 18/09/21.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Private attributes

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
        view.addSubview(editUserHandleStack)
        view.addSubview(editUsernameStack)
        view.addSubview(contentVisibility)
    }

    private func setupConstraints() {
        editUserHandleStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutMetrics.viewTopOffset)
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
        static let viewTopOffset: CGFloat = 20
        static let horizontalPadding: CGFloat = 18
        static let verticalSpacing: CGFloat = 24
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
