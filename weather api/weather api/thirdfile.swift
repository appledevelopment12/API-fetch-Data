//
//  thirdfile.swift
//  weather api
//
//  Created by Rajeev on 12/04/23.
//

import Foundation

struct WeatherData:Codable
{
    let location:locationdata
    let current:currentData
}
