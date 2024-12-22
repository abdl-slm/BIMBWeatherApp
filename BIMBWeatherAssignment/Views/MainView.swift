//
//  MainView.swift
//  BIMBWeatherAssignment
//
//  Created by Abdul Salam on 21/12/2024.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        
        VStack{
            
            HStack{
                TextField("Search for a city",
                          text: $mainViewModel.cityName).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    mainViewModel.getWeatherInfo(cityName: mainViewModel.cityName)
                } label: {
                    Image("search")
                    
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
            }
            Spacer()
            
            if(mainViewModel.isError){
                
                //Error ui if no weather info
                KFImage(URL(string: ERROR_IMAGE)).resizable()
                    .setProcessor(ResizingImageProcessor(referenceSize: CGSize(width: 400, height: 400), mode: .aspectFit))
                    .frame(width: 200, height: 200).cornerRadius(8).padding().background(Circle().foregroundColor(Color.blue))
                Text("Error").font(.system(size: 48)).padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                HStack{
                    Text("Failed to retrieve weather info").font(.system(size: 20)).padding()
                }
                Text("Please check if the city name is correct.").font(.system(size: 20)).padding()
                
            } else{
                
                if(mainViewModel.loading){
                    //Basic skeleton frame for loading weather info
                    KFImage(URL(string: LOADING_IMAGE)).resizable()
                        .setProcessor(ResizingImageProcessor(referenceSize: CGSize(width: 400, height: 400), mode: .aspectFit))
                        .frame(width: 200, height: 200).cornerRadius(8).padding().background(Circle().foregroundColor(Color.blue))
                    Text("Loading..").font(.system(size: 48)).padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                    HStack{
                        Text("Loading..").font(.system(size: 20)).padding()
                    }
                    Text(("Loading..") + TEMPERATURE_UNIT).font(.system(size: 20)).padding()
                } else{
                    KFImage(URL(string: BASE_IMAGE_URL + (mainViewModel.weather?.weather?.first?.icon ?? "") + IMAGE_RESOLUTION)).resizable()
                        .setProcessor(ResizingImageProcessor(referenceSize: CGSize(width: 400, height: 400), mode: .aspectFit))
                        .frame(width: 200, height: 200).cornerRadius(8).padding().background(Circle().foregroundColor(Color.blue))
                    Text(mainViewModel.weather?.name ?? "").font(.system(size: 48)).padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                    HStack{
                        Text(mainViewModel.weather?.weather?.first?.description?.titlecased() ?? "").font(.system(size: 20)).padding()
                    }
                    Text((mainViewModel.weather?.main?.temp?.description ?? "0.00") + TEMPERATURE_UNIT).font(.system(size: 20)).padding()
                }
            }
            Spacer()
            
        }
    }
}
