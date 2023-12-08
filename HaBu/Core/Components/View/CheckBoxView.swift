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
            if  (checked) {Image.iconManager(AppIcon.checkSquare, size: 24, weight: .bold, color: Const.primaryColor)}
            else {
                Image.iconManager(AppIcon.square, size: 24, weight: .bold, color: .black)
            }
        }
    }
}

