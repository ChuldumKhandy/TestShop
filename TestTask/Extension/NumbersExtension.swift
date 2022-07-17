//
//  NumbersExtension.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Foundation

extension Double {
    var asString: String { return "\(self)" }
}

extension Int {
    var asString: String { return "\(self)" }
    var asDouble: Double { return Double(self) }
}
