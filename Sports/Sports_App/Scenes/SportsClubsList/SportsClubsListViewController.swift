//
//  SportsClubsListViewController.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit
import Combine
import Sports_Entities

class SportsClubsListViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .systemBackground
        return topView
    }()
    
    private lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.layer.cornerRadius = 5.0
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = UIColor.systemGray5.cgColor
        searchTextField.clipsToBounds = true
        searchTextField.leftViewMode = .always
        searchTextField.placeholder = "Rechercher"
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.returnKeyType = .done
        searchTextField.delegate = self
        
        let emptyLeftView = UIView(frame: CGRect(x: 20, y: 0, width: 15.0, height: searchTextField.frame.height))
        searchTextField.leftView = emptyLeftView
        
        return searchTextField
    }()
    
    private lazy var topViewBottomSeparatorView: UIView = {
        let topViewBottomSeparatorView = UIView()
        topViewBottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        topViewBottomSeparatorView.backgroundColor = .systemGray5
        return topViewBottomSeparatorView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var autoCompletionTableView: UITableView = {
        let autoCompletionTableView = UITableView()
        autoCompletionTableView.translatesAutoresizingMaskIntoConstraints = false
        autoCompletionTableView.isHidden = true
        return autoCompletionTableView
    }()
    
    // MARK: - Dependencies
    
    private lazy var interactor: SportsClubsListInteractable = SportsClubsListInteractor(presenter: SportsClubsListPresenter(displayer: self))
    private lazy var internalRouter: SportsClubsListRoutable & Router = SportsClubsListRouter(viewController: self)
    private var viewModel: SportsClubsListModels.ViewModel?
    private var autoCompletionFilterer = AutocompletionFilterer()
    
    // MARK: - Vars
    
    private var collectionViewDataSource: SportsClubsCollectionViewDataSource?
    private var collectionViewDelegate: SportsClubsCollectionViewDelegate?
    private var autoCompletionTableViewDataSource: AutocompletionTableViewDataSource?
    private var autoCompletionTableViewDelegate: AutocompletionTableViewDelegate?
    
    private var cancellable = [AnyCancellable]()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureAutoCompletionTableView()
        configureViews()
        
        activateCombineSearch()
    }
    
    // MARK: - Configure
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        topView.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8.0),
            searchTextField.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 15.0),
            searchTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -15.0),
            searchTextField.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8.0)
        ])
        
        topView.addSubview(topViewBottomSeparatorView)
        NSLayoutConstraint.activate([
            topViewBottomSeparatorView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            topViewBottomSeparatorView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            topViewBottomSeparatorView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            topViewBottomSeparatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(autoCompletionTableView)
        NSLayoutConstraint.activate([
            autoCompletionTableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            autoCompletionTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            autoCompletionTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            autoCompletionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionViewDelegate = SportsClubsCollectionViewDelegate(collectionView: collectionView)
        collectionView.delegate = collectionViewDelegate
        
        collectionViewDelegate?.didSelectSportClubAtIndex = { [weak self] indexPath in
            guard let sportClub = self?.viewModel?.sportClubs[indexPath.row] else { return }
            self?.internalRouter.showSportClubDetail(for: sportClub)
        }
        
        collectionViewDataSource = SportsClubsCollectionViewDataSource(collectionView: collectionView, dataProvider: self)
        collectionView.dataSource = collectionViewDataSource
    }
    
    private func configureAutoCompletionTableView() {
        autoCompletionTableViewDelegate = AutocompletionTableViewDelegate(tableView: autoCompletionTableView)
        autoCompletionTableView.delegate = autoCompletionTableViewDelegate
        
        autoCompletionTableViewDelegate?.didSelectLeagueAtIndex = { [weak self] indexPath in
            guard let league = self?.viewModel?.autoCompletionLeagues[indexPath.row] else { return }
            self?.interactor.loadSportsClubs(fromLeague: league.name)
            self?.view.endEditing(true)
        }
        
        autoCompletionTableViewDataSource = AutocompletionTableViewDataSource(tableView: autoCompletionTableView, dataProvider: self)
        autoCompletionTableView.dataSource = autoCompletionTableViewDataSource
    }
}

// MARK: - UITextFieldDelegate

extension SportsClubsListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text,
           searchText.isEmpty == false {
            interactor.loadSportsClubs(fromLeague: searchText)
        }
        view.endEditing(true)
        return false
    }
}

// MARK: - Search Debounce using Combine

extension SportsClubsListViewController {
    
    // Initializes the publisher and subscriber for the textDidChangeNotification of the search textfield
    private func activateCombineSearch() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchTextField)
        publisher
            .map { notification -> String? in
                if let textField = notification.object as? UITextField,
                   let searchText = textField.text {
                    return searchText
                }
                return nil
            }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: { searchText in
                guard let searchText = searchText,
                      searchText.isEmpty == false else {
                          return
                      }
                DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                    self?.interactor.loadAutoCompletionLeagues(from: searchText)
                }
            })
            .store(in: &cancellable)
    }
}

// MARK: - Presenter -> ViewController

extension SportsClubsListViewController: SportsClubsListDisplayable {
    
    func displaySportsClubs(with viewModel: SportsClubsListModels.ViewModel) {        
        self.viewModel = viewModel
        
        DispatchQueue.main.async {
            self.autoCompletionTableView.isHidden = true
            self.collectionView.reloadData()
        }
    }
    
    func displayAutoCompletionLeagues(with viewModel: SportsClubsListModels.ViewModel) {
        self.viewModel = viewModel
                
        DispatchQueue.main.async {
            self.autoCompletionTableView.isHidden = false
            self.autoCompletionTableView.reloadData()
        }
    }
}

// MARK: - ViewController -> Router

extension SportsClubsListViewController {
}

extension SportsClubsListViewController: RoutedViewController {
    var router: Router? {
        return internalRouter
    }
}

// MARK: - DataProvider -> CollectionView DataSource & Delegate

extension SportsClubsListViewController: SportsClubsCollectionViewDataProvider {
    
    func getData() -> [SportClub] {
        return viewModel?.sportClubs ?? []
    }
}

extension SportsClubsListViewController: AutocompletionTableViewDataProvider {
    
    func getData() -> [League] {
        return viewModel?.autoCompletionLeagues ?? []
    }
}
