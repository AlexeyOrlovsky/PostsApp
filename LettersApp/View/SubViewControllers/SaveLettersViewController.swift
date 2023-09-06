//
//  SaveLettersViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 14.08.2023.
//

import UIKit
import SnapKit

class SaveLettersViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(label)
        label.text = "Save Letters"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
