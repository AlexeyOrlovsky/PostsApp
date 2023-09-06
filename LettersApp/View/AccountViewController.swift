//
//  AccountViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 14.08.2023.
//

import UIKit
import SnapKit
import RealmSwift
import Firebase
import Kingfisher
import FirebaseAuth
import FirebaseStorage

class AccountViewController: UIViewController {
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    var serviceLetters: LetterService?
    var letters = [LetterModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var allLetters = [LetterModel]() {
        didSet {
            DispatchQueue.main.async {
                self.letters = self.allLetters
            }
        }
    }
    
    /// UI Elements
    let userInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let userIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        return image
    }()
    
    var userName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let letterLabel: UILabel = {
        let label = UILabel()
        label.text = "Letters"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddSubviews()
        setupViewDidLoad()
        setupTableView()
        configureUserData()
    }

    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: #selector(rightBarButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem?.tintColor = .gray
    }
    
    func setupAddSubviews() {
        view.addSubview(userInfoContainer)
        userInfoContainer.addSubview(userIcon)
        userInfoContainer.addSubview(userName)
        
        view.addSubview(letterLabel)
        view.addSubview(tableView)
    }
    
    func setupTableView() {
        tableView.register(LettersTableViewCell.self, forCellReuseIdentifier: LettersTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(fetchingLastData), for: .valueChanged)
    }
    
    func configureUserData() {
        if let userData = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(UserModel.self, from: userData) {
            userName.text = user.name
            loadUserIcon(from: user.iconUser)
        }
        
        loadRealmUserIcon()
    }
    
    func loadUserIcon(from urlString: String?) {
        guard let iconURL = URL(string: urlString ?? "") else { return }
        
        // Load user icon from URL using Kingfisher library
        userIcon.kf.setImage(with: iconURL)
    }
    
    func loadRealmUserIcon() {
        let realm = try? Realm()
        
        if let iconData = realm?.objects(RealmUserIconModel.self).first,
           let iconUser = iconData.iconUser,
           let image = UIImage(data: iconUser) {
            userIcon.image = image
        }
    }
    
    func fetchData() {
        let serviceLetters = LetterService() // Instantiate LetterService
        
        serviceLetters.getDocuments(collectionID: "Letters") { [weak self] result in
            switch result {
            case .success(let letters):
                self?.allLetters = letters
            case .failure(let error):
                print("Error fetchingData: \(error)")
            }
        }
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userInfoContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(340)
            make.height.equalTo(180)
        }
        
        userIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        userName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userIcon.snp.bottom).offset(10)
        }
        
        letterLabel.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(letterLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

/// @objc funcs
extension AccountViewController {
    
    @objc func rightBarButtonAction() {
        let vc = SaveLettersViewController()
        present(vc, animated: true)
    }
    
    @objc func leftBarButtonAction() {
        let alert = UIAlertController(title: "Leave?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            
            let realm = try? Realm()
            if let user = realm?.objects(RealmLoginModel.self).first {
                try? realm?.write {
                    realm?.delete(user)
                }
            }
            NavigationManager.shared.showNotAuthUserStage()
        }))
        present(alert, animated: true)
    }
    
    @objc func fetchingLastData() {
        fetchData()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

/// UITableViewDelegate & UITableViewDataSource
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LettersTableViewCell.identifier, for: indexPath) as? LettersTableViewCell else { fatalError() }
        cell.configure(with: letters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
