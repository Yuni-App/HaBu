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
            ScrollView{
                VStack{
                    if $savedPostVM.savedPostList.count == 0 {
                        Text("Kaydedilen Gönderi Bulunamadı").frame(height: Const.height/2).fontWeight(.bold)
                    }else {
                        ForEach(savedPostVM.savedPostList.indices, id: \.self){index in
                            
                            FeedViewCell(post:$savedPostVM.savedPostList[index],user: savedPostVM.savedPostList[index].user! ,likeAction: checkLike(post: savedPostVM.savedPostList[index], userID: AuthService.shared.currentUser!.id)).id(savedPostVM.savedPostList[index].id)
                            Divider()
                        }

                    }
                }
            }.frame(width: Const.width)
                .background(
                    Const.primaryBackGroundColor
            )
        }.navigationBarBackButtonHidden(true)
        .onAppear {
            Task{
             await   savedPostVM.listenForSavedPost()
            }
               }
        .onDisappear {
           savedPostVM.stopListening()
       }
    }
}

#Preview {
    SavedPostView()
}
