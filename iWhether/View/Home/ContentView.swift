//
//  ContentView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

/// The main view of the application that serves as the entry point.
///
/// This view contains a ZStack that allows stacking of views with the ability to align subviews.
struct ContentView: View {
    /// The body of the view.
    var body: some View {
        // A ZStack that overlays the HomeView at the bottom of the screen.
        ZStack(alignment: .bottom) {
            // The main content view of the application.
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
