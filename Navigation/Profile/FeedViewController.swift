
import UIKit
import Firebase
import FirebaseStorage

class FeedViewController: UIViewController {
    
    private let storage = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid ?? "uid"
    
    let firestoreManager = FirestoreManager()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.isHidden = true
        navigationItem.title = "Latest users posts"
//        navigationItem.largeTitleDisplayMode = .always
        
        layout()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        
    }
    
    func reloadData() {
        firestoreManager.reloadPosts() { errorString in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return firestoreManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.setupCell(post: firestoreManager.posts[indexPath.row])
            
            return cell
        
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Latest users posts"
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            let photosViewController = PhotosViewController()
//            //            present(photosViewController, animated: true)
//            navigationController?.pushViewController(photosViewController, animated: true)
//        }
//        if indexPath.section == 1 {
//            let createPostVC = CreatePostViewController()
//            navigationController?.pushViewController(createPostVC, animated: true)
//        }
//    }
}





