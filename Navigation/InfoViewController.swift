
import UIKit

class InfoViewController: UIViewController {
    
    
    @objc private func buttonAction2() {
        
        let alert = UIAlertController(title: "Notice", message: "Do you really want to delete your post?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            print("Нажато Delete")
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            print("Нажато OK")
            
        }))
        
        present(alert, animated: true)
        
    }
    
    
    private lazy var button: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        
        button.setTitle("Delete post", for: .normal)
        
        button.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    private func setupButton() {
        
        self.view.addSubview(self.button)
        
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray5
        
        setupButton()
    }
    
}
