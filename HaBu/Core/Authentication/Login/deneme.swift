//
//  deneme.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct deneme: View {
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                
                
                CustomButton(title: "fdghfd", backgroundColor: .black, action: {
             
            },destinaiton: AnyView(denemetwo(showSheet: $showSheet)))
            }
        }
    }
}
