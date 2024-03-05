//
//  ViewExtension.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-05.
//

import Foundation
import SwiftUI

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}