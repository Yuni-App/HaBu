//
//  DeleteAccountViewModal.swift
//  HaBu
//
//  Created by mert alp on 22.12.2023.
//

import Foundation

class DeleteAccountViewModel : ObservableObject {
    @Published var textPassword  = ""
    @Published var textCode = ""
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    func nextToCodeView(){
        
    }
    func deleteAccount (){}
}
