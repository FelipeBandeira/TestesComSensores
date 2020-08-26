//
//  Film.swift
//  ConsumirAPIs
//
//  Created by Francisco Soares Neto on 20/08/20.
//  Copyright © 2020 Francisco Soares Neto. All rights reserved.
//

import Foundation

/// Film é um struct que pode ser decodificado a partir de um JSON

import Foundation

// MARK: - Teste
struct Teste: Codable {
    let status, nextPage: Int
    let records: [Record]
    let currentPage, totalRecords: Int
    let msg: String

    enum CodingKeys: String, CodingKey {
        case status
        case nextPage = "next_page"
        case records
        case currentPage = "current_page"
        case totalRecords = "total_records"
        case msg
    }
}

// MARK: - Record
struct Record: Codable {
    let countyState: CountyState
    let name: String
    let charges: [String]
    let id: Int
    let source: Source
    let bookDateFormatted: String
    let details: [[Detail]]
    let mugshot: String
    let bookDate: String
    let sourceID: SourceID
    let moreInfoURL: String

    enum CodingKeys: String, CodingKey {
        case countyState = "county_state"
        case name, charges, id, source
        case bookDateFormatted = "book_date_formatted"
        case details, mugshot
        case bookDate = "book_date"
        case sourceID = "source_id"
        case moreInfoURL = "more_info_url"
    }
}

enum CountyState: String, Codable {
    case maricopaCountyAZ = "Maricopa County, AZ"
}

enum Detail: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Detail.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Detail"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Source: String, Codable {
    case maricopaCountySheriffSOffice = "Maricopa County Sheriff's Office"
}

enum SourceID: String, Codable {
    case azMcso = "az-mcso"
}

//struct Film: Decodable {
//    let id, title, filmDescription, director: String
//        let producer, releaseDate, rtScore: String
//        let people, species, locations, vehicles: [String]
//        let url: String
//
//        enum CodingKeys: String, CodingKey {
//            case id, title
//            case filmDescription = "description"
//            case director, producer
//            case releaseDate = "release_date"
//            case rtScore = "rt_score"
//            case people, species, locations, vehicles, url
//        }
//    }
//
//    typealias Films = [Film]
