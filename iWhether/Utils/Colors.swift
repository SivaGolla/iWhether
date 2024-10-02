//
//  Colors.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import Foundation
import SwiftUI

enum Colors {
    static let appUpMainColor = Color(red: 180 / 255, green: 214 / 255, blue: 238 / 255)
    static let appDownMainColor = Color(red: 121 / 255, green: 231 / 255, blue: 209 / 255)
    static let lightBlueColor = Color(red: 87 / 255, green: 209 / 255, blue: 240 / 255)
    static let meduimBlueColor = Color(red: 59 / 255, green: 164 / 255, blue: 237 / 255)
    static let darkBlueColor = Color(red: 17 / 255, green: 74 / 255, blue: 170 / 255)
    static let gradient = [lightBlueColor.opacity(0.5), darkBlueColor.opacity(0.5)]
    static let gradientAPP = [appUpMainColor, appDownMainColor]
    static let gradientSerchMenu = [appUpMainColor.opacity(0.5), appDownMainColor.opacity(0.5)]
}
