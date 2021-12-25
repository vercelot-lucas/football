//
//  AutocompletionFiltererTests.swift
//  SportsTests
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import XCTest
@testable import Sports
@testable import Sports_Entities

class AutocompletionFiltererTests: XCTestCase {

    func test__given_all_leagues_list_and_some_search_string__filterer_should_return_corresponding_leagues() {
        // Given
        let allLeaguesList = getAllLeaguesList()
        let expectedFilteredLeaguesResult = getExpectedFilteredLeaguesResult()
        
        // When
        let filterer = AutocompletionFilterer()
        let filteredLeagues = filterer.filter(leagues: allLeaguesList, basedOn: "league")
        
        // Then
        XCTAssertFalse(filteredLeagues.isEmpty)
        XCTAssertEqual(filteredLeagues, expectedFilteredLeaguesResult)
    }
}

// MARK: - Leagues data

extension AutocompletionFiltererTests {
 
    func getAllLeaguesList() -> [League] {
        return [
            League(id: "4328", name: "English Premier League"),
            League(id: "4329", name: "English League Championship"),
            League(id: "4330", name: "Scottish Premier League"),
            League(id: "4331", name: "German Bundesliga"),
            League(id: "4332", name: "Italian Serie A"),
            League(id: "4333", name: "French Ligue 1"),
            League(id: "4334", name: "Spanish La Liga"),
            League(id: "4335", name: "Greek Superleague Greece"),
            League(id: "4336", name: "Dutch Eredivisie"),
            League(id: "4337", name: "Belgian First Division A")
        ]
    }

    func getExpectedFilteredLeaguesResult() -> [League] {
        return [
            League(id: "4328", name: "English Premier League"),
            League(id: "4329", name: "English League Championship"),
            League(id: "4330", name: "Scottish Premier League"),
            League(id: "4335", name: "Greek Superleague Greece")
        ]
    }
}
