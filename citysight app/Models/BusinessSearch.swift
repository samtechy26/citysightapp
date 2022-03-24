//
//  BusinessSearch.swift
//  citysight app
//
//  Created by Sam Tech on 3/24/22.
//

import Foundation

struct BusinessSearch: Decodable{
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable{
    var center = Coordinate()
}
