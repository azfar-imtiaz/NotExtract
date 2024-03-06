//
//  PublishersExtension.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-06.
//

import Foundation
import SwiftUI
import Combine

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero }
            .map { $0.height }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat.zero }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
