//
//  NetworkService.swift
//  BIMBWeatherAssignment
//
//  Created by Abdul Salam on 21/12/2024.
//

import Foundation

protocol NetworkService {
    
    func fetchWeatherData(endpoint: String, cityName: String, completion: @escaping (MainResponse?, Error?) -> Void)
}
