//
//  breedList.swift
//  Dog Breeds
//
//  Created by Haris Abdullah on 5/14/22.
//

import Foundation

///This struct contains the complete response for the api call
struct breedList : Codable {

    var message : [String: [String]]
    let status : String?
}

