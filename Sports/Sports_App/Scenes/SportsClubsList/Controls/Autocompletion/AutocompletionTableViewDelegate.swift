//
//  AutocompletionTableViewDelegate.swift
//  Sports
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import Foundation
import UIKit

class AutocompletionTableViewDelegate: NSObject {
    
    // MARK: - Vars
    
    private weak var tableView: UITableView?
    var didSelectLeagueAtIndex: ((IndexPath) -> Void)?

    // MARK: - Init
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension AutocompletionTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectLeagueAtIndex?(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
