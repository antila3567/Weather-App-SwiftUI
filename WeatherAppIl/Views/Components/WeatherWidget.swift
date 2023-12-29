//
//  WeatherWidget.swift
//  WeatherAppIl
//
//  Created by Иван Легенький on 29.12.2023.
//

import SwiftUI

struct WeatherWidget: View {
    var forecast: Forecast
    var body: some View {
        ZStack(alignment: .bottom) {
            Trapezoid()
                .fill(Color.weatherWidgetBackgroundDS)
                .frame(width: 342, height: 182)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("\(forecast.temperature)°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("H:\(forecast.high)°  L:\(forecast.low)°")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Text(forecast.location)
                            .font(.body)
                            .lineLimit(1)
                    }
                })
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image("\(forecast.icon) large")
                        .padding(.trailing, 4)
                    
                    Text(forecast.weather.rawValue)
                        .font(.footnote)
                        .padding(.trailing, 24)
                    
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 182, alignment: .bottom)
    }
}

#Preview {
    WeatherWidget(forecast: Forecast.cities[0])
        .preferredColorScheme(.dark)
}
