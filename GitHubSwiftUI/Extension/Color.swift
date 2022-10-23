//
//  Color.swift
//  GitHubSwiftUI
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}

