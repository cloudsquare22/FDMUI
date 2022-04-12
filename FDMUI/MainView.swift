//
//  MainView.swift
//  FDMUI
//
//  Created by Shin Inaba on 2022/01/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataModel: DataModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8.0) {
                Label("FDMUI", systemImage: "chart.xyaxis.line")
                    .font(.largeTitle)
                BaseView()
                    .padding(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary, lineWidth: 1)
                    )
                ManMonthView()
                    .padding(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary, lineWidth: 1)
                    )
                PeriodView()
                    .padding(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary, lineWidth: 1)
                    )
                ReferenceView()
                    .padding(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary, lineWidth: 1)
                    )
                Spacer()
            }
            .padding(8.0)
        }
        .onChange(of: scenePhase, perform: { value in
                                    switch(value) {
                                    case .active:
                                        print("active")
                                    case .background:
                                        print("background")
                                        self.dataModel.save()
                                    case .inactive:
                                        print("inactive")
                                    @unknown default:
                                        print("default")
                                    }
                                })    }
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

struct LabelTextNumberView: View {
    @EnvironmentObject var dataModel: DataModel
    @Binding var input: Double
    var title: String
    var systemImage: String
    var unit: String? = nil
    var color: Color = .primary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack {
                Label(self.title, systemImage: self.systemImage)
                Spacer()
                Text(String.init(format: "%.2f", self.input))
                if let unit = self.unit {
                    Text(unit)
                }
            }
        }
        .padding(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(self.color, lineWidth: 1)
        )
    }
}

struct LabelTextFieldNumberView: View {
    @EnvironmentObject var dataModel: DataModel
    @Binding var input: Double
    var title: String
    var systemImage: String
    var unit: String? = nil
    var color: Color = .primary

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
                .stroke(self.color, lineWidth: 1)
        )
    }
}

struct BaseView: View {
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        VStack {
            HStack {
                Label("Base", systemImage: "doc.on.doc")
                    .font(.largeTitle)
                Spacer()
            }
            HStack(alignment: .top) {
                LabelTextFieldNumberView(input: self.$dataModel.step, title: "Step(KL)", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.step, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.calculation()
                        self.dataModel.adjustperiodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.productivity, title: "Productivity", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.productivity, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.calculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.utitemstandard, title: "UT item(/KL)", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.utitemstandard, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustperiodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.ititemstandard, title: "IT item(/KL)", systemImage: "doc.plaintext")
                    .onChange(of: self.dataModel.ititemstandard, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustperiodcalcuration()
                    })
            }
        }
    }
}

struct ManMonthView: View {
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        VStack {
            HStack {
                Label("Man-Month", systemImage: "doc.on.doc")
                    .font(.largeTitle)
                Spacer()
                Text(String.init(format: "Sum:%.2f", self.dataModel.manmonth))
                    .font(.largeTitle)
            }
            HStack {
                LabelTextNumberView(input: self.$dataModel.fd, title: "FD", systemImage: "doc.plaintext", color: .blue)
                LabelTextNumberView(input: self.$dataModel.dd, title: "DD", systemImage: "doc.plaintext", color: .green)
                LabelTextNumberView(input: self.$dataModel.cd, title: "CD", systemImage: "doc.plaintext", color: .orange)
                LabelTextNumberView(input: self.$dataModel.ut, title: "UT", systemImage: "doc.plaintext")
                LabelTextNumberView(input: self.$dataModel.it, title: "IT", systemImage: "doc.plaintext")
            }
            AdjustView()
            PersonView()
        }
    }
}

struct AdjustView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            HStack {
                Label("Adjust", systemImage: "dial.max")
                    .font(.title)
                Button(action: {
                    self.dataModel.copyManMonthtoAdujdt()
                }, label: {
                    Label("Man-Month copy", systemImage: "doc.on.doc")
                })
                    .buttonStyle(.borderedProminent)
                Spacer()
                if self.dataModel.manmonth == self.dataModel.adjustsum {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.adjustsum))
                        .font(.title)
                }
                else {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.adjustsum))
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.adjustfd, title: "FD", systemImage: "doc.plaintext", color: .blue)
                    .onChange(of: self.dataModel.adjustfd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustdd, title: "DD", systemImage: "doc.plaintext", color: .green)
                    .onChange(of: self.dataModel.adjustdd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.adjustcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustcd, title: "CD", systemImage: "doc.plaintext", color: .orange)
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
        }
    }
}

