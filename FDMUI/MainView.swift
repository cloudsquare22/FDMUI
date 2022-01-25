//
//  MainView.swift
//  FDMUI
//
//  Created by Shin Inaba on 2022/01/26.
//

import SwiftUI

struct MainView: View {
    @State var line: String = ""
    var body: some View {
        VStack {
            HStack {
                LabelTextFieldView(input: self.$line, title: "Step", systemImage: "doc.plaintext")
            }
            HStack {
                LabelTextFieldView(input: self.$line, title: "FD", systemImage: "doc.plaintext")
                LabelTextFieldView(input: self.$line, title: "DD", systemImage: "doc.plaintext")
                LabelTextFieldView(input: self.$line, title: "CD", systemImage: "doc.plaintext")
                LabelTextFieldView(input: self.$line, title: "UT", systemImage: "doc.plaintext")
                LabelTextFieldView(input: self.$line, title: "IT", systemImage: "doc.plaintext")

            }
            Spacer()
        }
        .padding(8.0)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


struct LabelTextFieldView: View {
    @Binding var input: String
    var title: String
    var systemImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Label(self.title, systemImage: self.systemImage)
            TextField("prompt", text: self.$input)
                .keyboardType(UIKeyboardType.numberPad)
        }
        .padding(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.primary, lineWidth: 1)
        )
    }
}
