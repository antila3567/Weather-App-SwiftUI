//
//  SegmentedControl.swift
//  WeatherAppIl
//
//  Created by Иван Легенький on 29.12.2023.
//

import SwiftUI

struct SegmentedControl: View {
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button {
                    withAnimation(.snappy) {
                        selection = 0
                    }
                } label: {
                    Text("Hourly Forecast")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                
                Button {
                    withAnimation(.snappy) {
                        selection = 1
                    }
                } label: {
                    Text("Weekly Forecast")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.secondary)
            
            Divider()
                .background(.white.opacity(0.5))
                .blendMode(.overlay)
                .shadow(color: .black.opacity(0.2), radius: 0, x: 0, y: 1)
                .blendMode(.overlay)
                .overlay {
                    HStack {
                        Divider()
                            .frame(width: UIScreen.main.bounds.width / 2, height: 3)
                            .background(Color.underlineDS)
                        .blendMode(.overlay)
                    }
                    .frame(maxWidth: .infinity, alignment: selection == 0 ? .leading : .trailing)
                    .offset(y: -1)
                }
            
        }
        .padding(.top, 25)
    }
}

#Preview {
    SegmentedControl(selection: .constant(0))
}
