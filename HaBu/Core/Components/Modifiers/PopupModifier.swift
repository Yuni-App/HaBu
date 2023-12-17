//
//  PopupModifier.swift
//  HaBu
//
//  Created by mert alp on 16.12.2023.
//
import SwiftUI

struct Popup<PopupContent>: ViewModifier where PopupContent: View {
    @Binding var isPresented: Bool
    var view: () -> PopupContent

    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            if isPresented {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                view()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}
