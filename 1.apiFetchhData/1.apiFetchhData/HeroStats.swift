//
//  HeroStats.swift
//  1.apiFetchhData
//
//  Created by Rajeev on 16/03/23.
//

import Foundation


struct HeroStats:Decodable{
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}
