//
//  CommentBottomSheet.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct CommentBottomSheet: View {
    @State private var commentText  : String = ""
    var postId : String
    var commentVM : CommentViewModel
    init(postId: String) {
        self.postId = postId
        self.commentVM = CommentViewModel(postId: postId)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack{
                    Text("Yorumlar")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("4 yorum")
                }
                .padding(.horizontal,20)
                ForEach(0..<commentVM.comments.count){i in
                    CommentViewCell(comment:commentVM.comments[i])
                }
            }
            .padding(10)
            .zIndex(1)
            
            Const.backgroundColor
                .zIndex(0)
                .ignoresSafeArea(.all)
        }
        HStack{
            TextFields.CommentTextField(commentText: $commentText)
            Button(action: {
            }, label: {
                Image.iconManager(.paperplane, size: 30, weight: .bold, color: Const.thirColor)
                    .padding(10)
            })
        }
    }
  
}




struct CommentViewCell : View {
    let comment : Comment
    var body: some View {
        
        VStack{
            //User Info
            HStack {
                UserInfo(user: comment.user ?? User.MockData[0], imageSize: .xsmall,isAnonim: false)
                    .padding(10)
                Buttons.actionButton(buttonType: .liked, action: {
                    
                }, getNumber: 10)
                .padding(.all,10)
                
            }
            Text(comment.comment)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal)
                .padding(.vertical,5)
        }
        .frame(width: Const.width * 0.95)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 5, style: .circular))
        .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y:3)
        .padding(.vertical,3)


        
    }
}

/*
 Yorum Gönderme fonksiyonu
 func submitComment() {
   // Yorumu oluştur
   let comment = Comment(
     id: UUID(),
     text: commentText,
     user: Auth.auth().currentUser!
   );

   // Yorumu Firestore'a gönder
   Firestore.firestore().collection("comments").addDocument(data: comment.toDict()) { error in
     if let error = error {
       // Hata mesajını göster
       print(error.localizedDescription);
     } else {
       // Yorum gönderme işlemini tamamla
       self.commentText = "";
     }
   }
 }
 ***************************************************************
 
 Yorum beğenip beğenmeme kısmı
 func like() {
   // Yorumun beğeni sayısını güncelle
   let comment = Comment(
     id: commentId,
     text: commentText,
     user: user,
     likes: likes + 1
   );

   // Yorumu Firestore'a gönder
   Firestore.firestore().collection("comments").document(commentId).updateData(comment.toDict()) { error in
     if let error = error {
       // Hata mesajını göster
       print(error.localizedDescription);
     } else {
       // Beğenme işlemini tamamla
       self.likeButton.setImage(Image.iconManager(.heart_fill, size: 30, weight: .bold, color: .red), for: .normal);
     }
   }
 }

 func dislike() {
   // Yorumun beğenmeme sayısını güncelle
   let comment = Comment(
     id: commentId,
     text: commentText,
     user: user,
     dislikes: dislikes + 1
   );

   // Yorumu Firestore'a gönder
   Firestore.firestore().collection("comments").document(commentId).updateData(comment.toDict()) { error in
     if let error = error {
       // Hata mesajını göster
       print(error.localizedDescription);
     } else {
       // Beğenmeme işlemini tamamla
       self.dislikeButton.setImage(Image.iconManager(.heart_broken, size: 30, weight: .bold, color: .red), for: .normal);
     }
   }
 }
 ****************************************************************
 
 
 
 
 */
