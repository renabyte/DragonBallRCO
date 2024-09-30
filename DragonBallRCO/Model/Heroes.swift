//
//  Heroes.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 21/09/24.
//

import Foundation

struct Heroes: Codable, Hashable {
// The names of the variables should match with the keys used in the link. Also, the data types should match with the values of the URL link.
    
    
    let name: String
    let photo: String
    let favorite: Bool
    let id: String
    let description: String
    
}

struct Bootcamps: Codable , Hashable {
    let name: String
    let id: String
}
//typealias heroType = [String:Heroes]
//var Hero = heroType()

