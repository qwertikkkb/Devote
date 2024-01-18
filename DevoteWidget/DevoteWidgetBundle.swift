//
//  DevoteWidgetBundle.swift
//  DevoteWidget
//
//  Created by Nicolai Bodean on 18.01.2024.
//

import WidgetKit
import SwiftUI

@main
struct DevoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        DevoteWidget()
        DevoteWidgetLiveActivity()
    }
}
