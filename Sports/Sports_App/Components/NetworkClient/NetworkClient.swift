//
//  NetworkClient.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import Combine
import Sports_Entities

protocol NetworkClient {
    var leagues: [League] { get }
    func searchSportsClubs(searchText: String, completion: @escaping ((Teams?) -> Void))
    func searchSpecificClub(team: String, completion: @escaping ((Teams?) -> Void))
    func requestAllLeagues()
}

class NetworkClientImpl: NetworkClient {

    // MARK: - Vars
    
    var leagues = [League]()
    
    // MARK: - Init
    
    static let shared = NetworkClientImpl()
    
    private init() {}
    
    // MARK: - Requests

    func searchSportsClubs(searchText: String, completion: @escaping ((Teams?) -> Void)) {
        let route = SportsApiRoute(action: .searchAllTeams(searchText))
        
        guard let routeEndpoint = route.endpoint,
              let requestURL = URL(string: Constants.baseURL + routeEndpoint) else {
                  completion(nil)
                  return
              }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = route.method.rawValue
        request.timeoutInterval = route.responseTimeout
        
        requestTeams(with: request) { teams in
            completion(teams)
        }
    }
    
    func searchSpecificClub(team: String, completion: @escaping ((Teams?) -> Void)) {

        let route = SportsApiRoute(action: .searchSpecificTeam(team))
        
        guard let routeEndpoint = route.endpoint,
              let requestURL = URL(string: Constants.baseURL + routeEndpoint) else {
                  completion(nil)
                  return
              }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = route.method.rawValue
        request.timeoutInterval = route.responseTimeout
        
        requestTeams(with: request) { teams in
            completion(teams)
        }
    }
    
    private func requestTeams(with urlRequest: URLRequest, completion: @escaping ((Teams?) -> Void)) {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("An error occured trying to fetch Teams : \(error.localizedDescription)")
                completion(nil)
                return
            }
                        
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let sportsTeams = try decoder.decode(Teams.self, from: data)
                    completion(sportsTeams)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func requestAllLeagues() {
        let route = SportsApiRoute(action: .getAllLeagues)
        
        guard let routeEndpoint = route.endpoint,
              let requestURL = URL(string: Constants.baseURL + routeEndpoint) else {
                  return
              }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = route.method.rawValue
        request.timeoutInterval = route.responseTimeout
                
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            if let error = error {
                print("An error occured trying to fetch Leagues : \(error.localizedDescription)")
                return
            }
                        
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let leaguesList = try decoder.decode(LeaguesList.self, from: data)
                    self?.leagues = leaguesList.leagues
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

// MARK: - Constants Extension

private extension NetworkClientImpl {
    enum Constants {
        static let baseURL: String = "https://www.thesportsdb.com/api/v1/json/50130162/"
    }
}
