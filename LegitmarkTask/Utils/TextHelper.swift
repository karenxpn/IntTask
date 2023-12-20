//
//  TextHelper.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import Foundation
import SwiftUI

struct TextHelper: View {
    let text: String
    let color: Color
    let fontSize: CGFloat
    let font: Font
    
    init(text: String, color: Color = .primary, fontSize: CGFloat = 12) {
        self.text = text
        self.color = color
        self.fontSize =  fontSize
        self.font = .system(size: fontSize)
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(font)
            .fixedSize(horizontal: false, vertical: true)
            .kerning(0.3)
    }
}

#Preview {
    TextHelper(text: "some text")
}
