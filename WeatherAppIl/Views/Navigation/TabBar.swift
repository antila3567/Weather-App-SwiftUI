//
//  TabBar.swift
//  WeatherAppIl
//
//  Created by Иван Легенький on 29.12.2023.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Arc()
                .fill(Color.tabBarBackgroundDS)
                .frame(height: 88)
                .overlay {
                    Arc()
                        .stroke(Color.tabBarBorderDS, lineWidth: 0.5)
                }
            
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                NavigationLink {
                    WeatherView()
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 12, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

#Preview {
    TabBar(action: {})
        .preferredColorScheme(.dark)
}
