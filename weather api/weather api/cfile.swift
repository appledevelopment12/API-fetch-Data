//
//  cfile.swift
//  weather api
//
//  Created by Rajeev on 12/04/23.
//

import Foundation

struct currentData:Codable
{
    let last_updated:String
    let temp_c:Float
    let wind_kph:Float
    let humidity:Int
    
}
