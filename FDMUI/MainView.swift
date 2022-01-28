//
//  MainView.swift
//  FDMUI
//
//  Created by Shin Inaba on 2022/01/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack(spacing: 8.0) {
            Label("FDMUI", systemImage: "chart.xyaxis.line")
                .font(.largeTitle)
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.step, title: "Step(KL)", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.step, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.calculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.productivity, title: "Productivity", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.productivity, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.calculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.manmonth, title: "Man-Month", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.manmonth, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.calculation()
                    })
            }
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.fd, title: "FD", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.fd, perform: { newline in
                        print("change:\(newline)")
                    })
                LabelTextFieldNumberView(input: self.$dataModel.dd, title: "DD", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.dd, perform: { newline in
                        print("change:\(newline)")
                    })
                LabelTextFieldNumberView(input: self.$dataModel.cd, title: "CD", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.cd, perform: { newline in
                        print("change:\(newline)")
                    })
                LabelTextFieldNumberView(input: self.$dataModel.ut, title: "UT", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.ut, perform: { newline in
                        print("change:\(newline)")
                    })
                LabelTextFieldNumberView(input: self.$dataModel.it, title: "IT", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.it, perform: { newline in
                        print("change:\(newline)")
                    })
            }
            Image(systemName: "arrowtriangle.down")
                .font(.largeTitle)
            HStack {
                Label("Adjust", systemImage: "digitalcrown.horizontal.arrow.counterclockwise")
                    .font(.largeTitle)
                Spacer()
                if self.dataModel.manmonth == self.dataModel.adjustsum {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.adjustsum))
                        .font(.largeTitle)
                }
                else {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.adjustsum))
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.adjustfd, title: "FD", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.adjustfd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustdd, title: "DD", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.adjustdd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustcd, title: "CD", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.adjustcd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustut, title: "UT", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.adjustut, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustit, title: "IT", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.adjustit, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
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
                    .keyboardType(UIKeyboardType.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
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

struct LabelTextFieldNumberView: View {
    @EnvironmentObject var dataModel: DataModel
    @Binding var input: Double
    var title: String
    var systemImage: String
    var unit: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Label(self.title, systemImage: self.systemImage)
            HStack {
                TextField(value: self.$input, formatter: DecimanNumberFormatter(), prompt: Text("Number"), label: {
                    Label(self.title, systemImage: self.systemImage)
                })
                    .keyboardType(UIKeyboardType.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
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
