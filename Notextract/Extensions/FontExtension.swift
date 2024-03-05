//
//  FontExtension.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-05.
//

import Foundation
import SwiftUI

extension Font {
    static func customFont(_ name: String, size: CGFloat) -> Font {
        guard let userFont = UIFont(name: name, size: size) else {
            //print("\(name) font not found!")
            return .system(size: size)
        }
        return Font(userFont)
    }
}
