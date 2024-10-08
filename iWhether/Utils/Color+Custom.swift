//
//  Color+Custom.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import Foundation
import SwiftUI

extension Color {
    static let meduimBlueColor = Color(red: 31 / 255, green: 42 / 255, blue: 31 / 255)
    static let secondaryText = Color(red: 194 / 255, green: 195 / 255, blue: 224 / 255)
    static let hourCellBg = Color(red: 63 / 255, green: 68 / 255, blue: 68 / 255)
    static let hourViewSeparator = Color(red: 62 / 255, green: 66 / 255, blue: 94 / 255)
    static let gradient = [hourCellBg.opacity(0.1), hourCellBg.opacity(0.5)]
}
