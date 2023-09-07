//
//  SignUpViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 12.08.2023.
//

import UIKit
import SnapKit
import Firebase
import RealmSwift
import SDWebImage
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
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
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let regView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let userIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    let addIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
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
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
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
    
    let aboutMeTextField: UITextView = {
        let textView = UITextView()
        textView.text = "Hello"
        textView.attributedText = NSAttributedString( string: "About me...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        return textView
    }()
    
    let tagTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "#tag", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    
    let createLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let createButton: UIButton = {
        let label = UIButton()
        label.setTitle("Create", for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        label.setTitleColor(UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1), for: .normal)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupAddSubviews()
        delegatesAndDataSourses()
    }
    
    private func setupAddSubviews() {
        view.addSubview(sliderButton)
        
        view.addSubview(signUpLabelView)
        signUpLabelView.addSubview(signUpLabel)
        
        view.addSubview(regView)
        regView.addSubview(userIconImageView)
        regView.addSubview(addIconButton)
        regView.addSubview(nameTextField)
        regView.addSubview(emailTextField)
        
        regView.addSubview(passwordTextField)
        regView.addSubview(deletePasswordButton)
        
        regView.addSubview(repeatPasswordTextField)
        regView.addSubview(deleteRepeatPassButton)
        
        regView.addSubview(aboutMeTextField)
        regView.addSubview(tagTextField)
        
        view.addSubview(createLabelView)
        createLabelView.addSubview(createButton)
        
        deletePasswordButton.addTarget(self, action: #selector(actionDeleteButtonPassword), for: .touchUpInside)
        deleteRepeatPassButton.addTarget(self, action: #selector(actionDeleteButtonRepeatPass), for: .touchUpInside)
        sliderButton.addTarget(self, action: #selector(actionSliderButton), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        addIconButton.addTarget(self, action: #selector(selectPhotoButtonTapped), for: .touchUpInside)
    }
    
    /// delegates & dataSourses
    private func delegatesAndDataSourses() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        aboutMeTextField.delegate = self
        tagTextField.delegate = self
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sliderButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        
        signUpLabelView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(regView.snp.top).inset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        regView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(160)
            make.width.equalTo(320)
            make.height.equalTo(460)
        }
        
        userIconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        addIconButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userIconImageView.snp.bottom).offset(12)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(addIconButton.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(30)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
        }
        
        deletePasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
        }
        
        deleteRepeatPassButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
        }
        
        aboutMeTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(26)
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(12)
            make.width.equalTo(280)
            make.height.equalTo(80)
        }
        
        tagTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(aboutMeTextField.snp.bottom).offset(12)
        }
        
        createLabelView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(regView.snp.bottom).inset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        createButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

/// @objc funcs
extension SignUpViewController {
    
    @objc func createButtonAction() {
        guard let icon = userIconImageView.image,
              let name = nameTextField.text, !name.isEmpty, name.count >= 3,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else { fieldEmptyAlert(); return }
        
        createUserInFirebase(name: name, icon: icon, email: email, password: password)
        
        dismiss(animated: true)
        print("create button tapped")
    }
    
    /// Firebase Authentication
    func createUserInFirebase(name: String, icon: UIImage, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let error = error {
                
                // handle error
                print("user create error \(error.localizedDescription)")
                return
            }
            
            if let currentUser = authResult?.user.uid {
                let user = UserModel(name: name, aboutMe: aboutMeTextField.text!, link: tagTextField.text!, userID: currentUser)
                addUserLocallyAndRemotaly(user: user, icon: icon)
            }
        }
    }
    
    /// Data Storage
    func addUserLocallyAndRemotaly(user: UserModel, icon: UIImage) {
        saveUserInUserDefaults(user: user)
        saveUserInRealm(user: user, icon: icon)
        addUserInFirestore(user: user, icon: icon)
    }
    
    func saveUserInUserDefaults(user: UserModel) {
        if let userData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userData, forKey: "user")
        }
    }
    
    func saveUserInRealm(user: UserModel, icon: UIImage) {
        let realm = try? Realm()
        if let existingIcon = realm?.objects(RealmUserIconModel.self).first {
            try? realm?.write {
                existingIcon.iconUser = icon.jpegData(compressionQuality: 1.0)
            }
        } else {
            let userIcon = RealmUserIconModel()
            userIcon.iconUser = icon.jpegData(compressionQuality: 1.0)
            
            try? realm?.write {
                realm?.add(userIcon)
            }
        }
    }
    
    func addUserInFirestore(user: UserModel, icon: UIImage) {
        let database = Firestore.firestore()
        let document = database.collection("Users").document(user.userID)
        
        document.setData([
            "name": user.name,
            "link": user.link,
            "aboutMe": user.link,
            "userID": user.userID,
            "icon": user.iconUser ?? "Save error"
        ])
        
        // create and add icon / image document in Storage
    }
    
    @objc func selectPhotoButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func addIconButtonAction() {
        showImagePicker()
    }
    
    @objc func sliderButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func actionDeleteButtonPassword() {
        passwordTextField.text = ""
    }
    
    @objc func actionDeleteButtonRepeatPass() {
        repeatPasswordTextField.text = ""
    }
    
    @objc func actionSliderButton() {
        dismiss(animated: true)
    }
}

/// Alerts
extension SignUpViewController {
    func fieldEmptyAlert() {
        let alert = UIAlertController(title: "Fields are empty!", message: .none, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

/// UIImagePicker
extension SignUpViewController {
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func showImagePicker() {
        let imagePicker = self.imagePicker(sourceType: .photoLibrary)
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

/// UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        userIconImageView.image = image
        dismiss(animated: true)
    }
}

/// UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate, UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