struct PersonView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            HStack {
                Label("Person", systemImage: "person.2")
                    .font(.title)
                Button(action: {
                    self.dataModel.copyManMonthAdujdttoPerson()
                }, label: {
                    Label("Adjust copy", systemImage: "doc.on.doc")
                })
                    .buttonStyle(.borderedProminent)
                Spacer()
                if self.dataModel.manmonth == self.dataModel.personsum {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.personsum))
                        .font(.title)
                        .foregroundColor(.black)
                }
                else if self.dataModel.manmonth > self.dataModel.personsum {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.personsum))
                        .font(.title)
                        .foregroundColor(.green)
                }
                else {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.personsum))
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.personfd, title: "FD", systemImage: "person", color: .blue)
                    .onChange(of: self.dataModel.personfd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.personcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.persondd, title: "DD", systemImage: "person", color: .green)
                    .onChange(of: self.dataModel.persondd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.personcalculation()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.personcd, title: "CD", systemImage: "person", color: .orange)
                    .onChange(of: self.dataModel.personcd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.personcalculation()
                        self.dataModel.adjustperiodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.personut, title: "UT", systemImage: "person")
                    .onChange(of: self.dataModel.personut, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.personcalculation()
                        self.dataModel.adjustperiodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.personit, title: "IT", systemImage: "person")
                    .onChange(of: self.dataModel.personit, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.personcalculation()
                        self.dataModel.adjustperiodcalcuration()
                    })
            }
        }
    }
}

struct PeriodView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            HStack {
                Label("Period", systemImage: "calendar")
                    .font(.largeTitle)
                Spacer()
            }
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.periodweek, title: "Week", systemImage: "calendar")
                    .onChange(of: self.dataModel.periodweek, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.periodcalcuration()
                    })
            }
            HStack {
                LabelTextNumberView(input: self.$dataModel.periodfd, title: "FD", systemImage: "calendar", color: .blue)
                LabelTextNumberView(input: self.$dataModel.perioddd, title: "DD", systemImage: "calendar", color: .green)
                LabelTextNumberView(input: self.$dataModel.periodcd, title: "CD", systemImage: "calendar", color: .orange)
                LabelTextNumberView(input: self.$dataModel.periodut, title: "UT", systemImage: "calendar")
                LabelTextNumberView(input: self.$dataModel.periodit, title: "IT", systemImage: "calendar")
            }
            HStack {
                Label("Adjust", systemImage: "dial.max")
                    .font(.title)
                Button(action: {
                    self.dataModel.copyPeriodtoAdujdt()
                }, label: {
                    Label("Period copy", systemImage: "doc.on.doc")
                })
                    .buttonStyle(.borderedProminent)
                Spacer()
                if self.dataModel.periodweek == self.dataModel.adjustperiodsum {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.adjustperiodsum))
                        .font(.largeTitle)
                }
                else {
                    Text(String.init(format: "Sum:%.2f", self.dataModel.adjustperiodsum))
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
            HStack {
                LabelTextFieldNumberView(input: self.$dataModel.adjustperiodfd, title: "FD", systemImage: "calendar", color: .blue)
                    .onChange(of: self.dataModel.adjustperiodfd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.periodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustperioddd, title: "DD", systemImage: "calendar", color: .green)
                    .onChange(of: self.dataModel.adjustperioddd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.periodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustperiodcd, title: "CD", systemImage: "calendar", color: .orange)
                    .onChange(of: self.dataModel.adjustperiodcd, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.periodcalcuration()
                        self.dataModel.adjustperiodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustperiodut, title: "UT", systemImage: "calendar")
                    .onChange(of: self.dataModel.adjustperiodut, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.periodcalcuration()
                        self.dataModel.adjustperiodcalcuration()
                    })
                LabelTextFieldNumberView(input: self.$dataModel.adjustperiodit, title: "IT", systemImage: "calendar")
                    .onChange(of: self.dataModel.adjustperiodit, perform: { newline in
                        print("change:\(newline)")
                        self.dataModel.periodcalcuration()
                        self.dataModel.adjustperiodcalcuration()
                    })
            }
        }
    }
}

struct ReferenceView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            HStack {
                Label("Reference", systemImage: "doc.text.below.ecg")
                    .font(.largeTitle)
                Spacer()
            }
            HStack {
                LabelTextNumberView(input: self.$dataModel.stepbyday, title: "CD Step/Day", systemImage: "keyboard")
                LabelTextNumberView(input: self.$dataModel.stepdaybyperson, title: "CD Step(Day)/Person", systemImage: "keyboard")
            }
            HStack {
                LabelTextNumberView(input: self.$dataModel.utitemcount, title: "UT Item count", systemImage: "checklist")
                LabelTextNumberView(input: self.$dataModel.utbyday, title: "UT Item/Day", systemImage: "checklist")
                LabelTextNumberView(input: self.$dataModel.utbydayperson, title: "UT Item(Day)/Person", systemImage: "checklist")
            }
            HStack {
                LabelTextNumberView(input: self.$dataModel.ititemcount, title: "IT Item count", systemImage: "checklist")
                LabelTextNumberView(input: self.$dataModel.itbyday, title: "IT Item/Day", systemImage: "checklist")
                LabelTextNumberView(input: self.$dataModel.itbydayperson, title: "IT Item(Day)/Person", systemImage: "checklist")
            }
        }
    }
}
