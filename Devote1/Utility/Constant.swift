//
//  Constant.swift
//  Devote1
//
//  Created by Nicolai Bodean on 17.01.2024.
//

import SwiftUI

 //Mark - Formatter

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

 //Mark - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
       
}

 //Mark - UX
let feedback = UINotificationFeedbackGenerator()
