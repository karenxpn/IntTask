//
//  CustomModelPicker.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

struct CustomModelPicker: View {
    @Binding var selection: ModelViewModel?
    let models: [ModelViewModel]
    let disabled: Bool
    let placeholder: String
    
    var body: some View {
        Menu {
            Picker(placeholder, selection: $selection) {
                ForEach(models, id: \.self) { brand in
                    Text(brand.name)
                        .tag(brand as ModelViewModel?)
                }
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
//    CustomModelPicker()
//}
