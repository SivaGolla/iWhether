//
//  BottomOptionsView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 05/10/24.
//

import SwiftUI

struct BottomOptionsView: View {
    var body: some View {
        
        VStack {
            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.5))
                .padding(.bottom, 16)

            Button {
                // Navigate to city finder page
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "line.3.horizontal")
                        .padding(.trailing, 16)
                        .foregroundColor(.white)
                        .imageScale(.large)
                }
            }
        }
        .frame(height: 40)
        .background(Color.meduimBlueColor.opacity(0.9))
    }
}

#Preview {
    BottomOptionsView()
}
