//
//  BackgroundImageView.swift
//  Devote1
//
//  Created by Nicolai Bodean on 18.01.2024.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
       Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
