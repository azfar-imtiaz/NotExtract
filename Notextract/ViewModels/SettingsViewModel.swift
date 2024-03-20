//
//  SettingsViewModel.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-20.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("colorSchemeMode") var selectedMode: ColorSchemeMode = .init(rawValue: "automatic")!
    
    func saveMode() {
        UserDefaults.standard.set(selectedMode.description, forKey: "colorSchemeMode")
    }
}
