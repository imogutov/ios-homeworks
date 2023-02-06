
import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    private enum LocalizedKeys: String {
        case likes = "likes"
        case views = "views"
    }
    
    private let inCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.createColor(lightMode: .systemGray, darkMode: .lightGray)
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func filterImage(_ sourceImage: UIImage) -> UIImage {
            let imageProcessor = ImageProcessor()
            var image = UIImage()
        imageProcessor.processImage(sourceImage: sourceImage, filter: .posterize, completion: { filteredImage in
                image = filteredImage ?? sourceImage
            })
            return image
        }
    
    func setupCell(post: Post) {
        imagePostView.image = UIImage(named: "\(post.image)")
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        likesLabel.text = "\(~LocalizedKeys.likes.rawValue): \(post.likes)"
        viewsLabel.text = "\(~LocalizedKeys.views.rawValue): \(post.views)"
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
        
        contentView.addSubview(likesLabel)
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -16)
            
        ])
        
        contentView.addSubview(viewsLabel)
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: inCellView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -16)
        ])
    }
}

