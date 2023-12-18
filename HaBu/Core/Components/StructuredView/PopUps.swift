//
//  PopUps.swift
//  HaBu
//
//  Created by yusuf on 17.12.2023.
//

import SwiftUI

class PopUps{
    @ViewBuilder
    static func AddPostPopup(selectedOption : Binding<ImageType> , isPopupVisible : Binding<Bool>)->some View {
        VStack {
            Text("Gönderinizin Gizliliği Nasıl Olsun ? ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.black).padding(.bottom,5)
            Text("Anonim Gönderi Seçeneği ile gizli paylaşım yapıp istemediğiniz etkileşimlerden kaçabilirsiniz...").foregroundColor(Const.secondaryButtonColor)
            Spacer()
            Spacer()
            CustomButton(title:  "Anonim Gönderi", backgroundColor: Const.primaryButtonColor, action: {
                withAnimation {
                    selectedOption.wrappedValue = .anonymous
                    isPopupVisible.wrappedValue.toggle()
                }
                return false
            }, size: CustomButtonSize.medium , textColor: .white)
            Spacer()
            CustomButton(title:  "Açık Gönderi", backgroundColor: Const.primaryButtonColor.opacity(0.7), action: {
                withAnimation {
                    selectedOption.wrappedValue = .notAnonymous
                    isPopupVisible.wrappedValue.toggle()
                }
                return false
            }, size: CustomButtonSize.medium , textColor: .white)
          Spacer()
        }.padding(.vertical,10)
        .padding(.horizontal,5)
        .frame(width: Const.width * 0.85,height: Const.width * 0.6 )
        .cornerRadius(15)
        
        
    }

}
