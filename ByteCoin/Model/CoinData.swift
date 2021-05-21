//
//  CoinDate.swift
//  ByteCoin
//
//  Created by Robert Ranf on 5/21/21.
//

import Foundation

struct CoinData: Codable {
    let baseAsset: String
    let quoteAsset: String
    let rate: Float32
    let time: String
}
