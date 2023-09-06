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
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let letterText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    let publicationDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .black)
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
        
        contentView.addSubview(iconUser)
        contentView.addSubview(nameUser)
        contentView.addSubview(letterText)
        contentView.addSubview(publicationDate)
        contentView.addSubview(letterImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconUser.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        nameUser.snp.makeConstraints { make in
            make.centerY.equalTo(iconUser.snp.centerY)
            make.left.equalTo(iconUser.snp.right).offset(10)
        }
        
        publicationDate.snp.makeConstraints { make in
            make.top.equalTo(nameUser.snp.bottom).offset(2)
            make.left.equalTo(iconUser.snp.right).offset(10)
            make.width.equalTo(280)
        }
        
        letterText.snp.makeConstraints { make in
            make.top.equalTo(publicationDate.snp.bottom).offset(10)
            make.left.equalTo(iconUser.snp.right).offset(10)
            make.width.equalTo(280)
        }
        
//        letterImage.snp.makeConstraints { make in
//            make.top.equalTo(letterText.snp.bottom).offset(10)
//            make.left.equalTo(iconUser.snp.right).offset(10)
//            make.width.equalTo(320)
//            make.height.equalTo(400)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with letter: LetterModel) {
        nameUser.text = letter.userName
        letterText.text = letter.text
        publicationDate.text = letter.publicationDate
        
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
    }
}
