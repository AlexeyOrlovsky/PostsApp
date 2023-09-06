//
//  ViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 11.08.2023.
//

import UIKit
import SnapKit
import Firebase
import RealmSwift
import FirebaseAuth

class SignInViewController: UIViewController {
    
    /// UI Elements
    let sliderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.layer.cornerRadius = 3
        return button
    }()
    
    let signInLogFieldsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.textColor = UIColor(named: "RegistrationTextColor")
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.textColor = UIColor(named: "RegistrationTextColor")
        return field
    }()

    let repeatPassField: UITextField = {
        let field = UITextField()
        field.placeholder = "Repeat password"
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.textColor = UIColor(named: "RegistrationTextColor")
        return field
    }()

    let enterButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddSubviews()
        setupViewDidLoad()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = UIColor(named: "RegistrationBackgroundColor")
    }
    
    func setupAddSubviews() {
        view.addSubview(sliderButton)
        sliderButton.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        view.addSubview(signInLogFieldsContainer)
        signInLogFieldsContainer.addSubview(emailField)
        signInLogFieldsContainer.addSubview(passwordField)
        signInLogFieldsContainer.addSubview(repeatPassField)
        
        view.addSubview(enterButtonContainer)
        enterButtonContainer.addSubview(enterButton)
        enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sliderButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        
        signInLogFieldsContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(180)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(188)
        }
        
        emailField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordField.snp.top).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        }
        
        repeatPassField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(15)
        }
        
        enterButtonContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInLogFieldsContainer.snp.bottom).inset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        enterButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

/// @ubjc funcs
extension SignInViewController {
    
    @objc func enterButtonAction() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let repeatPassword = repeatPassField.text, !repeatPassword.isEmpty else { return }
        
        guard password == repeatPassword else { fieldsNotMatch(); return }
        
        existenceCheckUser(email: email, password: password)
    }
    
    func existenceCheckUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] authCheck, error in
            guard let check = authCheck, error == nil else { self.doesNotExist(); return }
            _ = check.user
            
            saveUserLoginStage(email: email, password: password)
        }
    }
    
    func saveUserLoginStage(email: String, password: String) {
        let login = RealmLoginModel()
        let realm = try? Realm()
        
        login.email = email
        login.password = password
        
        try? realm?.write {
            realm?.add(login)
            NavigationManager.shared.showAuthUserStage()
        }
    }
    
    @objc func signUpButtonAction() {
        let vc = SignUpViewController()
        present(vc, animated: true)
    }
    
    @objc func sliderButtonAction() {
        dismiss(animated: true)
    }
}

/// Alerts
extension SignInViewController {
    func fieldsNotMatch() {
        let alert = UIAlertController(title: "Do not match!",
                                      message: "Fields passwords and repeat password do not match",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func doesNotExist() {
        let alert = UIAlertController(title: "User is not found!",
                                      message: "Such user does not exist",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

