//
//  ForecastView.swift
//  WeatherAppIl
//
//  Created by Иван Легенький on 29.12.2023.
//

import SwiftUI

struct ForecastView: View {
    @State private var selection = 0
    
    var bottomShetTranslationProrated: CGFloat = 1
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SegmentedControl(selection: $selection)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        if selection == 0 {
                            ForEach(Forecast.hourly) { forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                            }
                            .transition(.offset(x: -430))
                        } else {
                            ForEach(Forecast.hourly) { forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .daily)
                            }
                            .transition(.offset(x: 430))
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
                
                Image("Forecast Widgets")
                    .opacity(bottomShetTranslationProrated)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Blur(radius: 25, opaque: true))
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(
            shape: RoundedRectangle(cornerRadius: 44),
            color: Color.bottomSheetBorderMiddleDS,
            lineWidth: 1,
            offsetX: 0,
            offsetY: 1,
            blur: 0,
            blendMode: .overlay,
            opacity: 1 - bottomShetTranslationProrated
        )
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTopDS)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 8)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ForecastView()
        .background(Color.backgroundDS)
        .preferredColorScheme(.dark)
}
