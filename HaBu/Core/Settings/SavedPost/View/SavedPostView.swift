//
//  SavedPostView.swift
//  HaBu
//
//  Created by mert alp on 15.12.2023.
//

import SwiftUI

struct SavedPostView: View {
    private func checkLike(post:Post,userID:String) -> ActionButtons{
        let value = post.likeList.contains(userID)
        return value ? .liked : .unLike
        
    }
    
    @StateObject var savedPostVM = SavedPostViewModel.shared
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Kaydedileneler", blockedCount:  savedPostVM.savedPostList.count)
            if savedPostVM.loading{
                Spacer()
                ProgressView()
                Spacer()
            }
            else{
                ScrollView{
                    if savedPostVM.savedPostList.count == 0{
                        
                        Text("Kaydedilen Gönderi Bulunamadı").frame(height: Const.height/2).fontWeight(.bold)
                        
                    }
                    else{
                        ForEach(savedPostVM.savedPostList, id: \.self){post in
                            FeedViewCell(post:.constant(post),user: post.user! ,likeAction: checkLike(post: post, userID: AuthService.shared.currentUser!.id))
                            
                        }
                        
                    }
                    }.frame(width: Const.width)
                    .background(
                        Const.primaryBackGroundColor
                    )
            }
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                Task{
                    try await  savedPostVM.fetchSavedPost()
                }
            }
        
    }
}

#Preview {
    SavedPostView()
}
