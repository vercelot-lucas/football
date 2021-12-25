//
//  SportsEntitiesSportClubDecodingTests.swift
//  SportsTests
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import XCTest
@testable import Sports_Entities

class SportsEntitiesSportClubDecodingTests: XCTestCase, DecodingTestable {
    
    var data: Data!
    
    // MARK: - Given one valid SportClub
    
    func test__givenJSONWithOneValidSportClub__decoding_should_succeed() {
        // Given
        givenJSONWithOneValidSportClub()
        
        // When
        let decoder = JSONDecoder()
        let sportClub = try? decoder.decode(SportClub.self, from: data)
        
        // Then
        XCTAssertNotNil(sportClub)
        XCTAssertEqual(
            sportClub,
            SportClub(id: "134709",
                         name: "Angers",
                         description: "L'Angers Sporting Club de l'Ouest, couramment abrégé en Angers SCO ou SCO d'Angers, est un club de football fondé en 1919 et situé à Angers (Maine-et-Loire, région Pays de la Loire).",
                         league: "French Ligue 1",
                         country: "France",
                         stadium: "Stade Raymond Kopa",
                         badgeImageURL: URL(string: "https://www.thesportsdb.com/images/media/team/badge/445gc21622560255.png")!,
                         bannerImageURL: URL(string: "https://www.thesportsdb.com/images/media/team/banner/fu0ijw1549713907.jpg")!)
        )
    }
    
    // MARK: - Given one SportClub with wrong id type
    
    func test__givenJSONWithOneSportClubWithWrongIdType__decoding_should_fail() {
        // Given
        givenJSONWithOneSportClubWithWrongIdType()
        
        // When
        let decoder = JSONDecoder()
        let sportClub = try? decoder.decode(SportClub.self, from: data)
        
        // Then
        XCTAssertNil(sportClub)
    }
    
    // MARK: - Given one SportClub with missing name

    func test__givenJSONWithOneSportClubWithMissingName__decoding_should_fail() {
        // Given
        givenJSONWithOneSportClubWithMissingName()
        
        // When
        let decoder = JSONDecoder()
        let sportClub = try? decoder.decode(SportClub.self, from: data)
        
        // Then
        XCTAssertNil(sportClub)
    }
}

// MARK: - SportsEntitiesSportClubDecodingTests JSON Mocks

extension SportsEntitiesSportClubDecodingTests {
    
    // MARK: - MOCK Given one valid SportClub
    
    private func givenJSONWithOneValidSportClub() {
        let json =
        """
        {
            "idTeam": "134709",
            "strTeam": "Angers",
            "strDescriptionFR": "L'Angers Sporting Club de l'Ouest, couramment abrégé en Angers SCO ou SCO d'Angers, est un club de football fondé en 1919 et situé à Angers (Maine-et-Loire, région Pays de la Loire).",
            "strLeague": "French Ligue 1",
            "strStadium": "Stade Raymond Kopa",
            "strCountry": "France",
            "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/445gc21622560255.png",
            "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/fu0ijw1549713907.jpg"
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given one SportClub with wrong id type
    
    private func givenJSONWithOneSportClubWithWrongIdType() {
        let json =
        """
        {
            "idTeam": 134709,
            "strTeam": "Angers",
            "strDescriptionFR": "L'Angers Sporting Club de l'Ouest, couramment abrégé en Angers SCO ou SCO d'Angers, est un club de football fondé en 1919 et situé à Angers (Maine-et-Loire, région Pays de la Loire).",
            "strLeague": "French Ligue 1",
            "strStadium": "Stade Raymond Kopa",
            "strCountry": "France",
            "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/445gc21622560255.png",
            "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/fu0ijw1549713907.jpg"
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given one SportClub with missing name
    
    private func givenJSONWithOneSportClubWithMissingName() {
        let json =
        """
        {
            "idTeam": "134709",
            "strDescriptionFR": "L'Angers Sporting Club de l'Ouest, couramment abrégé en Angers SCO ou SCO d'Angers, est un club de football fondé en 1919 et situé à Angers (Maine-et-Loire, région Pays de la Loire).",
            "strLeague": "French Ligue 1",
            "strStadium": "Stade Raymond Kopa",
            "strCountry": "France",
            "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/445gc21622560255.png",
            "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/fu0ijw1549713907.jpg"
        }
        """
        
        makeData(with: json)
    }
}

