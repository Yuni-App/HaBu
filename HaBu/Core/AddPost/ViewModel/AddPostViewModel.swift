//
//  AddPostViewModel.swift
//  HaBu
//
//  Created by mert alp on 2.01.2024.
//
import SwiftUI
import Foundation

enum ImageType {
    case notSelected
    case anonymous
    case notAnonymous
}


enum AlertType {
    case notSelected
    case errorAlert
    case anonymous
    case approval
}

class AddPostViewModel : ObservableObject {
    @Published var textContent = ""
    @Published var SelectedTags : [String] = []
 
    @Published var selectedImages: [UIImage] = []
    @Published var  isShowingImagePicker = false
    
    @Published var isShare = false
    @Published var isShareSuccess = false

    @Published var isAnonimComment = false
    @Published var isAnonimType : ImageType = .notSelected

    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var alertType : AlertType = .notSelected
    @Published var isLoading  = false
   
    private var postService: PostService
    init(postService: PostService) {
        self.postService = postService
    }
    
    func checkTextFields()  async{
     
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
            alertMessage = "Lütfen anonimlik türünü seçiniz"
            return
        }
        guard SelectedTags.count != 0  else {
            
            showAlert = true
            alertTitle = "HATA"
            alertType = .errorAlert
            alertMessage = "En az bir tane kategori seçmelisiniz!"
            return
        }
       
        showAlert = true
        alertTitle = ""
        alertMessage = ""
        alertType = .approval
    }

    
    
    func createPost() async {
        isLoading = true
        guard isShare  else {
            return
        }
        do {
            let isAnonim = (isAnonimType == .anonymous) ? true : false
            try await postService.createPost(textContent: textContent, selectedTags: SelectedTags, isAnonimComment: isAnonimComment, isAnonim: isAnonim , selectedImages: selectedImages)
            self.isLoading = false
            isShareSuccess = true
            textContent = ""
            SelectedTags = []
            isAnonimType = .notSelected
            selectedImages = []
            
        } catch{
            self.isLoading = false
            showAlert = true
            alertTitle = "HATA"
            alertType = .errorAlert
            alertMessage = "Bir hata oluştu!"
        }
    }
}


