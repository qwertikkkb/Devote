//
//  CheckboxStule.swift
//  Devote1
//
//  Created by Nicolai Bodean on 18.01.2024.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                    
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        }//HStack
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
    Toggle("Placeholder label", isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
        .padding()
        .previewLayout(.sizeThatFits)
}
}
