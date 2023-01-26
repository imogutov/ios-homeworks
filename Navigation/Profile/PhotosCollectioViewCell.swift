
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    let photo: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
   func setupPhoto(photos: Photo) {
        photo.image = UIImage(named: "\(photos.imageName)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photo)

        photo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photo.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photo.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


