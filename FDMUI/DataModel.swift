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

    let userdefault = UserDefaults.standard
    
    init() {
        self.load()
        self.calculation()
        self.adjustcalculation()
        self.personcalculation()
    }

    func load() {
        if let step = userdefault.object(forKey: "step") as? Double {
            self.step = step
        }
        if let productivity = userdefault.object(forKey: "productivity") as? Double {
            self.productivity = productivity
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
    }
    
    func save() {
        self.userdefault.set(self.step, forKey: "step")
        self.userdefault.set(self.productivity, forKey: "productivity")
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
