//
//  Mission.swift
//  Moonshot2
//
//  Created by Waihon Yew on 12/06/2022.
//

import Foundation

struct Mission: Codable, Identifiable {
    // Mission.CrewRole nested struct
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    // Codable will automatically skip over optionals if the values
    // is mmising from our input JSON.
    let launchDate: String?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
}
