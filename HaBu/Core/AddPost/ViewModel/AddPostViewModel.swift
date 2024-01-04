//
//  AddPostViewModel.swift
//  HaBu
//
//  Created by mert alp on 2.01.2024.
//

import Foundation
enum AlertType {
    case errorAlert
    case anonymous
    case approval
}

class AddPostViewModel : ObservableObject {
    @Published var textContent = ""
    @Published var SelectedTags : [String] = []
  
    @Published var isShareActive = false
    @Published var isAnonimComment = false
 
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var alertType : AlertType = .anonymous
    
    @Published var isAnonimType : ImageType = .notSelected
    
   
    private var postService: PostService
    init(postService: PostService) {
        self.postService = postService
    }
    

    func createPost() async {
        do {
            guard !textContent.isEmpty else {
                showAlert = true
                alertTitle = "HATA"
                alertType = .errorAlert
                alertMessage = "Boş paylaşım yapamazsınız!"
                return
            }
            guard isAnonimType != .notSelected else {
                showAlert = true
                alertTitle = "HATA"
                alertType = .errorAlert
                alertMessage = "lütfen anonimlik türünü seçiniz"
                return
            } 
            guard SelectedTags.count != 0  else {
                showAlert = true
                alertTitle = "HATA"
                alertType = .errorAlert
                alertMessage = "En az bir tane kategori seçmelisiniz!"
                return
            }
            print("burada")
            
            let isAnonim = (isAnonimType == .anonymous) ? true : false

            print(textContent)
            print(SelectedTags)
            print(isAnonimComment)
            print(isAnonim)
            
            try await postService.createPost(textContent: textContent, selectedTags: SelectedTags, isAnonimComment: isAnonimComment, isAnonim: isAnonim)
           
           
        } catch{
            showAlert = true
            alertTitle = "HATA"
            alertType = .errorAlert
            alertMessage = "Bir hata oluştu!"
         
          
        }
    }
    
 
    
    
}


