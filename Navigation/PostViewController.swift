
import UIKit

class PostViewController: UIViewController {
    
    @objc private func buttonAction1() {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true)
    }
    
    
    private func setupView() {
        let button = UIBarButtonItem(title: "Delete post", style: .plain, target: self, action: #selector(buttonAction1))
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = titlePost
        self.navigationItem.rightBarButtonItem = button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    var titlePost: String = "My post"
}
