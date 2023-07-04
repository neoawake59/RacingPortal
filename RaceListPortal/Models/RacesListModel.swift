//
//  RacesListModel.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation

// MARK: - RacesListModel
struct RacesListModel: Codable {
    let status: Int?
    let data: DataClass?
    let message: String?
}

//   let dataClass = try? newJSONDecoder().decode(DataClass.self, from: jsonData)

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let nextToGoIDS: [String]?
    let raceSummaries: [String: RaceSummary]?

    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}

// RaceSummary.swift

//   let raceSummary = try? newJSONDecoder().decode(RaceSummary.self, from: jsonData)

import Foundation

// MARK: - RaceSummary
struct RaceSummary: Codable {
    let raceID, raceName: String?
    let raceNumber: Int?
    let meetingID, meetingName, categoryID: String?
    let advertisedStart: AdvertisedStart?
    let raceForm: RaceForm?
    let venueID, venueName, venueState: String?
    let venueCountry: String?

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
}

// AdvertisedStart.swift

//   let advertisedStart = try? newJSONDecoder().decode(AdvertisedStart.self, from: jsonData)

import Foundation

// MARK: - AdvertisedStart
struct AdvertisedStart: Codable {
    let seconds: Int?
}

// RaceForm.swift

//   let raceForm = try? newJSONDecoder().decode(RaceForm.self, from: jsonData)

import Foundation

// MARK: - RaceForm
struct RaceForm: Codable {
    let distance: Int?
    let distanceType: DistanceType?
    let distanceTypeID: String?
    let trackCondition: DistanceType?
    let trackConditionID: String?
    let weather: DistanceType?
    let weatherID, raceComment, additionalData: String?
    let generated: Int?
    let silkBaseURL: String?
    let raceCommentAlternative: String?

    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case weather
        case weatherID = "weather_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseURL = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
    }
}

// DistanceType.swift

//   let distanceType = try? newJSONDecoder().decode(DistanceType.self, from: jsonData)

import Foundation

// MARK: - DistanceType
struct DistanceType: Codable {
    let id, name, shortName: String?
    let iconURI: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
}

// IconURI.swift

import Foundation

enum IconURI: String, Codable {
    case fine = "FINE"
    case ocast = "OCAST"
    case shwry = "SHWRY"
}

// SilkBaseURL.swift

import Foundation

enum SilkBaseURL: String, Codable {
    case drr38Safykj6SCloudfrontNet = "drr38safykj6s.cloudfront.net"
}

// VenueCountry.swift

import Foundation

enum VenueCountry: String, Codable {
    case aus = "AUS"
    case jpn = "JPN"
}
