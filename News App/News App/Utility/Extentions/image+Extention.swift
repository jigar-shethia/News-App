//
//  image+Extention.swift
//  News App
//
//  Created by Jigar Shethia on 29/03/24.
//

import SwiftUI

extension Image {
    func imagemodifier() -> some View {
        self .resizable()
            .scaledToFit()
    }
    func iconModifier() -> some View {
        self.imagemodifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}
