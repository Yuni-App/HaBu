//
//  AddPostTView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI
import Combine




struct AddPostView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var addPostVM : AddPostViewModel
    
    init(){
        self._addPostVM = StateObject(wrappedValue: AddPostViewModel(postService: PostService()))
    }
    @State private var keyboardHeight: CGFloat = 0
    var body: some View {
        VStack {
            AddPostAppBar(addpostVM: addPostVM, action: {dismiss()}).padding(.horizontal)
            ScrollView{
            HStack(alignment: .top) {
                UserTypeImage(showAlert: $addPostVM.showAlert,
                              alertType: $addPostVM.alertType,
                              radius: addPostVM.isAnonimType == .notSelected ? 7.0 :
                                addPostVM.isAnonimType == .anonymous ? 7.0 : 35.0,
                              image: addPostVM.isAnonimType == .notSelected ? .qUser :
                                addPostVM.isAnonimType == .anonymous ? .anonim : .mert)
                .padding(5)
                
                TextField("Ne düşünüyorsunuz ? ", text: $addPostVM.textContent, axis: .vertical)
                    .lineLimit(9...)
                    .background(Color.white)
                    .cornerRadius(7)
                    .padding(.vertical)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .circular))
            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y: 3)
            .padding()
            
            AddCategoryView(SelectedTags: $addPostVM.SelectedTags)
                .padding(.vertical, 20)
            
            AddPostToggle(isAnonimComment: $addPostVM.isAnonimComment)
            AddPostMedia(addpostVM: addPostVM).padding(.horizontal, 10)
        }
            }
            .hideKeyboardOnTap()
            .navigationDestination(isPresented: $addPostVM.isShareSuccess, destination: {
                TabbarView()
            })
            
            .sheet(isPresented: $addPostVM.isShowingImagePicker) {
                ImagePicker(selectedImages: $addPostVM.selectedImages)
            }
            .alert(isPresented: $addPostVM.showAlert) {
                CustomAlert.make(for: addPostVM.alertType, addPostVM: addPostVM)
            }
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                self.keyboardHeight = keyboardHeight // Klavye yüksekliğini güncelliyoruz
            }
            .background(AddPostBackground().padding(.top, keyboardHeight * 0.9).animation(.easeInOut(duration: 0)))
            
            //.padding(.top, keyboardHeight * 0.9)
        
    }
    
    
    
    @ViewBuilder
    private func AddPostToggle(isAnonimComment : Binding<Bool>)->some View{
        HStack{
            Toggle("Anonim Yorum", isOn: isAnonimComment)
                .fontWeight(.bold)
            
        }
        .padding(.all,5)
        .frame(width: Const.width * 0.95)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 1, y: 2)
    }
    
    
    @ViewBuilder
    private func UserTypeImage(showAlert :Binding<Bool> ,alertType: Binding<AlertType>, radius : CGFloat ,image:AppImage )->some View{
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: Const.width/10, height: Const.width/10)
                .background(
                    Image.imageManager(image:image ,radius: radius)
                )
            
            
        }.onTapGesture {
            withAnimation {
                alertType.wrappedValue = .anonymous
                showAlert.wrappedValue.toggle()
                
            }
        }
    }
    
    @ViewBuilder
    func AddPostAppBar(addpostVM: AddPostViewModel, action : @escaping()->Void) -> some View{
        VStack {
            HStack{
                Buttons.backButton2 {
                    action()
                }
                Spacer()
                Text("Gönderi Oluştur")
                    .foregroundColor(.white)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {
                    Task{
                        await addpostVM.checkTextFields()
                    }
                }, label: {
                    Text("Paylaş")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: Const.width/7)
                })
            }
        }.padding(.top , Const.height * 0.02)
    }
}

@ViewBuilder
func AddPostBackground()-> some View {
    VStack(spacing: 0) {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: Const.height * 2.5 / 10)
            .background(
                Const.primaryColor
            )
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        Const.backColor3.opacity(0.9)
            .frame(height: Const.height * 7.6 / 10)
    }
}

#Preview {
    AddPostView()
}
