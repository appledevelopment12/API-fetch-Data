//
//  model.swift
//  2.APIdataintableviewcell
//
//  Created by Rajeev on 17/03/23.
//

import Foundation


struct ToDo:Decodable
{
    let  userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
