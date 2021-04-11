//
//  Record.swift
//  Change
//
//  Created by aiqin139 on 2021/4/10.
//

import Foundation
import SwiftUI

enum RecordType: Int {
    case None = 0
    case Digital = 1
    case Dayan = 2
}

struct RecordData: Hashable, Codable {
    var type: Int = 0
    var digit: DigitalData = DigitalData()
    var dayan: DayanData = DayanData()
    var date: Date = Date()
}
