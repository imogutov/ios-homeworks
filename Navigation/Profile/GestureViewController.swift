import UIKit

class GestureViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView(image: UIImage(named: "cartoon-cat"))
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    
    private lazy var newView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var crossImageView: UIImageView = {
        let crossView = UIImageView()
        crossView.image = UIImage(systemName: "xmark")
        crossView.translatesAutoresizingMaskIntoConstraints = false
        crossView.isHidden = true
        crossView.isUserInteractionEnabled = true
        crossView.layer.masksToBounds = true
        return crossView
    }()
    
    private var avatarImageViewLeading = NSLayoutConstraint()
    private var avatarImageViewTop = NSLayoutConstraint()
    private var avatarImageViewWidth = NSLayoutConstraint()
    private var avatarImageViewHeigh = NSLayoutConstraint()
    private var avatarImageViewXAnchor = NSLayoutConstraint()
    
    private func setupGesture() {
        let avatarTapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        avatarImageView.addGestureRecognizer(avatarTapGesture)
        
        let crossButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(crossButtonTapAction))
        crossImageView.addGestureRecognizer(crossButtonTapGesture)
    }
    
    @objc private func avatarTapAction() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.avatarImageViewTop.constant = (UIScreen.main.bounds.height - UIScreen.main.bounds.width) / 2
            self.avatarImageViewWidth.constant = UIScreen.main.bounds.width
            self.avatarImageViewHeigh.constant = UIScreen.main.bounds.width
            self.avatarImageViewLeading.constant = 0
            self.newView.alpha = 0.5
            self.avatarImageView.layer.cornerRadius = 0
        }, completion: { _ in
            self.crossImageView.isHidden = false
            print("animation")
        })
    }
    
    @objc private func crossButtonTapAction() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.crossImageView.isHidden = true
            self.avatarImageView.layer.cornerRadius = 50
            self.newView.alpha = 0
            self.avatarImageViewTop.constant = 16
            self.avatarImageViewWidth.constant = 100
            self.avatarImageViewHeigh.constant = 100
            self.avatarImageViewLeading.constant = 16
        }, completion: { _ in
            print("animation2")
        })
    }
    
    private func layout() {
        view.backgroundColor = .systemGray
        view.addSubview(newView)
        view.addSubview(avatarImageView)
        view.addSubview(crossImageView)
        
        avatarImageViewLeading = avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        avatarImageViewTop = avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        avatarImageViewHeigh = avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        avatarImageViewWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            avatarImageViewTop, avatarImageViewLeading, avatarImageViewWidth, avatarImageViewHeigh,
            
            newView.topAnchor.constraint(equalTo: view.topAnchor),
            newView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newView.widthAnchor.constraint(equalTo: view.widthAnchor),
            newView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            crossImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            crossImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            crossImageView.heightAnchor.constraint(equalToConstant: 30),
            crossImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupGesture()
    }
}
