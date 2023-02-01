
import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    let userService = CurrentUserService()
    
    private enum LocalizedKeys: String {
        case setYourStatus = "setYourStatus"
        case setStatus = "setStatus"
    }
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = userService.user.avatar
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = userService.user.fullName
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = userService.user.status
        statusLabel.textColor = UIColor.gray
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    private var statusText: String = ""
    
    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.backgroundColor = UIColor.white.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.textColor = UIColor.black
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        statusTextField.placeholder = ~LocalizedKeys.setYourStatus.rawValue
        statusTextField.indent(size: 10)
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        return statusTextField
    }()
    
    private lazy var setStatusButton: CustomButton = {
        let setStatusButton = CustomButton(title: ~LocalizedKeys.setStatus.rawValue, titleColor: .white)
        setStatusButton.backgroundColor = .systemBlue
//        setStatusButton.setTitle("Set status", for: .normal)
//        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        return setStatusButton
    }()
    
    func layout() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
        
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
        
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 5),
        
            statusTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -148),
            statusTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 132),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        layout()
        buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction() {
        setStatusButton.action = { [weak self] in
            print("Status")
            self!.statusLabel.text = self!.statusTextField.text
            
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
        print(statusText)
    }
    
//    @objc func buttonPressed() {
//        print("Status")
//        statusLabel.text = statusTextField.text
//    }
}



