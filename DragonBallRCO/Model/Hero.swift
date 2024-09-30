//
//  Hero.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 25/09/24.
//

import Foundation

struct Hero: Codable, Hashable {
    let description, name: String
    let favorite: Bool
    let photo: String
    let id: String
}
