//
//  CheckBox.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct CheckBoxView: View {
    @State var checked: Bool
    var action: () -> Void
    
    init(checked: Bool, action: @escaping () -> Void) {
        self._checked = State(initialValue: checked)
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
            checked.toggle()
        }) {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? .blue : .black)
                .frame(width: 24, height: 24)
        }
    }
}

