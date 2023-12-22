//
//  CustomPicker.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

protocol NameDisplayable {
    var name: String { get }
}

extension BrandViewModel: NameDisplayable {}
extension ModelViewModel: NameDisplayable {}

struct CustomPicker<T: Identifiable & Hashable & NameDisplayable>: View {
    @Binding var selectedItem: T?
    let loading: Bool
    let items: [T]
    let disabled: Bool
    let placeholder: String
    let action: (T?) -> ()

    var body: some View {
        Menu {
            Picker(placeholder, selection: $selectedItem) {
                ForEach(items, id: \.self) { item in
                    Text(item.name)
                        .tag(item as T?)
                }
            }.onChange(of: selectedItem) { oldItem, newItem in
                action(newItem)
            }
        } label: {
            HStack {
                if loading {
                    ProgressView()
                } else {
                    Text(selectedItem == nil ? placeholder : selectedItem!.name)
                        .foregroundColor(selectedItem == nil ? .gray : .black)
                        .font(.system(size: 16))
                }

                Spacer()

                Image("arrow")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 245/255, green: 245/255, blue: 245/255).opacity(disabled ? 0.4 : 1))
            )
        }.disabled(disabled)
    }
}


//
//#Preview {
//    CustomBrandPicker()
//}
