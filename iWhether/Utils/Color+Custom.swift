//
//  Color+Custom.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import Foundation
import SwiftUI

extension Color {
    static let appUpMainColor = Color(red: 180 / 255, green: 214 / 255, blue: 238 / 255)
    static let appDownMainColor = Color(red: 121 / 255, green: 231 / 255, blue: 209 / 255)
    static let lightBlueColor = Color(red: 87 / 255, green: 209 / 255, blue: 240 / 255)
    static let meduimBlueColor = Color(red: 34 / 255, green: 37 / 255, blue: 60.0 / 255)
    static let darkBlueColor = Color(red: 17 / 255, green: 74 / 255, blue: 170 / 255)
    static let secondaryText = Color(red: 194 / 255, green: 195 / 255, blue: 224 / 255)
    static let hourCellBg = Color(red: 40 / 255, green: 44 / 255, blue: 72 / 255)
    static let hourViewSeparator = Color(red: 62 / 255, green: 66 / 255, blue: 94 / 255)
    static let gradient = [hourCellBg.opacity(0.1), hourCellBg.opacity(0.5)]
    static let gradientAPP = [appUpMainColor, appDownMainColor]
    static let gradientSerchMenu = [appUpMainColor.opacity(0.5), appDownMainColor.opacity(0.5)]
}
