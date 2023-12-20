//
//  CustomBrandPicker.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

struct CustomBrandPicker: View {
    @Binding var selection: BrandViewModel?
    let brands: [BrandViewModel]
    let disabled: Bool
    let placeholder: String
    let action: (BrandViewModel?) -> ()

    
    var body: some View {
        Menu {
            Picker("Brand", selection: $selection) {
                ForEach(brands, id: \.self) { brand in
                    Text(brand.name)
                        .tag(brand as BrandViewModel?)
                }
            }.onChange(of: selection) { oldValue, newValue in
                action(newValue)
            }
        } label: {
            HStack {
                TextHelper(text: selection == nil ? placeholder : selection!.name,
                           color: selection == nil ? .gray : .black,
                           fontSize: 16)
                
                Spacer()
                
                Image("arrow")
            }.padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 245/255, green: 245/255, blue: 245/255).opacity(disabled ? 0.4 : 1))
                }
        }.disabled(disabled)
    }
}
//
//#Preview {
//    CustomBrandPicker()
//}
