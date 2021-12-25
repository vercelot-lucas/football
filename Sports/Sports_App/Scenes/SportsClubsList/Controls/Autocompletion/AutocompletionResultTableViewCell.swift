//
//  AutocompletionResultTableViewCell.swift
//  Sports
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import UIKit
import Sports_Entities

class AutocompletionResultTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    private lazy var leagueNameLabel: UILabel = {
        let leagueNameLabel = UILabel()
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.adjustsFontForContentSizeCategory = true
        leagueNameLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        leagueNameLabel.textColor = .label
        leagueNameLabel.textAlignment = .left
        leagueNameLabel.numberOfLines = 0
        return leagueNameLabel
    }()
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        configureViews()
    }
    
    // MARK: - Configure
    
    func configureViews() {
        contentView.addSubview(leagueNameLabel)
        
        NSLayoutConstraint.activate([
            leagueNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            leagueNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            leagueNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            leagueNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
        ])
    }
    
    func configure(with league: League) {
        configureLeagueName(league.name)
    }
    
    private func configureLeagueName(_ leagueName: String) {
        leagueNameLabel.text = leagueName
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUi()
    }
    
    private func cleanUi() {
        leagueNameLabel.text = nil
    }
}
