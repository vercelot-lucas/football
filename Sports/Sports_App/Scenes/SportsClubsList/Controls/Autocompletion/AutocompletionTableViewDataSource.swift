//
//  AutocompletionTableViewDataSource.swift
//  Sports
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import Foundation
import UIKit
import Sports_Entities

protocol AutocompletionTableViewDataProvider: AnyObject {
    func getData() -> [League]
}

class AutocompletionTableViewDataSource: NSObject {
    
    // MARK: - Vars
    
    private weak var tableView: UITableView?
    private weak var dataProvider: AutocompletionTableViewDataProvider?

    // MARK: - Init
    
    init(tableView: UITableView,
         dataProvider: AutocompletionTableViewDataProvider) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        super.init()
        tableView.dataSource = self
        registerCells()
    }
 
    // MARK: - Configure
    
    private func registerCells() {
        tableView?.register(AutocompletionResultTableViewCell.self, forCellReuseIdentifier: "AutocompletionResultTableViewCell")
    }
}

// MARK: - UITableViewDataSource

extension AutocompletionTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider?.getData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let league = dataProvider?.getData()[indexPath.row] else {
            return defaultCell()
        }
        
        return autoCompletionCell(with: league, at: indexPath)
    }
    
    private func autoCompletionCell(with league: League, at indexPath: IndexPath) -> UITableViewCell {
        guard let autoCompletionCell = tableView?.dequeueReusableCell(withIdentifier: "AutocompletionResultTableViewCell", for: indexPath) as? AutocompletionResultTableViewCell else {
            fatalError("Unable to create cell AutocompletionResultTableViewCell")
        }
        
        autoCompletionCell.configure(with: league)
        
        return autoCompletionCell
    }
    
    private func defaultCell(title: String? = nil) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .brown
        cell.textLabel?.text = title
        return cell
    }
}
