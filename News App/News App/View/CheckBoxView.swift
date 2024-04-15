//
//  CheckBoxView.swift
//  News App
//
//  Created by Jigar Shethia on 15/04/24.
//

import SwiftUI

struct CheckBoxView: View {
        @Binding var isChecked: Bool
        var body: some View {
            Button(action: {
                self.isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(isChecked ? .green : .gray)
            }
        }
}

#Preview {
    CheckBoxView(isChecked: .constant(false))
}
