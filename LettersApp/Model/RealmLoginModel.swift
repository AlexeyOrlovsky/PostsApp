//
//  RealmLoginModel.swift
//  LettersApp
//
//  Created by Алексей Орловский on 13.08.2023.
//

import UIKit
import RealmSwift

// to save the user's login state
class RealmLoginModel: Object {
    @Persisted var email = ""
    @Persisted var password = ""
}
