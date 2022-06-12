//
//  Mission.swift
//  Moonshot2
//
//  Created by Waihon Yew on 12/06/2022.
//

import Foundation

struct CrewRole: Codable {
    let name: String
    let role: String
}

struct Mission: Codable, Identifiable {
    let id: Int
    // Codable will automatically skip over optionals if the values
    // is mmising from our input JSON.
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
