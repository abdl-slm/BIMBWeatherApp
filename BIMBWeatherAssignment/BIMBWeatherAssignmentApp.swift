//
//  BIMBWeatherAssignmentApp.swift
//  BIMBWeatherAssignment
//
//  Created by Abdul Salam on 21/12/2024.
//

import SwiftUI

@main
struct BIMBWeatherAssignmentApp: App {
    
    @StateObject private var mainViewModel = MainViewModel(networkService: WeatherNetworkService())
    
    var body: some Scene {
        
        WindowGroup {
            MainView()
            .environmentObject(mainViewModel)        }
    }
}
