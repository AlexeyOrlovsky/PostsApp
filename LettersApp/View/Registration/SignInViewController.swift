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
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        return view
    }()

    let signUpLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    let registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    let deletePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return button
    }()
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    let deleteRepeatPassButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return button
    }()
    let repeatPasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString( string: "Repeat password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    let enterContainerButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    let enterButton: UIButton = {
        let label = UIButton()
        label.setTitle("Enter", for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        label.setTitleColor(UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1), for: .normal)
        return label
    }()
    let googleRegButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    let googleButton: UIButton = {
        let label = UIButton()
        label.setTitle("Google", for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        label.setTitleColor(UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1), for: .normal)
        return label
    }()
    let appleRegButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    let appleButton: UIButton = {
        let label = UIButton()
        label.setTitle("Apple", for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        label.setTitleColor(UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1), for: .normal)
        return label
    }()
    
    var dismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "RegistrationBackgroundColor")

        setupAddSubviews()
    }
    
    func setupAddSubviews() {
        
        view.addSubview(sliderButton)
        
        view.addSubview(signUpLabelView)
        signUpLabelView.addSubview(signInLabel)
        
        view.addSubview(registrationView)
        registrationView.addSubview(emailTextField)
        registrationView.addSubview(passwordTextField)
        registrationView.addSubview(deletePasswordButton)
        registrationView.addSubview(repeatPasswordTextField)
        registrationView.addSubview(deleteRepeatPassButton)
        
        view.addSubview(enterContainerButton)
        enterContainerButton.addSubview(enterButton)
        
        view.addSubview(googleRegButtonView)
        googleRegButtonView.addSubview(googleButton)
        
        view.addSubview(appleRegButtonView)
        appleRegButtonView.addSubview(appleButton)
        
        deletePasswordButton.addTarget(self, action: #selector(actionDeleteButtonPassword), for: .touchUpInside)
        deleteRepeatPassButton.addTarget(self, action: #selector(actionDeleteButtonRepeatPass), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        sliderButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        
        signUpLabelView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registrationView.snp.top).inset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        signInLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        registrationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(220)
            make.width.equalTo(320)
            make.height.equalTo(200)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-12)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
        deletePasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
        }
        
        deleteRepeatPassButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
        }
        
        enterContainerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registrationView.snp.bottom).inset(-15)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        enterButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        googleRegButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(enterContainerButton.snp.bottom).inset(-15)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        googleButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        appleRegButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(googleRegButtonView.snp.bottom).inset(-15)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        appleButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

/// @objc funcs
extension SignInViewController {
    
    @objc func enterButtonAction() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else { return }
        
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
    
    @objc func sliderButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func actionDeleteButtonRepeatPass() {
        dismiss.toggle()
        
        if dismiss {
            repeatPasswordTextField.isSecureTextEntry = false
            deleteRepeatPassButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            repeatPasswordTextField.isSecureTextEntry = true
            deleteRepeatPassButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @objc func actionDeleteButtonPassword() {
        passwordTextField.text = ""
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

/// UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
