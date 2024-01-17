//
//  HideKeyboardExtension.swift
//  Devote1
//
//  Created by Nicolai Bodean on 17.01.2024.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
