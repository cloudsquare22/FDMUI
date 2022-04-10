//
//  DataModel.swift
//  FDMUI
//
//  Created by Shin Inaba on 2022/01/27.
//

import Foundation

final class DataModel: ObservableObject {
    @Published var step: Double = 0.0
    @Published var productivity: Double = 1.0
    @Published var utitemstandard: Double = 1.0
    @Published var ititemstandard: Double = 1.0
    @Published var manmonth: Double = 0.0
    @Published var fd: Double = 0.0
    @Published var dd: Double = 0.0
    @Published var cd: Double = 0.0
    @Published var ut: Double = 0.0
    @Published var it: Double = 0.0
    @Published var adjustfd: Double = 0.0
    @Published var adjustdd: Double = 0.0
    @Published var adjustcd: Double = 0.0
    @Published var adjustut: Double = 0.0
    @Published var adjustit: Double = 0.0
    @Published var adjustsum: Double = 0.0
    @Published var personfd: Double = 0.0
    @Published var persondd: Double = 0.0
    @Published var personcd: Double = 0.0
    @Published var personut: Double = 0.0
    @Published var personit: Double = 0.0
    @Published var personsum: Double = 0.0
    @Published var periodweek: Double = 0.0
    @Published var periodfd: Double = 0.0
    @Published var perioddd: Double = 0.0
    @Published var periodcd: Double = 0.0
    @Published var periodut: Double = 0.0
    @Published var periodit: Double = 0.0
    @Published var adjustperiodfd: Double = 0.0
    @Published var adjustperioddd: Double = 0.0
    @Published var adjustperiodcd: Double = 0.0
    @Published var adjustperiodut: Double = 0.0
    @Published var adjustperiodit: Double = 0.0
    @Published var adjustperiodsum: Double = 0.0
    @Published var stepbyday: Double = 0.0
    @Published var stepdaybyperson: Double = 0.0
    @Published var utitemcount: Double = 0.0
    @Published var utbyday: Double = 0.0
    @Published var utbydayperson: Double = 0.0
    @Published var ititemcount: Double = 0.0
    @Published var itbyday: Double = 0.0
    @Published var itbydayperson: Double = 0.0

    let userdefault = UserDefaults.standard
    
    init() {
        self.load()
        self.calculation()
        self.adjustcalculation()
        self.personcalculation()
        self.periodcalcuration()
        self.adjustperiodcalcuration()
    }

    func load() {
        if let step = userdefault.object(forKey: "step") as? Double {
            self.step = step
        }
        if let productivity = userdefault.object(forKey: "productivity") as? Double {
            self.productivity = productivity
        }
        if let utitemstandard = userdefault.object(forKey: "utitemstandard") as? Double {
            self.utitemstandard = utitemstandard
        }
        if let ititemstandard = userdefault.object(forKey: "ititemstandard") as? Double {
            self.ititemstandard = ititemstandard
        }
        if let adjustfd = userdefault.object(forKey: "adjustfd") as? Double {
            self.adjustfd = adjustfd
        }
        if let adjustdd = userdefault.object(forKey: "adjustdd") as? Double {
            self.adjustdd = adjustdd
        }
        if let adjustcd = userdefault.object(forKey: "adjustcd") as? Double {
            self.adjustcd = adjustcd
        }
        if let adjustut = userdefault.object(forKey: "adjustut") as? Double {
            self.adjustut = adjustut
        }
        if let adjustit = userdefault.object(forKey: "adjustit") as? Double {
            self.adjustit = adjustit
        }
        if let personfd = userdefault.object(forKey: "personfd") as? Double {
            self.personfd = personfd
        }
        if let persondd = userdefault.object(forKey: "persondd") as? Double {
            self.persondd = persondd
        }
        if let personcd = userdefault.object(forKey: "personcd") as? Double {
            self.personcd = personcd
        }
        if let personut = userdefault.object(forKey: "personut") as? Double {
            self.personut = personut
        }
        if let personit = userdefault.object(forKey: "personit") as? Double {
            self.personit = personit
        }
        if let periodweek = userdefault.object(forKey: "periodweek") as? Double {
            self.periodweek = periodweek
        }
        if let adjustperiodfd = userdefault.object(forKey: "adjustperiodfd") as? Double {
            self.adjustperiodfd = adjustperiodfd
        }
        if let adjustperioddd = userdefault.object(forKey: "adjustperioddd") as? Double {
            self.adjustperioddd = adjustperioddd
        }
        if let adjustperiodcd = userdefault.object(forKey: "adjustperiodcd") as? Double {
            self.adjustperiodcd = adjustperiodcd
        }
        if let adjustperiodut = userdefault.object(forKey: "adjustperiodut") as? Double {
            self.adjustperiodut = adjustperiodut
        }
        if let adjustperiodit = userdefault.object(forKey: "adjustperiodit") as? Double {
            self.adjustperiodit = adjustperiodit
        }
    }
    
