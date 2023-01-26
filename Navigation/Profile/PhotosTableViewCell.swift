

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private enum LocalizedKeys: String {
        case photos = "photos"
    }
    
    private let inCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "arrow.right")
        view.tintColor = .black
        return view
    }()
    
    private let image0PostView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "photo1")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let image1PostView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "photo2")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let image2PostView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "photo3")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let image3PostView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "photo4")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = ~LocalizedKeys.photos.rawValue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    private func layout() {
        
        contentView.addSubview(inCellView)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(photosLabel)
        contentView.addSubview(image0PostView)
        contentView.addSubview(image1PostView)
        contentView.addSubview(image2PostView)
        contentView.addSubview(image3PostView)
        
        NSLayoutConstraint.activate([
            inCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            inCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            inCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            inCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: inCellView.trailingAnchor, constant: -12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            photosLabel.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: inCellView.topAnchor, constant: 12),
            
            image0PostView.leadingAnchor.constraint(equalTo: inCellView.leadingAnchor, constant: 12),
            image0PostView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image0PostView.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -12),
            image0PostView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            image0PostView.heightAnchor.constraint(equalTo: image0PostView.widthAnchor),
            
            image1PostView.leadingAnchor.constraint(equalTo: image0PostView.trailingAnchor, constant: 8),
            image1PostView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image1PostView.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -12),
            image1PostView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            image1PostView.heightAnchor.constraint(equalTo: image1PostView.widthAnchor),
            
            image2PostView.leadingAnchor.constraint(equalTo: image1PostView.trailingAnchor, constant: 8),
            image2PostView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image2PostView.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -12),
            image2PostView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            image2PostView.heightAnchor.constraint(equalTo: image2PostView.widthAnchor),
            
            image3PostView.leadingAnchor.constraint(equalTo: image2PostView.trailingAnchor, constant: 8),
            image3PostView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            image3PostView.bottomAnchor.constraint(equalTo: inCellView.bottomAnchor, constant: -12),
            image3PostView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            image3PostView.heightAnchor.constraint(equalTo: image3PostView.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

