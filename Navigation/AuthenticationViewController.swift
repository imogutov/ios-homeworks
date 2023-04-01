//
//  AuthenticationViewController.swift
//  Navigation
//
//  Created by Ivan Mogutov on 04.02.2023.
//

import UIKit
import LocalAuthentication
import Firebase

class AuthenticationViewController: UIViewController {
    
    private enum LocalizedKeys: String {
        case button = "authenticate"
    }
    
    private let authService = LocalAuthorizationService()
    private let authContext = LAContext()
    
    private lazy var button: CustomButton = {
        let button = CustomButton(title: ~LocalizedKeys.button.rawValue, titleColor: .systemBlue)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(auth), for: .touchUpInside)
        return button
    }()
    
    private func setupButton() {
        if authContext.biometryType == .faceID {
            button.setImage(UIImage(systemName: "faceid"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "touchid"), for: .normal)
        }
    }
    
    @objc func auth() {
        authService.canEvaluate { (canEvaluate, _, canEvaluateError) in
            guard canEvaluate else {
                alert(
                    title: "Error",
                    message: canEvaluateError?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                    okActionTitle: "OK!"
                )
                return
            }
            
            authService.evaluate { [weak self] (success, error) in
                guard success else {
                    alert(
                        title: "Error",
                        message: error?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                        okActionTitle: "OK!")
                    return
                }
                
                
                
                
                if Auth.auth().currentUser == nil {
                    let loginVC = LogInViewController()
                    self?.navigationController?.pushViewController(loginVC, animated: true)
                } else {
                    let profileVC = ProfileViewController()
                    self?.navigationController?.pushViewController(profileVC, animated: true)
                }
                
               
            }
        }
        
        
        func alert(
            title: String,
            message: String,
            okActionTitle: String
        ) {
            let alertView = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: okActionTitle,
                style: .default
            )
            alertView.addAction(okAction)
            present(
                alertView,
                animated: true
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        setupButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.tabBarController?.viewControllers?.remove(at: 0)
    }
}
