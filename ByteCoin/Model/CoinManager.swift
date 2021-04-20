//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Robert Ranf on 4/20/21.
//

import Foundation

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = (Bundle.main.infoDictionary?["API_KEY"]as?String)!
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
    }
}
