//
//  RealmUserIconModel.swift
//  LettersApp
//
//  Created by Алексей Орловский on 14.08.2023.
//

import UIKit
import RealmSwift

// saving user-added icon
class RealmUserIconModel: Object {
    @Persisted var iconUser: Data?
}
