//
//  WeatherView.swift
//  WeatherAppIl
//
//  Created by Иван Легенький on 29.12.2023.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    
    var searchResult: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter {
                $0.location.contains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDS
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(searchResult) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top, content: {
                EmptyView()
                    .frame(height: 130)
            })
        }
        .overlay {
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city")
    }
}

#Preview {
    NavigationStack {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
