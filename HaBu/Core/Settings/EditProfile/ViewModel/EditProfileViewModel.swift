//
//  EditProfileViewModel.swift
//  HaBu
//
//  Created by OmerErbalta on 19.12.2023.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import PhotosUI
import Kingfisher
@MainActor
class EditProfileViewModel : ObservableObject{
    init(user: User) {
        self.user = user
        self.textName = user.name
        self.textSurName = user.surname
        self.textEmail = user.email
        self.textBio = user.bio ?? ""
        self.textPassword = user.password
        if let profileImageList = user.profileImageUrl{
            let imageList = profileImageList.map {imageName in
                KFImage(URL(string: imageName))
            }
            self.images = imageList
        }
        else{
            self.images = []
        }
    }
    @Published var selectedItem : PhotosPickerItem?{
        didSet{Task{ await loadImage(fromItem: selectedItem)}}
    }
    @Published var user:User
    @Published  var textName : String = ""
    @Published  var textSurName : String = ""
    @Published  var textEmail : String = ""
    @Published  var textBio : String = ""
    @Published  var textPassword: String = ""
    @Published  var  dragDirection: DragDirection = .none
    @Published  var imageIndices = [0, 1, 2]
    @Published  var imagePickerPresented = false
    @Published var showGallery = false
    @Published var profileImage : KFImage?
    @Published var images : [Any]?
    @Published var loadedImages : [Image]?
    @Published var selectedImage = 0
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged(onDragChanged)
            .onEnded(onDragEnded)
    }
    
    
     func onDragEnded(value:DragGesture.Value) {
       dragDirection = .none
      }
     func onDragChanged(value: DragGesture.Value) {
            let direction: DragDirection = value.translation.width > 1 ? .right : .left
        if dragDirection != direction{
                withAnimation{
                    dragDirection = direction
                    if dragDirection   == .left{
                        incrementImageIndices(&imageIndices,shouldIncrement: false)
                    }
                    else if dragDirection == .right{
                        incrementImageIndices(&imageIndices,shouldIncrement: true)
                        
                        
                    }
                }
            }
        
      }
     func incrementImageIndices(_ indices: inout [Int],shouldIncrement: Bool) {
        for i in 0..<indices.count {
            if shouldIncrement {
                indices[i] += 1
                if indices[i] > 2 {
                    indices[i] = 0
                }
            } else {
                indices[i] -= 1
                if indices[i] < 0{
                    indices[i] = 2
                }
            }
        }
    }
    
    func updateUserData() async throws{
        var imageUrlList :[String]?
        var data = [String:Any]()
        if user.name != textName && textName.count > 2{
            data["name"] = textName
        }
        if user.surname != textSurName && textSurName.count > 2{
            data["sur_name"] = textSurName
        }
        if user.bio != textBio && textBio.count > 2{
            data["bio"] = textBio
        }
        if user.password != textPassword && textPassword.count > 6{
            data["password"] = textPassword
        }
        if let images = images{
            imageUrlList = user.profileImageUrl ?? []
            for i in 0..<images.count{
                if let image = images[i] as? Image{
                    if let uiImage = image.renderToUiImage(){
                        if let imageUrl = try? await ImageUploder.imageUpload(image: uiImage, targetFile: .profileFile, userId: user.id){
                            print(imageUrl)
                            if user.profileImageUrl?.count ?? 0 <= i{
                                imageUrlList?.append(imageUrl)
                            }
                            else{
                                imageUrlList?[i] = imageUrl
                            }
                        }
                     
                    }
                }
            }
        }
        data["profileImageUrl"] = imageUrlList ?? nil
        if !data.isEmpty{
            try await Firestore.firestore().collection("user").document(user.id).updateData(data)
        }
        
    }
    func loadImage(fromItem item : PhotosPickerItem?)async{
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else  {return}
        guard let uiImage = UIImage(data: data) else{return}
        if images?.count ?? 0 > selectedImage {
            images?[self.selectedImage] = Image(uiImage: uiImage)
        }
        else{
            images?.append(Image(uiImage: uiImage))
        }
        
    }
}


