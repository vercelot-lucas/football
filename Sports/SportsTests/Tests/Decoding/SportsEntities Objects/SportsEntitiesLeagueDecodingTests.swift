//
//  SportsEntitiesLeagueDecodingTests.swift
//  SportsTests
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import XCTest
@testable import Sports_Entities

class SportsEntitiesLeagueDecodingTests: XCTestCase, DecodingTestable {
    
    var data: Data!
    
    // MARK: - Given one valid League
    
    func test__givenJSONWithOneValidLeague__decoding_should_succeed() {
        // Given
        givenJSONWithOneValidLeague()
        
        // When
        let decoder = JSONDecoder()
        let league = try? decoder.decode(League.self, from: data)
        
        // Then
        XCTAssertNotNil(league)
        XCTAssertEqual(
            league,
            League(id: "4328", name: "English Premier League")
        )
    }
    
    // MARK: - Given one League with wrong id type
    
    func test__givenJSONWithOneLeagueWithWrongIdType__decoding_should_fail() {
        // Given
        givenJSONWithOneLeagueWithWrongIdType()
        
        // When
        let decoder = JSONDecoder()
        let league = try? decoder.decode(SportClub.self, from: data)
        
        // Then
        XCTAssertNil(league)
    }
    
    // MARK: - Given one League with missing name

    func test__givenJSONWithOneLeagueWithMissingName__decoding_should_fail() {
        // Given
        givenJSONWithOneLeagueWithMissingName()
        
        // When
        let decoder = JSONDecoder()
        let league = try? decoder.decode(League.self, from: data)
        
        // Then
        XCTAssertNil(league)
    }
}

// MARK: - SportsEntitiesLeagueDecodingTests JSON Mocks

extension SportsEntitiesLeagueDecodingTests {
    
    // MARK: - MOCK Given one valid League
    
    private func givenJSONWithOneValidLeague() {
        let json =
        """
        {
            "idLeague": "4328",
            "strLeague": "English Premier League",
            "strSport": "Soccer",
            "strLeagueAlternate": "Premier League"
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given one League with wrong id type
    
    private func givenJSONWithOneLeagueWithWrongIdType() {
        let json =
        """
        {
            "idLeague": 4328,
            "strLeague": "English Premier League",
            "strSport": "Soccer",
            "strLeagueAlternate": "Premier League"
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given one League with missing name
    
    private func givenJSONWithOneLeagueWithMissingName() {
        let json =
        """
        {
            "idLeague": 4328,
            "strSport": "Soccer",
            "strLeagueAlternate": "Premier League"
        }
        """
        
        makeData(with: json)
    }
}

