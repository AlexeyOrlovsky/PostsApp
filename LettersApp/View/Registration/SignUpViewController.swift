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
    
    let signUpLabelContainer: UIView = {
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
    
    let regContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "regContainerColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let userIconImage: UIImageView = {
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
    
    let textfieldName: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    
    let textfieldEmail: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    
    let deleteButtonPassword: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return button
    }()
    
    
    let textfieldPassword: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    
    let deleteButtonRepeatPass: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return button
    }()
    
    let textfieldRepeatPassword: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString( string: "Repeat password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    
    let textViewAboutMe: UITextView = {
        let textView = UITextView()
        textView.text = "Hello"
        textView.attributedText = NSAttributedString( string: "About me...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        return textView
    }()
    
    let textfieldTag: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString( string: "#tag", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)])
        textfield.font = .systemFont(ofSize: 20, weight: .bold)
        textfield.textColor = UIColor(red: 118/255, green: 117/255, blue: 117/255, alpha: 1)
        return textfield
    }()
    
    let createLabelContainer: UIView = {
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
        
        view.addSubview(signUpLabelContainer)
        signUpLabelContainer.addSubview(signUpLabel)
        
        view.addSubview(regContainer)
        regContainer.addSubview(userIconImage)
        regContainer.addSubview(addIconButton)
        regContainer.addSubview(textfieldName)
        regContainer.addSubview(textfieldEmail)
        
        regContainer.addSubview(textfieldPassword)
        regContainer.addSubview(deleteButtonPassword)
        
        regContainer.addSubview(textfieldRepeatPassword)
        regContainer.addSubview(deleteButtonRepeatPass)
        
        regContainer.addSubview(textViewAboutMe)
        regContainer.addSubview(textfieldTag)
        
        view.addSubview(createLabelContainer)
        createLabelContainer.addSubview(createButton)
        
        deleteButtonPassword.addTarget(self, action: #selector(actionDeleteButtonPassword), for: .touchUpInside)
        deleteButtonRepeatPass.addTarget(self, action: #selector(actionDeleteButtonRepeatPass), for: .touchUpInside)
        sliderButton.addTarget(self, action: #selector(actionSliderButton), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        addIconButton.addTarget(self, action: #selector(selectPhotoButtonTapped), for: .touchUpInside)
    }
    
    private func delegatesAndDataSourses() {
        textfieldName.delegate = self
        textfieldEmail.delegate = self
        textfieldPassword.delegate = self
        textfieldRepeatPassword.delegate = self
        textViewAboutMe.delegate = self
        textfieldTag.delegate = self
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
        
        signUpLabelContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(regContainer.snp.top).inset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        regContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(160)
            make.width.equalTo(320)
            make.height.equalTo(460)
        }
        
        userIconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        addIconButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userIconImage.snp.bottom).offset(12)
        }
        
        textfieldName.snp.makeConstraints { make in
            make.top.equalTo(addIconButton.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(30)
        }
        
        textfieldEmail.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(textfieldName.snp.bottom).offset(12)
        }
        
        textfieldPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(textfieldEmail.snp.bottom).offset(12)
        }
        
        deleteButtonPassword.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(textfieldEmail.snp.bottom).offset(12)
        }
        
        textfieldRepeatPassword.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(textfieldPassword.snp.bottom).offset(12)
        }
        
        deleteButtonRepeatPass.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(textfieldPassword.snp.bottom).offset(12)
        }
        
        textViewAboutMe.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(26)
            make.top.equalTo(textfieldRepeatPassword.snp.bottom).offset(12)
            make.width.equalTo(280)
            make.height.equalTo(80)
        }
        
        textfieldTag.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(textViewAboutMe.snp.bottom).offset(12)
        }
        
        createLabelContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(regContainer.snp.bottom).inset(-10)
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
        guard let icon = userIconImage.image,
              let name = textfieldName.text, !name.isEmpty, name.count >= 3,
              let email = textfieldEmail.text, !email.isEmpty,
              let password = textfieldPassword.text, !password.isEmpty, password.count >= 6 else { fieldEmptyAlert(); return }
        
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
                let user = UserModel(name: name, aboutMe: textViewAboutMe.text!, link: textfieldTag.text!, userID: currentUser)
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
    
    @objc func actionDeleteButtonPassword() {
        textfieldPassword.text = ""
    }
    
    @objc func actionDeleteButtonRepeatPass() {
        textfieldRepeatPassword.text = ""
    }
    
    @objc func selectPhotoButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
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
        userIconImage.image = image
        dismiss(animated: true)
    }
}

/// UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate, UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
