import SwiftUI


@ViewBuilder
func AddPostMedia(addpostVM: AddPostViewModel) -> some View {
    VStack {
        HStack {
            Text("Medya")
                .foregroundColor(.black)
                .fontWeight(.bold)
            Spacer()
        }
        
        HStack {
            if addpostVM.selectedImages.count < 3 {
                Button(action: {
                    addpostVM.isShowingImagePicker.toggle()
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width/4, height: Const.width/4)
                            .background(
                                Image.imageManager(image: .addPhoto, radius: 7, shadow: Color.black)
                            )
                    }
                }
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(addpostVM.selectedImages.indices, id: \.self) { index in
                        VStack {
                            Image(uiImage: addpostVM.selectedImages[index])
                                .resizable()
                                .frame(width: 90, height: 90)
                            
                            Button("Kaldır") {
                                addpostVM.selectedImages.remove(at: index)
                            }.frame(height: 20)
                            .foregroundColor(.red)
                        }.frame( height: 110)
                    }
                }.frame( height: 110)

            }
        }
    }.padding(.bottom, 30)

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
