//
//  ViewViewController.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 02.11.24.
//

import UIKit

final class LoginVC: UIViewController {
    let viewModel = LoginViewModel()
    private let inputStacks = UIStackView()
    private let avatar = UIImageView()
    private let loginButton = UIButton(type: .custom)
    private let userNameTxtField = PaddedTextField()
    private let passwordTxtField = PaddedTextField()
    private let confirmPasswdTxtField = PaddedTextField()
    
    override func loadView() {
        super.loadView()
        view = LinearGradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .mainViolet
        
        setupAvatarUpload()
        setupInputs()
        configureInput(textField: userNameTxtField, labelText: "Username", placeholder: "Enter username")
        userNameTxtField.isSecureTextEntry = false
        configureInput(textField: passwordTxtField, labelText: "Password", placeholder: "Enter password")
        configureInput(textField: confirmPasswdTxtField, labelText: "Confirm password", placeholder: "Enter password")
        setupLoginButton()
    }
    
    private func setupAvatarUpload() {
        view.addSubview(avatar)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.image = UIImage(named: "avatar")
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupInputs() {
        view.addSubview(inputStacks)
        inputStacks.translatesAutoresizingMaskIntoConstraints = false
        inputStacks.axis = .vertical
        inputStacks.spacing = 13
        
        NSLayoutConstraint.activate([
            inputStacks.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 22),
            inputStacks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            inputStacks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])
    }
    
    private func configureInput(textField: PaddedTextField, labelText: String, placeholder: String) {
        let stack = UIStackView()
        let label = UILabel()
        
        inputStacks.addArrangedSubview(stack)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(textField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        label.configureCustomLabel(text: labelText, textColor: .white, fontName: "Sen-Regular", fontSize: 16)
        
        textField.configureCustomTextField(isSecure: true, placeholder: placeholder)
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.configureCustomButton(
            btnHeight: 42,
            bgColor: .secondaryViolet,
            btnTitle: "Login",
            color: .white,
            fontName: "Sen-Medium",
            fonSize: 14
        )
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
        loginButton.addAction(UIAction(handler: { [weak self] action in
            
            guard let self = self else { return }
            
            self.viewModel.auth(
                userField: self.userNameTxtField,
                passField: self.passwordTxtField,
                confield: self.confirmPasswdTxtField, errors: { errormsg in
                    self.errorModal(text: errormsg ?? "" )
                }
            )
            self.navigationController?.pushViewController(QuizVC(), animated: true)
        }), for: .touchUpInside)
    }
    
    private func errorModal(text: String) {
        let alert = UIAlertController(title: "OoOps...", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
