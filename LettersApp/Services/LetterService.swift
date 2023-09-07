//
//  LetterService.swift
//  LettersApp
//
//  Created by Алексей Орловский on 16.08.2023.
//

import UIKit
import FirebaseFirestore

class LetterService {
    let database = Firestore.firestore()
    
    func getDocuments(collectionID: String, completion: @escaping (Result<[LetterModel], Error>) -> Void) {
        let collection = database.collection(collectionID).order(by: "publicationDate", descending: true)
        
        collection.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let letters = self.parseDocuments(from: snapshot)
            completion(.success(letters))
        }
    }
    
    private func parseDocuments(from snapshot: QuerySnapshot?) -> [LetterModel] {
        var letters = [LetterModel]()
        snapshot?.documents.forEach { document in
            if let letter = parseLetter(from: document.data()) {
                letters.append(letter)
            }
        }
        return letters
    }
    
    private func parseLetter(from data: [String: Any]) -> LetterModel? {
        guard let id = data["id"] as? String,
              let text = data["text"] as? String,
              let userID = data["userID"] as? String,
              let userName = data["userName"] as? String,
              let publicationDate = data["publicationDate"] as? String else { return nil }
        
        let letter = LetterModel(id: id, text: text, userID: userID, userName: userName, publicationDate: publicationDate)
        return letter
    }
}
