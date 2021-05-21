//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Robert Ranf on 4/20/21.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, exchangeRate: CoinModel)
    func didFailWithError(error: Error)
}

let apiKey = (Bundle.main.infoDictionary?["API_KEY"]as?String)!

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for quoteAsset: String) {
        let urlString = "\(baseURL)/\(quoteAsset)?\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let exchangeRate = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRate(self, exchangeRate: exchangeRate)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ rateData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: rateData)
            let time = decodedData.time
            let coinType = decodedData.baseAsset
            let currency = decodedData.quoteAsset
            let rate = decodedData.rate
            let exchangeRate = CoinModel(time:time, baseAsset: coinType, quoteAsset: currency, rate: rate)
            return exchangeRate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
