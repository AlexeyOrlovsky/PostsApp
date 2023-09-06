//
//  LetterModel.swift
//  LettersApp
//
//  Created by Алексей Орловский on 15.08.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

struct LetterModel: Codable, Identifiable, Equatable {
    var id: String?
    var text: String?
    var userID: String?
    var userName: String?
    var iconUser: String?
    var publicationDate: String?
    var letterImage: String?
    
    enum CodingKeys: CodingKey {
        case id
        case text
        case userID
        case userName
        case iconUser
        case publicationDate
        case letterImage
    }
}
