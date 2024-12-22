//
//  WeatherNetworkService.swift
//  BIMBWeatherAssignment
//
//  Created by Abdul Salam on 21/12/2024.
//

import Alamofire
import Foundation

class WeatherNetworkService: NetworkService {
    
    func fetchWeatherData(endpoint: String, cityName: String, completion: @escaping (MainResponse?, Error?) -> Void) {
        let parameters: [String: String] = [
            "q": cityName,
            "APPID": "542517174e980f946ffbdb7e7338b027",
            "units": "metric"
        ]
        
        AF.request(endpoint, parameters: parameters)
            .validate() // Optional, for validation
            .responseData { response in // Using responseData for raw data
                switch response.result {
                case .success(let value):
                    do {
                        let mainResponse = try JSONDecoder().decode(MainResponse.self, from: value)
                        completion(mainResponse, nil) // Return decoded data
                    } catch {
                        completion(nil, error) // Return decoding error
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
}
