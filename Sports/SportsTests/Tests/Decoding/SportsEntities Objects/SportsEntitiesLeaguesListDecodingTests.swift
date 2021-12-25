//
//  SportsEntitiesLeaguesListDecodingTests.swift
//  SportsTests
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import XCTest
@testable import Sports_Entities

class SportsEntitiesLeaguesListDecodingTests: XCTestCase, DecodingTestable {
    
    var data: Data!

    // MARK: - Given a valid list of four Leagues

    func test__givenJSONWithAValidListOfFourLeagues__decoding_should_succeed() {
        // Given
        givenJSONWithAValidListOfFourLeagues()
        
        // When
        let decoder = JSONDecoder()
        let leaguesList = try? decoder.decode(LeaguesList.self, from: data)
        
        // Then
        XCTAssertNotNil(leaguesList)
        XCTAssertEqual(leaguesList?.leagues.count, 4)
    }
    
    // MARK: - Given a list of four valid and two invalid Leagues

    func test__givenJSONWithAListOfFourValidAndTwoInvalidLeagues__list_count_should_equal_4() {
        // Given
        givenJSONWithAListOfFourValidAndTwoInvalidLeagues()
        
        // When
        let decoder = JSONDecoder()
        let leaguesList = try? decoder.decode(LeaguesList.self, from: data)
        
        // Then
        XCTAssertNotNil(leaguesList)
        XCTAssertEqual(leaguesList?.leagues.count, 4)
    }
    
    // MARK: - Given an empty list of Leagues
    
    func test__givenJSONWithAnEmptyListOfLeagues__list_should_not_be_nil() {
        // Given
        givenJSONWithAnEmptyListOfLeagues()
        
        // When
        let decoder = JSONDecoder()
        let leaguesList = try? decoder.decode(LeaguesList.self, from: data)
        
        // Then
        XCTAssertNotNil(leaguesList)
        XCTAssertEqual(leaguesList?.leagues.count, 0)
    }
}

// MARK: - SportsEntitiesLeaguesListDecodingTests JSON Mocks

extension SportsEntitiesLeaguesListDecodingTests {
    
    // MARK: - MOCK Given a valid list of four Leagues
    
    private func givenJSONWithAValidListOfFourLeagues() {
        let json =
        """
        {
            "leagues": [
                {
                    "idLeague": "4328",
                    "strLeague": "English Premier League",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Premier League"
                },
                {
                    "idLeague": "4329",
                    "strLeague": "English League Championship",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Championship"
                },
                {
                    "idLeague": "4330",
                    "strLeague": "Scottish Premier League",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Scottish Premiership"
                },
                {
                    "idLeague": "4331",
                    "strLeague": "German Bundesliga",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Bundesliga, Fußball-Bundesliga"
                }
            ]
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given a list of four valid and two invalid Leagues
    
    private func givenJSONWithAListOfFourValidAndTwoInvalidLeagues() {
        let json =
        """
        {
            "leagues": [
                {
                    "idLeague": "4328",
                    "strLeague": "English Premier League",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Premier League"
                },
                {
                    "idLeague": "4329",
                    "strLeague": "English League Championship",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Championship"
                },
                {
                    "idLeague": "4330",
                    "strLeague": "Scottish Premier League",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Scottish Premiership"
                },
                {
                    "idLeague": "4331",
                    "strLeague": "German Bundesliga",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Bundesliga, Fußball-Bundesliga"
                },
                {
                    "idLeague": "4332",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Serie A"
                },
                {
                    "strLeague": "French Ligue 1",
                    "strSport": "Soccer",
                    "strLeagueAlternate": "Ligue 1 Uber Eats"
                }
            ]
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given an empty list of Leagues
    
    private func givenJSONWithAnEmptyListOfLeagues() {
        let json =
        """
        {
            "leagues": [
            ]
        }
        """
        
        makeData(with: json)
    }
}

