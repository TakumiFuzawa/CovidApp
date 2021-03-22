//
//  Entity.swift
//  CovidApp
//
//  Created by Takumi Fuzawa on 2021/03/20.
//

import UIKit

struct CovidInfo: Codable {
    
    struct Total: Codable {
        var pcr: Int
        var positive: Int
        var hospitalize: Int
        var severe: Int
        var death: Int
        var discharge: Int
    }
    
}
