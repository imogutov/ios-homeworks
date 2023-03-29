
import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    private let storage = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid ?? "uid"
    
    let profileHeaderView = ProfileHeaderView()
    
    let firestoreManager = FirestoreManager()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        return button
    }()
    
    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeAvatarPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        return button
    }()
    
    @objc private func buttonPressed() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        let loginVC = LogInViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
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
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileHeaderView)
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            profileHeaderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            //            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(changeAvatarButton)
        NSLayoutConstraint.activate([
            changeAvatarButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            //            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            changeAvatarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    @objc private func changeAvatarPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        if section == 0 {
    //            let header = ProfileHeaderView()
    //
    //            return header
    //        } else {
    //            return nil
    //        }
    //    }
}


extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        } else {
            return firestoreManager.posts.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = "Добавить пост"
            return cell
        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            let post = firestoreManager.posts[indexPath.row]
//            let dateFormatter = DateFormatter()
//            cell.textLabel?.text = "\(post.author) - \(post.description)"
//            cell.detailTextLabel?.text = dateFormatter.string(from: post.date)
//            return cell
            
                        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
                        cell.setupCell(post: firestoreManager.posts[indexPath.row])
            
                        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            //            present(photosViewController, animated: true)
            navigationController?.pushViewController(photosViewController, animated: true)
        }
        if indexPath.section == 1 {
            let createPostVC = CreatePostViewController()
            navigationController?.pushViewController(createPostVC, animated: true)
        }
    }
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        //        photoImageView.image = image
        guard let imageData = image.pngData() else { return }
        
        
        
        
        let uploadTask = storage.child("avatars/\(uid)/avatar.png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print("Ошибка загрузки")
                return
            }
        })
        
        uploadTask.resume()
        uploadTask.observe(.success, handler: {_ in
            
            NotificationCenter.default.post(name: NSNotification.Name("avatarLoaded"), object: nil)
            
        })
        
    }
}





