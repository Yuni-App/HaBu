//
//  AddPostTView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI



struct AddPostView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var addPostVM : AddPostViewModel
    
    
    init(){
        self._addPostVM = StateObject(wrappedValue: AddPostViewModel(postService: PostService()))
    }
    
    var body: some View {
        VStack {
            ZStack{
                AddPostBackground()
                VStack{
                    AddPostAppBar(addpostVM: addPostVM, action: {
                        dismiss()
                    })
                    HStack(alignment: .top) {
                        VStack{
                            if addPostVM.isAnonimType == .notSelected {
                                UserTypeImage(showAlert: $addPostVM.showAlert, alertType: $addPostVM.alertType , radius: 7.0,image: .qUser)
                            }
                            else if addPostVM.isAnonimType == .anonymous
                            {
                                UserTypeImage(showAlert: $addPostVM.showAlert ,alertType: $addPostVM.alertType, radius: 7.0,image: .anonim)
                            }
                            else if addPostVM.isAnonimType == .notAnonymous {
                                UserTypeImage(showAlert: $addPostVM.showAlert ,alertType: $addPostVM.alertType, radius: 35.0,image: .mert)
                            }
                        }
                        .padding(5)
                        TextField("Ne düşünüyorsunuz ? ", text: $addPostVM.textContent,axis: .vertical)
                            .lineLimit(9...)
                            .background(Color.white)
                            .cornerRadius(7)
                            .padding(.vertical)
                    }
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 5, style: .circular))
                    .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y:3)
                    .padding()
                    AddCategoryView(SelectedTags: $addPostVM.SelectedTags)
                        .padding(.vertical,20)

                    AddPostToggle(isAnonimComment: $addPostVM.isAnonimComment)
                    AddPostMedia(addpostVM: addPostVM)
                }
            } .navigationDestination(isPresented: $addPostVM.isShareSuccess, destination: {
                TabbarView()
            })
         
        } .sheet(isPresented:  $addPostVM.isShowingImagePicker) {
            ImagePicker(selectedImages: $addPostVM.selectedImages)
        }
        .alert(isPresented: $addPostVM.showAlert) {
            if (addPostVM.alertType == .anonymous){
                Alert(
                        title: Text("Anonim mi olacak"),
                        primaryButton: .default(
                            Text("Anonim"),
                            action: {
                                addPostVM.isAnonimType = .anonymous
                                print("Anonim seçildi.")
                            }
                        ),
                        secondaryButton: .default(
                            Text("Profili Göster"),
                            action: {
                                addPostVM.isAnonimType = .notAnonymous
                                print("Profili Göster seçildi.")
                            }
                        )
                    )
            }else if (addPostVM.alertType == .approval){
                Alert(
                        title: Text("Gönderi Oluşturuluyor"),
                        primaryButton: .default(
                            Text("Onayla"),
                            action: {
                                addPostVM.isShare = true
                                Task{
                                   await addPostVM.createPost()
                                }
                            }
                        ),
                        secondaryButton: .cancel(
                            Text("İptal"),
                            action: {
                                addPostVM.isShare = false
                            }
                        )
                    )
            }
            else if (addPostVM.alertType == .errorAlert){
                Alert(title: Text(addPostVM.alertTitle), message: Text( addPostVM.alertMessage), dismissButton: .default(Text("Tamam")))
            }
            
            else {
            Alert(title: Text("Hata!!"), message: Text("Beklenmedik Bir Hata Oluştu. Tekrar Deneyin.."), dismissButton: .default(Text("Tamam")))
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    AddPostView()
}

@ViewBuilder
private func AddPostToggle(isAnonimComment : Binding<Bool>)->some View{
    HStack{
        Toggle("Anonim Yorum", isOn: isAnonimComment)
            .fontWeight(.bold)

    }
    .padding(.all,5)
        .background(RoundedRectangle(cornerRadius: 7)
            .foregroundColor(Color.white))
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
    HStack{
        Buttons.backButton {
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
                .foregroundColor(.green)
                .fontWeight(.bold)
                .frame(width: Const.width/7)
        })
    }.padding(.top , 25)
}

@ViewBuilder
func AddPostBackground()-> some View {
    VStack(spacing: 0) {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: Const.height * 2.5 / 10)
            .background(
                Const.LinearBackGroundColor
            )
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        Const.primaryBackGroundColor
            .frame(height: Const.height * 7.6 / 10)
    }
}

