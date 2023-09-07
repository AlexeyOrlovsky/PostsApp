//
//  NewLetterViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 14.08.2023.
//

import UIKit
import SnapKit
import Firebase
import Kingfisher
import RealmSwift
import FirebaseAuth
import FirebaseFirestore

class NewLetterViewController: UIViewController {
    
    var userName = ""
    var currentUser = ""
    var userIcon: UIImage?
    
    /// UI Elements
    let writeLetter: UITextView = {
        let field = UITextView()
        field.textColor = .gray
        field.font = .systemFont(ofSize: 18, weight: .semibold)
        field.showsVerticalScrollIndicator = false
        field.becomeFirstResponder()
        return field
    }()
    
    let addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    var letterCreated: ((LetterModel) -> Void)? // letter created, get LetterModel return Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddSubviews()
        setupViewDidLoad()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        
        title = "New Letter"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(rightBarButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    func setupAddSubviews() {
        view.addSubview(writeLetter)
        view.addSubview(addImageButton)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        writeLetter.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(360)
            make.height.equalTo(340)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.top.equalTo(writeLetter.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(16)
        }
    }
}

/// @objc funcs
extension NewLetterViewController {
    
    @objc func rightBarButtonAction() {
        if writeLetter.text.isEmpty {
            showFillFieldAlert()
        } else {
            createUserAndPostLetter()
        }
    }
    
    func createUserAndPostLetter() {
        if let userData = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(UserModel.self, from: userData) {
            let currentUser = user.userID
            let userName = user.name
            
            createPost(userID: currentUser, userName: userName)
        }
    }
    
    func getUserIcon(completion: @escaping (Data?) -> Void) {
        let realm = try? Realm()
        
        if let iconData = realm?.objects(RealmUserIconModel.self).first,
           let iconUser = iconData.iconUser {
            completion(iconUser)
        } else {
            completion(nil)
        }
    }
    
    func uploadImageToStorage(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { completion(nil); return }

        let storageRef = Storage.storage().reference().child("user_Icons").child(UUID().uuidString + ".jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error)")
                completion(nil)
                return
            }

            storageRef.downloadURL { url, error in
                if let url = url {
                    completion(url.absoluteString)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func createPost(userID: String, userName: String) {
        getUserIcon { [self] iconData in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let currentTime = dateFormatter.string(from: Date())
            
            if let iconData = iconData, let iconImage = UIImage(data: iconData) {
                uploadImageToStorage(image: iconImage) { [self] imageUrl in
                    let letter = LetterModel(text: writeLetter.text, userID: userID, userName: userName, iconUser: imageUrl, publicationDate: currentTime)
                    
                    createDocumentAtFirestore(letter) { newLetter in
                        self.letterCreated?(newLetter)
                    }
                }
            } else {
                let letter = LetterModel(text: writeLetter.text, userID: userID, userName: userName, iconUser: nil, publicationDate: currentTime)
                
                createDocumentAtFirestore(letter) { newLetter in
                    self.letterCreated?(newLetter)
                }
            }
        }
    }
    
    func createDocumentAtFirestore(_ letter: LetterModel, completion: @escaping (LetterModel) -> Void) {
        var letter = letter
        let document = Firestore.firestore().collection("Letters").document()
        letter.id = document.documentID

        let documentData: [String: Any] = [
            "id": letter.id ?? "Error id",
            "text": letter.text ?? "No text",
            "userID": letter.userID ?? "No userID",
            "iconUser": letter.iconUser ?? "No icon",
            "userName": letter.userName ?? "No userName",
            "publicationDate": letter.publicationDate ?? "No date"
        ]

        document.setData(documentData) { error in
            if let error = error {
                print("Error creating document: \(error)")
            } else {
                print("Document created")
                completion(letter)
            }
        }
        
        dismiss(animated: true)
    }
    
    @objc func leftBarButtonAction() {
        dismiss(animated: true)
    }
}

/// Alerts
extension NewLetterViewController {
    func showFillFieldAlert() {
        let alert = UIAlertController(title: "Text field is empty!", message: "Fill in the field", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
