//
//  HomeView.swift
//  WeatherAppIl
//
//  Created by Иван Легенький on 29.12.2023.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 //702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomSheetTranslationProrate: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        //must be NAVIGATION VIEW ???
        NavigationStack {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOffset = screenHeight + 36
                
                let isNegativeTranslation = bottomSheetTranslationProrate < 0
                
                ZStack {
                    Color.backgroundDS
                        .ignoresSafeArea()
                    
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: isNegativeTranslation ? 0 : -bottomSheetTranslationProrate * imageOffset)
                    
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrate * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrate)) {
                        Text("Ukraine, Kyiv")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                                .multilineTextAlignment(.center)
                            
                            Text("H:24°   L:18°")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .opacity(1 - bottomSheetTranslationProrate)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrate * 46)

                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationProrate.formatted())
                    } content: {
                       ForecastView(bottomShetTranslationProrated: bottomSheetTranslationProrate)
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                              
                        withAnimation(.easeInOut) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                    }
                
                    
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: isNegativeTranslation ? 0 :  bottomSheetTranslationProrate * 115)
                }
            }
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n" ) + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (96 -
                                               (bottomSheetTranslationProrate * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: "|") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrate)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
