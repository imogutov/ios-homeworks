
import UIKit
import FirebaseStorage

class PostTableViewCell: UITableViewCell {
    
    let storage = Storage.storage()
    
    private enum LocalizedKeys: String {
        case likes = "likes"
        case views = "views"
    }
    
    private let inCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stringUrlImage = ""
    
    private let imagePostView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .black
        
        return view
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.createColor(lightMode: .systemGray, darkMode: .lightGray)
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        getImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImage() {
        
        // Create a reference to the file you want to download
        let avatarRef = storage.reference().child("pictures/\(stringUrlImage).png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        avatarRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.imagePostView.image = image
            }
        }
        
        
//        let url = URL(string: stringUrlImage)
//
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return }
//
//            guard let imageData = data else {
//                print("imagedata is nil")
//                return }
//
//            let image = UIImage(data: imageData)
//            self.imagePostView.image = image
//        }
        
//        let ref = Storage.storage().reference(forURL: stringUrlImage)
//        ref.getData(maxSize: 3 * 1024 * 1024) { data, error in
//            guard error == nil else { return }
//
//            guard let imageData = data else { return }
//            let image = UIImage(data: imageData)
//            self.imagePostView.image = image
//        }
    }
    
    func setupCell(post: Post) {
       
        
//        imagePostView.image = UIImage(named: "\(post.image)")
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        dateLabel.text = post.date.formatted()
        stringUrlImage = post.image
//        viewsLabel.text = "\(~LocalizedKeys.views.rawValue): \(post.views)"
//        imagePostView.image = filterImage(imagePostView.image!)
    }
    
    private func layout() {
        
        contentView.addSubview(inCellView)
        NSLayoutConstraint.activate([
            inCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            inCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            inCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            inCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: inCellView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: inCellView.trailingAnchor, constant: -16),
        ])
        
        contentView.addSubview(imagePostView)
        NSLayoutConstraint.activate([
            imagePostView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            imagePostView.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor),
            imagePostView.trailingAnchor.constraint(equalTo: inCellView.trailingAnchor),
            imagePostView.heightAnchor.constraint(equalTo: inCellView.widthAnchor),
            imagePostView.widthAnchor.constraint(equalTo: inCellView.widthAnchor)
        ])
        
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imagePostView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: inCellView.trailingAnchor, constant: -16)
        ])
        
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -16)

        ])
//
//        contentView.addSubview(viewsLabel)
//        NSLayoutConstraint.activate([
//            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//            viewsLabel.trailingAnchor.constraint(equalTo: inCellView.trailingAnchor, constant: -16),
//            viewsLabel.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -16)
//        ])
    }
}

