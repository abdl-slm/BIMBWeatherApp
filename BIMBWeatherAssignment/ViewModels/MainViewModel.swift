//
//  MainViewModel.swift
//  BIMBWeatherAssignment
//
//  Created by Abdul Salam on 21/12/2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var cityName: String = ""
    @Published var loading: Bool = false    
    @Published var isError: Bool = false
    @Published var weather: MainResponse? = nil
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getWeatherInfo(cityName: String) {
        loading = true
        let endpoint = BASE_URL + WEATHER_URL
        
        networkService.fetchWeatherData(endpoint: endpoint, cityName: cityName) { mainResponse, error in
            if let error = error {
                print("Error fetching weather data: \(error.localizedDescription)")
                self.loading = false
                self.isError = true
                return
            }
            
            guard let mainResponse = mainResponse else {
                print("No weather data available.")
                self.loading = false
                self.isError = true
                return
            }
            
            // Update weather data on the main thread
            DispatchQueue.main.async {
                self.isError = false
                self.loading = false
                self.weather = mainResponse
            }
        }
    }
    
}

