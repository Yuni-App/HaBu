//
//  TabbarView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView{
            FeedView().tabItem {
                Image(systemName: "house.fill")
            }
            
            SerachView().tabItem {
                Image(systemName: "magnifyingglass")
            }
            NotificationView().tabItem {
                Image(systemName: "bell.fill")
            }
            Text("Profile").tabItem {
                Image(systemName: "person")
            }
        }
    }
}

#Preview {
    TabbarView()
}
