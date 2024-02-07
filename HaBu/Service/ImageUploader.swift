//
//  ImageUploader.swift
//  HaBu
//
//  Created by OmerErbalta on 23.12.2023.
//


import Foundation
import Firebase
import FirebaseStorage
struct ImageUploder{
    static func imageUpload(image:UIImage,targetFile:targetString,userId:String? = nil,postId:String? = nil)async throws -> String?{
        guard let imageData = image.compress(to: 50) else{return nil}
        
        let filename = UUID().uuidString
        let ref = userId != nil ? Storage.storage().reference(withPath: "/\(targetFile.value)/\(userId!)/\(filename)") :Storage.storage().reference(withPath: "/\(targetFile.value)/\(postId!)/\(filename)")
        
        
        do{
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
            
            
        }catch{
            print("Debug: Faild to upload profile Image \(error.localizedDescription)")
            return nil
        }
    }
}

enum targetString{
    case profileFile
    case postFile
    var value:String{
        switch self {
        case .profileFile:
            return "profile_image"
        case .postFile:
            return "post_image"
        }
    }
}
