//
//  SportClubCollectionViewCell.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import UIKit
import Sports_Entities

class SportClubCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    private lazy var badgeImageView: UIImageView = {
        let badgeImageView = UIImageView()
        badgeImageView.translatesAutoresizingMaskIntoConstraints = false
        badgeImageView.contentMode = .scaleAspectFill
        badgeImageView.clipsToBounds = true
        badgeImageView.image = UIImage(named: "footballPlaceholderImage")
        return badgeImageView
    }()
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        configureViews()
    }
    
    // MARK: - Configure
    
    func configureViews() {
        contentView.addSubview(badgeImageView)
        
        NSLayoutConstraint.activate([
            badgeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
            badgeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            badgeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0),
            badgeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.0)
        ])
    }
    
    func configure(with sportClub: SportClub) {
        configureImage(with: sportClub.badgeImageURL)
    }
    
    private func configureImage(with imageURL: URL) {
        badgeImageView.setImageFromURL(imageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.badgeImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUi()
    }
    
    private func cleanUi() {
        badgeImageView.image = UIImage(named: "footballPlaceholderImage")
    }
}
