
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    //    private var imagePublisherFacade: ImagePublisherFacade?
    private lazy var photos = userImages
    
    private enum LocalizedKeys: String {
        case photoGallery = "photoGallery"
    }
    
    private var timer: Timer?
    private var countInMilliseconds: Double = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        //        imagePublisherFacade?.subscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        //        imagePublisherFacade = ImagePublisherFacade()
//        startTimer()
//        ImageProcessor().processImagesOnThread(sourceImages: photos, filter: .colorInvert, qos: .utility) { filtres in
//            self.photos.removeAll()
//            for photo in filtres {
//                guard let photo = photo else { return }
//                self.photos.append(UIImage(cgImage: photo))
//            }
//            DispatchQueue.main.async {
//                self.stopTimer()
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(counter),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func stopTimer(){
        timer?.invalidate()
        print("\(countInMilliseconds) seconds")
    }
    
    @objc private func counter() {
        countInMilliseconds += 0.01
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



