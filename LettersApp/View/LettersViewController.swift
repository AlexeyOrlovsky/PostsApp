//
//  LettersViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 13.08.2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

class LettersViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupViewDidLoad()
        setupTableView()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Letters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Write", style: .done, target: self, action: #selector(rightBarButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(LettersTableViewCell.self, forCellReuseIdentifier: LettersTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(fetchingLastData), for: .valueChanged)
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
}

/// UITableViewDelegate & UITableViewDataSource
extension LettersViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = letters[indexPath.row]
            deletePost(post)
        }
    }
    
    func deletePost(_ letter: LetterModel) {
        if let userData = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(UserModel.self, from: userData) {
            if user.userID == letter.userID {
                guard let postID = letter.id else {
                    print("Error: Post id nil")
                    return
                }
                
                let postRef = Firestore.firestore().collection("Letters").document(postID)
                postRef.delete { error in
                    if let error = error {
                        print("Error deleting document: \(error)")
                    } else {
                        print("Document successfully deleted.")
                        if let index = self.letters.firstIndex(of: letter) {
                            self.letters.remove(at: index)
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                notYourLetter()
                print("This is not your post")
            }
        }
    }
}

/// @objc funcs
extension LettersViewController {
    
    @objc func fetchingLastData() {
        fetchData()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func rightBarButtonAction() {
        let vc = UINavigationController(rootViewController: NewLetterViewController())
        present(vc, animated: true)
    }
}

/// Alerts
extension LettersViewController {
    
    func notYourLetter() {
        let alert = UIAlertController(title: "Not Your Letter!", message: "You can't remove it", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}