    func save() {
        self.userdefault.set(self.step, forKey: "step")
        self.userdefault.set(self.productivity, forKey: "productivity")
        self.userdefault.set(self.utitemstandard, forKey: "utitemstandard")
        self.userdefault.set(self.ititemstandard, forKey: "ititemstandard")
        self.userdefault.set(self.adjustfd, forKey: "adjustfd")
        self.userdefault.set(self.adjustdd, forKey: "adjustdd")
        self.userdefault.set(self.adjustcd, forKey: "adjustcd")
        self.userdefault.set(self.adjustut, forKey: "adjustut")
        self.userdefault.set(self.adjustit, forKey: "adjustit")
        self.userdefault.set(self.personfd, forKey: "personfd")
        self.userdefault.set(self.persondd, forKey: "persondd")
        self.userdefault.set(self.personcd, forKey: "personcd")
        self.userdefault.set(self.personut, forKey: "personut")
        self.userdefault.set(self.personit, forKey: "personit")
        self.userdefault.set(self.periodweek, forKey: "periodweek")
        self.userdefault.set(self.adjustperiodfd, forKey: "adjustperiodfd")
        self.userdefault.set(self.adjustperioddd, forKey: "adjustperioddd")
        self.userdefault.set(self.adjustperiodcd, forKey: "adjustperiodcd")
        self.userdefault.set(self.adjustperiodut, forKey: "adjustperiodut")
        self.userdefault.set(self.adjustperiodit, forKey: "adjustperiodit")
    }

    func calculation() {
        self.manmonth = self.step / self.productivity
        self.fd = self.manmonth / 5
        self.dd = self.manmonth / 5
        self.cd = self.manmonth / 5
        self.ut = self.manmonth / 5
        self.it = self.manmonth / 5
    }
    
    func adjustcalculation() {
        self.adjustsum = self.adjustfd + self.adjustdd + self.adjustcd + self.adjustut + self.adjustit
    }

    func personcalculation() {
        self.personsum = self.personfd + self.persondd + self.personcd + self.personut + self.personit
    }
    
    func periodcalcuration() {
        self.periodfd = self.periodweek / 5
        self.perioddd = self.periodweek / 5
        self.periodcd = self.periodweek / 5
        self.periodut = self.periodweek / 5
        self.periodit = self.periodweek / 5
        self.adjustperiodsum = self.adjustperiodfd + self.adjustperioddd + self.adjustperiodcd + self.adjustperiodut + self.adjustperiodit
    }
    
    func adjustperiodcalcuration() {
        self.stepbyday = self.step / (self.adjustperiodcd * 5)
        self.stepdaybyperson = self.stepbyday / self.personcd
        self.utitemcount = self.step * self.utitemstandard
        if self.utitemcount == 0 {
            self.utbyday = 0
        }
        else {
            self.utbyday = self.utitemcount / (self.adjustperiodut * 5)
        }
        if self.utbyday == 0 {
            self.utbydayperson = 0
        }
        else {
            self.utbydayperson = self.utbyday / self.personut
        }
        self.ititemcount = self.step * self.ititemstandard
        if self.ititemcount == 0 {
            self.itbyday = 0
        }
        else {
            self.itbyday = self.ititemcount / (self.adjustperiodit * 5)
        }
        if self.itbyday == 0 {
            self.itbydayperson = 0
        }
        else {
            self.itbydayperson = self.itbyday / self.personit
        }
    }
    
    func copyManMonthtoAdujdt() {
        self.adjustfd =  self.fd
        self.adjustdd =  self.dd
        self.adjustcd =  self.cd
        self.adjustut =  self.ut
        self.adjustit =  self.it
    }

    func copyManMonthAdujdttoPerson() {
        self.personfd =  self.adjustfd
        self.persondd =  self.adjustdd
        self.personcd =  self.adjustcd
        self.personut =  self.adjustut
        self.personit =  self.adjustit
    }

    func copyPeriodtoAdujdt() {
        self.adjustperiodfd =  self.periodfd
        self.adjustperioddd =  self.perioddd
        self.adjustperiodcd =  self.periodcd
        self.adjustperiodut =  self.periodut
        self.adjustperiodit =  self.periodit
    }
}

class DecimanNumberFormatter : NumberFormatter {
    override init() {
        super.init()
        self.numberStyle = .decimal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
