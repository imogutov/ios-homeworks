
import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Кнопка 1", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var button1: UIButton = {
        let button1 = UIButton()
        button1.backgroundColor = .systemBlue
        button1.setTitle("Кнопка 2", for: .normal)
        button1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button1
    }()
    
    let stackView = UIStackView()
    
    @objc private func buttonPressed() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = "Заголовок поста"
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        addButtonsToStackView()
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func addButtonsToStackView() {
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(button1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureStackView()
    }
}
