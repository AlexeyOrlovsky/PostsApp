//
//  LetterModelExtension.swift
//  LettersApp
//
//  Created by Алексей Орловский on 16.08.2023.
//

import UIKit
import FirebaseFirestore

extension LetterModel {
    static func build(from documents: [QueryDocumentSnapshot]) -> [LetterModel] {
        return documents.compactMap { document in
            let id = document["id"] as? String ?? ""
            let text = document["text"] as? String ?? ""
            let userID = document["userID"] as? String ?? ""
            let userName = document["userName"] as? String ?? ""
            let publicationDate = document["publicationDate"] as? String ?? ""
            
            return LetterModel(id: id, text: text, userID: userID, userName: userName, publicationDate: publicationDate)
        }
    }
}
