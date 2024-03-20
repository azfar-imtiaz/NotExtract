//
//  ColorSchemeMode.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-20.
//

import Foundation
import SwiftUI

enum ColorSchemeMode: String {
    case light
    case dark
    case automatic
    
    var description: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        case .automatic:
            return "automatic"
        }
    }
    
    var systemColorScheme: ColorScheme? {
        switch self {
        case .light: 
            return .light
        case .dark: 
            return .dark
        case .automatic: 
            return nil
        }
    }
}
