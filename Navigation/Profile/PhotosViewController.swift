
import UIKit
import Firebase
import FirebaseStorage


class PhotosViewController: UIViewController {

    private lazy var photos = userImages
    
    private let urlsArray: [String] = []
    
    private let storage = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid ?? "uid"
    
    private enum LocalizedKeys: String {
        case photoGallery = "photoGallery"
    }
    
    var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        return photoImageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сменить аватар", style: .plain, target: self, action: #selector(photoButtonPressed))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        //        imagePublisherFacade?.removeSubscription(for: self)
        //        imagePublisherFacade?.rechargeImageLibrary()
    }
    
    private func layout() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        self.navigationController?.navigationBar.isHidden = false
        self.title = ~LocalizedKeys.photoGallery.rawValue
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    @objc private func photoButtonPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 8 * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotosCollectionViewCell
        //                cell.setupPhoto(photos: photosData[indexPath.item])
        cell.photo.image = photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
}



//extension PhotosViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
//        photos = images
//        collectionView.reloadData()
//    }
//}

extension PhotosViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
            self.storage.child("avatars/\(self.uid)/avatar.png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else { return }
                
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "avatarURL")
                UserDefaults.standard.set([urlString], forKey: "\(self.uid)")
                print(UserDefaults.standard.value(forKey: "\(self.uid)") ?? "nil")
            })
        })
        
        uploadTask.resume()
        uploadTask.observe(.success, handler: {_ in
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        })
    }
}

