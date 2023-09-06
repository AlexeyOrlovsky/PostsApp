//
//  UserModel.swift
//  LettersApp
//
//  Created by Алексей Орловский on 13.08.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

struct UserModel: Codable, Identifiable {
    var id: String? // @DocumentID, error / AccountViewController / userName
    var name: String
    var aboutMe: String
    var link: String
    var userID: String
    var iconUser: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case aboutMe
        case link
        case userID
        case iconUser
    }
}
