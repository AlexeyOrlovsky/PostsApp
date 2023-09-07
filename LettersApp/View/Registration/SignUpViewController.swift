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
        let button = UIButton()
        button.backgroundColor = .label
        button.layer.cornerRadius = 3
        return button
    }()
    
    let signUpTitleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let signUpTitle: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let signUpRegFieldsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    var iconUser: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let addIconButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.textColor = UIColor(named: "RegistrationTextColor")
        return field
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
    
    let aboutMeField: UITextView = {
        let field = UITextView()
        field.text = "About me"
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.backgroundColor = UIColor(named: "SecondColor")
        field.textColor = UIColor(named: "RegistrationTextColor")
        field.showsVerticalScrollIndicator = false
        return field
    }()
    
    let linkField: UITextField = {
        let field = UITextField()
        field.placeholder = "Link"
        field.font = .systemFont(ofSize: 20, weight: .bold)
        field.textColor = UIColor(named: "RegistrationTextColor")
        return field
    }()
    
    let createButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor(named: "RegistrationTextColor"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVeiwDidLoad()
        setupAddSubviews()
    }
    
    func setupVeiwDidLoad() {
        view.backgroundColor = UIColor(named: "RegistrationBackgroundColor")
    }
    
    func setupAddSubviews() {
        
        view.addSubview(sliderButton)
        sliderButton.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        view.addSubview(signUpTitleContainer)
        signUpTitleContainer.addSubview(signUpTitle)
        
        view.addSubview(signUpRegFieldsContainer)
        signUpRegFieldsContainer.addSubview(iconUser)
        signUpRegFieldsContainer.addSubview(addIconButton)
        signUpRegFieldsContainer.addSubview(nameField)
        signUpRegFieldsContainer.addSubview(emailField)
        signUpRegFieldsContainer.addSubview(passwordField)
        signUpRegFieldsContainer.addSubview(aboutMeField)
        signUpRegFieldsContainer.addSubview(linkField)
        
        view.addSubview(createButtonContainer)
        createButtonContainer.addSubview(createButton)
        createButton.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        
        addIconButton.addTarget(self, action: #selector(addIconButtonAction), for: .touchUpInside)
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
        
        signUpTitleContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signUpRegFieldsContainer.snp.top).offset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        signUpTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        signUpRegFieldsContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(380)
        }
        
        iconUser.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        addIconButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconUser.snp.bottom).offset(10)
        }
        
        nameField.snp.makeConstraints { make in
            make.bottom.equalTo(emailField.snp.top).inset(-10)
            make.left.equalTo(15)
        }
        
        emailField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.left.equalTo(15)
        }
        
        aboutMeField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(14)
            make.left.equalTo(10)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        linkField.snp.makeConstraints { make in
            make.top.equalTo(aboutMeField.snp.bottom).offset(6)
            make.left.equalTo(15)
        }
        
        createButtonContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpRegFieldsContainer.snp.bottom).inset(-10)
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
        guard let icon = iconUser.image,
              let name = nameField.text, !name.isEmpty, name.count >= 3,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 6 else { fieldEmptyAlert(); return }
        
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
                let user = UserModel(name: name, aboutMe: aboutMeField.text!, link: linkField.text!, userID: currentUser)
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
    
    @objc func addIconButtonAction() {
        showImagePicker()
    }
    
    @objc func sliderButtonAction() {
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
        iconUser.image = image
        dismiss(animated: true)
    }
}
