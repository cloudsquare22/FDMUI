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
