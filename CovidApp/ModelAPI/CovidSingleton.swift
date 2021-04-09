//
//  CovidSingleton.swift
//  CovidApp
//
//  Created by Takumi Fuzawa on 2021/04/09.
//

import UIKit

class CovidSingleton {
    
    private init() {}
    static let shared = CovidSingleton()
    var prefecture: [CovidInfo.Prefectures] = []
}


