//
//  ButtonHelper.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import SwiftUI

struct ButtonHelper: View {
    
    var disabled: Bool
    var height: CGFloat = 60
    let label: String
    var color: Color = Color(red: 0/255, green: 122/255, blue: 255/255)
    var labelColor: Color = .white
    let action: (() -> Void)

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                
                Text( label )
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(labelColor)
                
                Spacer()
            }.frame(height: height)
            .background(color)
                .opacity(disabled ? 0.5 : 1)
                .cornerRadius(18)
        }.disabled(disabled)
    }
}
