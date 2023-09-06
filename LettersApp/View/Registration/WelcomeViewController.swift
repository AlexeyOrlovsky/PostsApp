//
//  WelcomeViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 17.08.2023.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    // Creating arrays of colors and texts
    let backgroundColors: [UIColor] = [
        UIColor(red: 13/255, green: 39/255, blue: 123/255, alpha: 1),
        UIColor(red: 23/255, green: 200/255, blue: 158/255, alpha: 1),
        UIColor(red: 114/255, green: 24/255, blue: 56/255, alpha: 1),
        UIColor(red: 28/255, green: 200/255, blue: 42/255, alpha: 1),
        UIColor(red: 69/255, green: 16/255, blue: 122/255, alpha: 1),
        UIColor(red: 200/255, green: 182/255, blue: 22/255, alpha: 1)
    ]
    let textColors: [UIColor] = [
        UIColor(red: 200/255, green: 182/255, blue: 22/255, alpha: 1),
        UIColor(red: 69/255, green: 16/255, blue: 122/255, alpha: 1),
        UIColor(red: 28/255, green: 200/255, blue: 42/255, alpha: 1),
        UIColor(red: 13/255, green: 39/255, blue: 123/255, alpha: 1),
        UIColor(red: 23/255, green: 200/255, blue: 158/255, alpha: 1),
        UIColor(red: 114/255, green: 24/255, blue: 56/255, alpha: 1)
    ]
    let texts: [String] = ["I Know!", "Letters", "World!", "Hello", "Good", "My", "What?"]
    
    let mainText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    
    let authView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 30
        return view
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = CGColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        return button
    }()
    
    let appleRegButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple", for: .normal)
        button.backgroundColor = UIColor(named: "SecondColor")
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        viewAnimations()
    }
    
    func addSubviews() {
        view.addSubview(mainText)
        
        view.addSubview(authView)
        authView.addSubview(signInButton)
        authView.addSubview(signUpButton)
        authView.addSubview(appleRegButton)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        appleRegButton.addTarget(self, action: #selector(appleRegButtonAction), for: .touchUpInside)
        
    }
    
    func viewAnimations() {
        view.backgroundColor = backgroundColors[0]
        mainText.textColor = textColors[0]
        mainText.text = texts[0]
        
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [self] timer in
            currentIndex = (currentIndex + 1) % backgroundColors.count
            animateViewChanges(to: currentIndex)
        }
    }
    
    func animateViewChanges(to index: Int) {
        UIView.animate(withDuration: 1.5) { [self] in
            view.backgroundColor = backgroundColors[index]
            mainText.textColor = textColors[index]
            mainText.text = texts[index]
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainText.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(300)
            make.centerX.equalToSuperview()
        }
        
        authView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(260)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signUpButton.snp.top).offset(-10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        appleRegButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
    }
}

// @objc funcs
extension WelcomeViewController {
    
    @objc func signUpButtonAction() {
        let vc = SignInViewController()
        present(vc, animated: true)
    }
    
    @objc func signInButtonAction() {
        let vc = SignUpViewController()
        present(vc, animated: true)
    }
    
    @objc func appleRegButtonAction() {
        print("appleRegButtonAction tapped")
    }
}