@ViewBuilder
func AddPostMedia(addpostVM: AddPostViewModel)-> some View {
    VStack{
        HStack{
            Text("Medya")
                .foregroundColor(.black)
                .fontWeight(.bold)
            Spacer()
        }
        HStack{
            if addpostVM.selectedImages.isEmpty {
                Button(action: {
                    
                    if addpostVM.selectedImages.count < 3 {
                        addpostVM.isShowingImagePicker.toggle()
                    } else {
                        // Kullanıcıya bir uyarı göster
                        // Örneğin: Alert gösterebiliriz
                        print("En fazla 3 fotoğraf seçebilirsiniz.")
                    }
                    
                    
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width/4, height: Const.width/4)
                            .background(
                                Image.imageManager(image:.addPhoto ,radius: 7,shadow: Color.black)
                               
                            )
                    }
                })
                Spacer()
            }
            if  addpostVM.selectedImages.count == 3 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(addpostVM.selectedImages.indices, id: \.self) { index in
                            VStack {
                                Image(uiImage: addpostVM.selectedImages[index])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                Button("Kaldır") {
                                    addpostVM.selectedImages.remove(at: index)
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }
                }
         
            }
            if  addpostVM.selectedImages.count == 2 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(addpostVM.selectedImages.indices, id: \.self) { index in
                            VStack {
                                Image(uiImage: addpostVM.selectedImages[index])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                Button("Kaldır") {
                                    addpostVM.selectedImages.remove(at: index)
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }
                }
 
                Button(action: {
                    
                    
                    if addpostVM.selectedImages.count < 3 {
                        addpostVM.isShowingImagePicker.toggle()
                    } else {
                        // Kullanıcıya bir uyarı göster
                        // Örneğin: Alert gösterebiliriz
                        print("En fazla 3 fotoğraf seçebilirsiniz.")
                    }
                    
                    
                    
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width/4, height: Const.width/4)
                            .background(
                                Image.imageManager(image:.addPhoto ,radius: 7,shadow: Color.black)
                               
                            )
                    }
                })
                Spacer()
            }
            if  addpostVM.selectedImages.count == 1 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(addpostVM.selectedImages.indices, id: \.self) { index in
                            VStack {
                                Image(uiImage: addpostVM.selectedImages[index])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                Button("Kaldır") {
                                    addpostVM.selectedImages.remove(at: index)
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }
                }
       
                Button(action: {
                    
                    
                    if addpostVM.selectedImages.count < 3 {
                        addpostVM.isShowingImagePicker.toggle()
                    } else {
                        // Kullanıcıya bir uyarı göster
                        // Örneğin: Alert gösterebiliriz
                        print("En fazla 3 fotoğraf seçebilirsiniz.")
                    }
                    
                    
                    
                    
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width/4, height: Const.width/4)
                            .background(
                                Image.imageManager(image:.addPhoto ,radius: 7,shadow: Color.black)
                               
                            )
                    }
                })
                Spacer()
            }
        }
    }.padding(.bottom, 30)
}


struct AddPostCategory: View {
    @State var SelectedTags:[String] = []
    @Namespace private var animation
    var body: some View {
        VStack{
            HStack{
                Text("Kategori")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(SelectedTags ,id: \.self){tag in
                        TagView(tag, Const.thirColor, "checkmark")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    SelectedTags.removeAll(where: {$0 == tag})
                                }
                            }
                    }
                }
                .padding(.horizontal,15)
                .frame(height: 35)
                .padding(.vertical,15)
            }
            .overlay {
                if SelectedTags.isEmpty{
                    Text("Şeçilen Kategoriler")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    
                }
            }
            .background(.white)
            .zIndex(1)
            VStack{
                TagLayout(spacing: 10){
                    ForEach(Const.categoryTags.filter{!SelectedTags.contains($0)} , id: \.self){tag in
                        TagView(tag, Const.primaryColor, "plus")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    SelectedTags.insert(tag, at: 0)
                                }
                            }
                    }
                }
            }         
            .frame(minHeight: CGFloat((Const.categoryTags.count / 3)) * 55)

        }
    }
}
enum ImageType {
    case notSelected
    case anonymous
    case notAnonymous
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to do here
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                parent.selectedImages.append(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
