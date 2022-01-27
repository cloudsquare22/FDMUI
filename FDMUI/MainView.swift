//
//  MainView.swift
//  FDMUI
//
//  Created by Shin Inaba on 2022/01/26.
//

import SwiftUI

struct MainView: View {
    @State var step: String = ""
    @State var productivity: String = ""
    @State var fd: String = ""
    @State var dd: String = ""
    @State var cd: String = ""
    @State var ut: String = ""
    @State var it: String = ""

    var body: some View {
        VStack {
            Label("FDMUI", systemImage: "chart.xyaxis.line")
                .font(.largeTitle)
            HStack {
                LabelTextFieldView(input: self.$step, title: "Step", systemImage: "doc.plaintext", unit: "KL")
                    .onChange(of: self.step, perform: { newline in
                        print("change:" + newline)
                    })
                LabelTextFieldView(input: self.$step, title: "Productivity", systemImage: "doc.plaintext")
                    .onChange(of: self.productivity, perform: { newline in
                        print("change:" + newline)
                    })
            }
            HStack {
                LabelTextFieldView(input: self.$fd, title: "FD", systemImage: "doc.plaintext")
                    .onChange(of: self.fd, perform: { newline in
                        print("change:" + newline)
                    })
                LabelTextFieldView(input: self.$dd, title: "DD", systemImage: "doc.plaintext")
                    .onChange(of: self.dd, perform: { newline in
                        print("change:" + newline)
                    })
                LabelTextFieldView(input: self.$cd, title: "CD", systemImage: "doc.plaintext")
                    .onChange(of: self.cd, perform: { newline in
                        print("change:" + newline)
                    })
                LabelTextFieldView(input: self.$ut, title: "UT", systemImage: "doc.plaintext")
                    .onChange(of: self.ut, perform: { newline in
                        print("change:" + newline)
                    })
                LabelTextFieldView(input: self.$it, title: "IT", systemImage: "doc.plaintext")
                    .onChange(of: self.it, perform: { newline in
                        print("change:" + newline)
                    })
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
    var unit: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Label(self.title, systemImage: self.systemImage)
            HStack {
                TextField("Number", text: self.$input)
                    .keyboardType(UIKeyboardType.numberPad)
                    .textFieldStyle(.roundedBorder)
                if let unit = self.unit {
                    Text(unit)
                }
            }
        }
        .padding(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.primary, lineWidth: 1)
        )
    }
}
