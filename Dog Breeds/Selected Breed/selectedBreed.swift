//
//  selectedBreed.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/14/22.
//

import Foundation

///This struct contains the complete response for the selectbreed and selectbreedrandomimages api call
struct selectedBreed : Codable {

    let message : [String]?
    let status : String?


    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent([String].self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
