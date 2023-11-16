//
//  CatagoryFilter.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI

struct CategoryFilter: View {
    private let gridItems :[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    @State var checkList : [String] = []
    @State private var selectedOption: GizliHesap = .Hepsi
    
   
    var body: some View {
        
        //Category
        
        VStack(alignment : .leading){
            Text("Kategoriler")
                .font(.headline)
                .fontWeight(.bold)
            LazyVGrid(columns : gridItems,spacing: 1){
                ForEach(CategoryValues.allCases, id: \.self){ category in
                    @State var ChechBoxBool = false
                    chechBoxItem(checked: ChechBoxBool, value:category.rawValue,action: {
                       
                        ChechBoxBool.toggle()
                        print("asd")
                        if ChechBoxBool == true{
                            checkList.append(category.rawValue)
                        }
                        else{
                            if let index = checkList.firstIndex(of: category.rawValue){
                                checkList.remove(at: index)
                            }
                        }
                    })
                }
            }
            
            //isAnonim
          
            
            HStack {
                Text("Gizli Hesap")
                    .font(.headline)
                .fontWeight(.bold)
                Picker("Value", selection: $selectedOption) {
                    
                    ForEach(GizliHesap.allCases, id: \.self) { option in
                                   Text(option.rawValue).tag(option)
                                        .foregroundStyle(.black)
                    }
                }
                .foregroundStyle(.black)
                .padding(.horizontal)
            }
            // filter button
            
            Button(action: {
                print(selectedOption)
                print(checkList)
            }, label: {
                Text("Filtrele")
            })
            .padding(.all,5)
            .background(Const.primaryColor)
            .clipShape(.rect(cornerRadius: 10, style: .circular))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.5)
            )
            .foregroundStyle(.white)
            .padding(.leading,Const.width * 0.65)
            
            
        }
        .padding(.all)
            
            
        }
    }


#Preview {
    CategoryFilter()
}



private struct chechBoxItem : View{
    @State var checked: Bool
    @State var value : String
    @State var  action :()-> Void
    var body: some View {
        HStack{
            CheckBoxView(checked: checked) {
                
            }
            Text(value)
                .font(.footnote)
                .fontWeight(.semibold)
            Spacer()
        }
        .frame(width: (Const.width / 3) )
    }
    
}

private enum CategoryValues:String, CaseIterable{
    case KiralıkEv = "Kiralık Ev"
    case Itiraf = "İtiraf"
    case Haber = "Haber"
    case Satılık = "Satılık"
    case deneme = "Deneme"
    
   
    
}

private enum GizliHesap: String, CaseIterable {
        case Hepsi = "Hepsi"
        case Kapali = "Kapalı"
        case Gizli = "Sadece Gizli"
    }
