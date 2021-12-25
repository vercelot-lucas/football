//
//  SportsEntitiesTeamsDecodingTests.swift
//  SportsTests
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import XCTest
@testable import Sports_Entities

class SportsEntitiesTeamsDecodingTests: XCTestCase, DecodingTestable {
    
    var data: Data!

    // MARK: - Given a valid list of four SportClubs

    func test__givenJSONWithAValidListOfFourSportClubs__decoding_should_succeed() {
        // Given
        givenJSONWithAValidListOfFourSportClubs()
        
        // When
        let decoder = JSONDecoder()
        let teams = try? decoder.decode(Teams.self, from: data)
        
        // Then
        XCTAssertNotNil(teams)
        XCTAssertEqual(teams?.sportsClubs.count, 4)
    }
    
    // MARK: - Given a list of four valid and two invalid SportClubs

    func test__givenJSONWithAListOfFourValidAndTwoInvalidSportClubs__list_count_should_equal_4() {
        // Given
        givenJSONWithAListOfFourValidAndTwoInvalidSportClubs()
        
        // When
        let decoder = JSONDecoder()
        let teams = try? decoder.decode(Teams.self, from: data)
        
        // Then
        XCTAssertNotNil(teams)
        XCTAssertEqual(teams?.sportsClubs.count, 4)
    }
    
    // MARK: - Given an empty list of SportClubs
    
    func test__givenJSONWithAnEmptyListOfSportClubs__list_should_not_be_nil() {
        // Given
        givenJSONWithAnEmptyListOfSportClubs()
        
        // When
        let decoder = JSONDecoder()
        let teams = try? decoder.decode(Teams.self, from: data)
        
        // Then
        XCTAssertNotNil(teams)
        XCTAssertEqual(teams?.sportsClubs.count, 0)
    }
}

// MARK: - SportsEntitiesTeamsDecodingTests JSON Mocks

extension SportsEntitiesTeamsDecodingTests {
    
    // MARK: - MOCK Given a valid list of four SportClubs
    
    private func givenJSONWithAValidListOfFourSportClubs() {
        let json =
        """
        {
            "teams": [
                {
                    "idTeam": "134709",
                    "strTeam": "Angers",
                    "strDescriptionFR": "L'Angers Sporting Club de l'Ouest, couramment abrégé en Angers SCO ou SCO d'Angers, est un club de football fondé en 1919 et situé à Angers (Maine-et-Loire, région Pays de la Loire).",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Raymond Kopa",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/445gc21622560255.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/fu0ijw1549713907.jpg"
                },
        {
                    "idTeam": "133716",
                    "strTeam": "Bordeaux",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Chaban Delmas",
                    "strDescriptionFR": "Le Football Club des Girondins de Bordeaux, appelé plus couramment les Girondins de Bordeaux (abrégé en FCGB), est un club de football créé en 1919 à Bordeaux.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/u45vc51627132724.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/sxxupp1420580673.jpg"
                },
                {
                    "idTeam": "133704",
                    "strTeam": "Brest",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Francis-Le Blé",
                    "strDescriptionFR": "Le Stade brestois 29 est un club de football français basé à Brest, fondé en 1950 à la suite de la fusion de cinq patronages locaux, dont notamment l'Armoricaine de Brest, fondé en 1903.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/z69be41598797026.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/7pyfoa1607720364.jpg"
                },
                {
                    "idTeam": "134713",
                    "strTeam": "Clermont Foot",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Gabriel Montpied",
                    "strDescriptionFR": "Le Clermont Foot 63 est un club de football français fondé en 1990 basé à Clermont-Ferrand dans le département du Puy-de-Dôme en région Auvergne. Il évolue actuellement en Ligue 2. Le club auvergnat est présidé par Claude Michy.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/wrytst1426871249.png",
                    "strTeamBanner": null
                }
            ]
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given a list of four valid and two invalid SportClubs
    
    private func givenJSONWithAListOfFourValidAndTwoInvalidSportClubs() {
        let json =
        """
        {
            "teams": [
                {
                    "idTeam": "134709",
                    "strTeam": "Angers",
                    "strDescriptionFR": "L'Angers Sporting Club de l'Ouest, couramment abrégé en Angers SCO ou SCO d'Angers, est un club de football fondé en 1919 et situé à Angers (Maine-et-Loire, région Pays de la Loire).",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Raymond Kopa",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/445gc21622560255.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/fu0ijw1549713907.jpg"
                },
                {
                    "idTeam": "133716",
                    "strTeam": "Bordeaux",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Chaban Delmas",
                    "strDescriptionFR": "Le Football Club des Girondins de Bordeaux, appelé plus couramment les Girondins de Bordeaux (abrégé en FCGB), est un club de football créé en 1919 à Bordeaux.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/u45vc51627132724.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/sxxupp1420580673.jpg"
                },
                {
                    "idTeam": "133704",
                    "strTeam": "Brest",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Francis-Le Blé",
                    "strDescriptionFR": "Le Stade brestois 29 est un club de football français basé à Brest, fondé en 1950 à la suite de la fusion de cinq patronages locaux, dont notamment l'Armoricaine de Brest, fondé en 1903.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/z69be41598797026.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/7pyfoa1607720364.jpg"
                },
                {
                    "idTeam": "134713",
                    "strTeam": "Clermont Foot",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Gabriel Montpied",
                    "strDescriptionFR": "Le Clermont Foot 63 est un club de football français fondé en 1990 basé à Clermont-Ferrand dans le département du Puy-de-Dôme en région Auvergne. Il évolue actuellement en Ligue 2. Le club auvergnat est présidé par Claude Michy.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/wrytst1426871249.png",
                    "strTeamBanner": null
                },
                {
                    "idTeam": 133822,
                    "strTeam": "Lens",
                    "strLeague": "French Ligue 1",
                    "strStadium": "Stade Félix Bollaert",
                    "strDescriptionFR": "Le Racing Club de Lens, couramment abrégé en RC Lens ou en RCL, est un club professionnel de football français fondé en janvier 1906 et dont le siège se trouve à Avion, à trois kilomètres de la cité minière.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/3pxoum1598797195.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/txrwyq1423691048.jpg"
                },
                {
                    "strTeam": "Lille",
                    "strStadium": "Stade Pierre-Mauroy",
                    "strDescriptionFR": "Le LOSC Lille, couramment abrégé en LOSC ou Lille OSC, est un club de football français.",
                    "strCountry": "France",
                    "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/2giize1534005340.png",
                    "strTeamBanner": "https://www.thesportsdb.com/images/media/team/banner/rturvv1420579158.jpg"
                }
            ]
        }
        """
        
        makeData(with: json)
    }
    
    // MARK: - MOCK Given an empty list of SportClubs
    
    private func givenJSONWithAnEmptyListOfSportClubs() {
        let json =
        """
        {
            "teams": [
            ]
        }
        """
        
        makeData(with: json)
    }
}

