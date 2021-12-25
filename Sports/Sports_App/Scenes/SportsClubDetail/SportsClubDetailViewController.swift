//
//  SportsClubDetailViewController.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit
import Sports_Entities

class SportsClubDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var detailsVerticalStackView: UIStackView = {
        let detailsVerticalStackView = UIStackView()
        detailsVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsVerticalStackView.axis = .vertical
        detailsVerticalStackView.alignment = .fill
        detailsVerticalStackView.distribution = .fillProportionally
        detailsVerticalStackView.spacing = 16.0
        return detailsVerticalStackView
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.contentMode = .scaleAspectFit
        bannerImageView.clipsToBounds = true
        bannerImageView.image = UIImage(named: "footballPlaceholderImage")
        bannerImageView.isHidden = true
        return bannerImageView
    }()
        
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.isHidden = true
        return descriptionLabel
    }()
        
    private lazy var leagueLabel: UILabel = {
        let leagueLabel = UILabel()
        leagueLabel.translatesAutoresizingMaskIntoConstraints = false
        leagueLabel.adjustsFontForContentSizeCategory = true
        leagueLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
        leagueLabel.textColor = .darkText
        leagueLabel.textAlignment = .right
        leagueLabel.numberOfLines = 1
        leagueLabel.isHidden = true
        return leagueLabel
    }()
    
    private lazy var countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.adjustsFontForContentSizeCategory = true
        countryLabel.font = .systemFont(ofSize: 12.0, weight: .heavy)
        countryLabel.textColor = .secondaryLabel
        countryLabel.numberOfLines = 1
        countryLabel.isHidden = true
        return countryLabel
    }()
    
    private lazy var stadiumLabel: UILabel = {
        let stadiumLabel = UILabel()
        stadiumLabel.translatesAutoresizingMaskIntoConstraints = false
        stadiumLabel.adjustsFontForContentSizeCategory = true
        stadiumLabel.font = .systemFont(ofSize: 12.0, weight: .semibold)
        stadiumLabel.textColor = .label
        stadiumLabel.numberOfLines = 1
        stadiumLabel.isHidden = true
        return stadiumLabel
    }()

    // MARK: - Dependencies
    
    private lazy var interactor: SportsClubDetailInteractable = SportsClubDetailInteractor(presenter: SportsClubDetailPresenter(displayer: self))
    private lazy var internalRouter: SportsClubDetailRoutable & Router = SportsClubDetailRouter(viewController: self)
    private var viewModel: SportsClubDetailModels.ViewModel?
    
    // MARK: - Vars
    
    var searchSportsClubName: String!
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        interactor.load(searchedSportsClubName: searchSportsClubName)
    }
    
    // MARK: - Configure
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = UILayoutPriority(rawValue: 750)
        contentViewHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentViewHeightConstraint
        ])
        
        contentView.addSubview(detailsVerticalStackView)
        NSLayoutConstraint.activate([
            detailsVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            detailsVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            detailsVerticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            detailsVerticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15.0)
        ])
        
        detailsVerticalStackView.addArrangedSubview(bannerImageView)
        detailsVerticalStackView.addArrangedSubview(nameLabel)
        detailsVerticalStackView.addArrangedSubview(descriptionLabel)
        detailsVerticalStackView.addArrangedSubview(leagueLabel)
        detailsVerticalStackView.addArrangedSubview(countryLabel)
        detailsVerticalStackView.addArrangedSubview(stadiumLabel)
    }
    
    private func configureOutlets(with sportClub: SportClub) {
        configureBannerImage(with: sportClub.bannerImageURL)
        configureName(with: sportClub.name)
        configureDescription(with: sportClub.description)
        configureLeague(with: sportClub.league)
        configureCountry(with: sportClub.country)
        configureStadium(with: sportClub.stadium)
    }
    
    private func configureBannerImage(with imageURL: URL?) {
        guard let imageURL = imageURL else {
            bannerImageView.isHidden = true
            return
        }
        
        bannerImageView.isHidden = false
        bannerImageView.setImageFromURL(imageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.bannerImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureName(with name: String) {
        nameLabel.text = name
    }
    
    private func configureDescription(with description: String?) {
        guard let description = description else {
            descriptionLabel.isHidden = true
            return
        }
        descriptionLabel.isHidden = false
        descriptionLabel.text = description
    }
    
    private func configureLeague(with league: String?) {
        guard let league = league else {
            leagueLabel.isHidden = true
            return
        }
        
        leagueLabel.isHidden = false
        leagueLabel.text = league
    }
    
    private func configureCountry(with country: String?) {
        guard let country = country else {
            countryLabel.isHidden = true
            return
        }

        countryLabel.isHidden = false
        countryLabel.text = country
    }
    
    private func configureStadium(with stadium: String?) {
        guard let stadium = stadium else {
            stadiumLabel.isHidden = true
            return
        }

        stadiumLabel.isHidden = false
        stadiumLabel.text = stadium
    }
}

// MARK: - Presenter -> ViewController

extension SportsClubDetailViewController: SportsClubDetailDisplayable {
    
    func displaySportsClub(with viewModel: SportsClubDetailModels.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.configureOutlets(with: viewModel.sportClub)
        }
    }
}

// MARK: - ViewController -> Router

extension SportsClubDetailViewController {
}

extension SportsClubDetailViewController: RoutedViewController {
    var router: Router? {
        return internalRouter
    }
}
