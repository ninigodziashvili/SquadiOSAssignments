//
//  LoginPageVC.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 02.11.24.
//

import UIKit

final class LoginPageVC: UIViewController {
    let loginPageViewModel = LoginPageViewModel()
    
    private let addUserIconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 50
        
        return view
    }()
    private let addUserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: largeConfig)
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private let textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let usernameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Username", font: UIFont(name: "Sen-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18), textColor: .white, alignment: .left)
        
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(hexString: "EFEFEF")
        textField.layer.cornerRadius  = 12
        textField.placeholder = "Enter username"
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Password", font: UIFont(name: "Sen-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18), textColor: .white, alignment: .left)
        
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(hexString: "EFEFEF")
        textField.layer.cornerRadius  = 12
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let confirmPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Confirm password", font: UIFont(name: "Sen-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18), textColor: .white, alignment: .left)
        
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Sen-Medium", size: 14)
        button.backgroundColor = UIColor(hexString: "8E84FF")
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(hexString: "EFEFEF")
        textField.layer.cornerRadius  = 12
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let passwordDoesntMatchLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "pass", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), textColor: .white, alignment: .left)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "0a0e29")
        setupUI()
    }
    
    private func setupUI() {
        setupAdduserIconView()
        setupAddUserImageView()
        setupTextFieldsStackView()
        setupUsernameAndPasswordStackView()
        setupLoginButton()
    }
    
    private func setupAdduserIconView() {
        view.addSubview(addUserIconView)
        
        NSLayoutConstraint.activate([
            addUserIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addUserIconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            addUserIconView.heightAnchor.constraint(equalTo: addUserIconView.widthAnchor),
            addUserIconView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupAddUserImageView() {
        addUserIconView.addSubview(addUserImageView)
        
        NSLayoutConstraint.activate([
            addUserImageView.centerXAnchor.constraint(equalTo: addUserIconView.centerXAnchor),
            addUserImageView.centerYAnchor.constraint(equalTo: addUserIconView.centerYAnchor),
        ])
    }
    
    private func setupTextFieldsStackView() {
        view.addSubview(textFieldsStackView)
        
        NSLayoutConstraint.activate([
            textFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textFieldsStackView.topAnchor.constraint(equalTo: addUserIconView.bottomAnchor, constant: 20),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: 330),
        ])
    }
    
    private func setupUsernameAndPasswordStackView() {
        [usernameStackView, passwordStackView, confirmPasswordStackView].forEach { textFieldsStackView.addArrangedSubview($0) }
        
        [usernameLabel, usernameTextField].forEach { usernameStackView.addArrangedSubview($0) }
        [passwordLabel, passwordTextField].forEach { passwordStackView.addArrangedSubview($0) }
        [confirmPasswordLabel, confirmPasswordTextField].forEach { confirmPasswordStackView.addArrangedSubview($0) }
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 70),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        loginButton.addAction(UIAction(handler: { [weak self] action in
            self?.saveData()
        }), for: .touchUpInside)
    }
    
    private func setupPasswordDoesntMatchLabel(text: String){
        view.addSubview(passwordDoesntMatchLabel)
        
        NSLayoutConstraint.activate([
            passwordDoesntMatchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            passwordDoesntMatchLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            passwordDoesntMatchLabel.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
        ])
        
        passwordDoesntMatchLabel.text = text
    }
    
    private func saveData() {
        loginPageViewModel.saveUser(userName: usernameTextField.text ?? "", passWord: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "")
        
        loginPageViewModel.onLoginSuccess = { [weak self] in
            self?.navigationController?.pushViewController(QuestionsListPageVC(), animated: true)
        }
        
        loginPageViewModel.onPasswordMismatch = { [weak self] message in
            self?.setupPasswordDoesntMatchLabel(text: message)
        }
    }
}

