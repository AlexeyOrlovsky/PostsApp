//
//  CustomLettersTableViewCell.swift
//  LettersApp
//
//  Created by Алексей Орловский on 14.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

class LettersTableViewCell: UITableViewCell {
    static let identifier = "CustomLettersTableViewCell"
    
    /// UI Elements
    let iconUser: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = UIView.ContentMode.scaleAspectFit
        return image
    }()
    
    let nameUser: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    let letterText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let publicationDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    let letterImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray
        image.layer.cornerRadius = 20
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // contentView.addSubview(iconUser)
        contentView.addSubview(nameUser)
        contentView.addSubview(letterText)
        contentView.addSubview(publicationDate)
        // contentView.addSubview(letterImage)
    }
    
    /// Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameUser.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.lessThanOrEqualTo(letterText.snp.top)
        }

        publicationDate.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(4)
            make.right.equalToSuperview().inset(10)
            make.top.lessThanOrEqualTo(letterText.snp.bottom)
        }
        
        letterText.snp.makeConstraints { make in
            make.top.equalTo(nameUser.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with letter: LetterModel) {
        nameUser.text = letter.userName
        letterText.text = letter.text
        publicationDate.text = letter.publicationDate
        
        // error
        if let imageUrlString = letter.iconUser, let imageUrl = URL(string: imageUrlString) {
            iconUser.kf.setImage(with: imageUrl) { result in
                switch result {
                case .success(let value):
                    let image = value.image
                    self.iconUser.image = image
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        }
        
        layoutSubviews()
    }
}
