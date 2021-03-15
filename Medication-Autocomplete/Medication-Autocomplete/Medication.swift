//
//  Medication.swift
//  Medication-Autocomplete
//
//  Created by Vishnu Ravi on 3/14/21.
//

import Foundation

struct Medication: Hashable, Equatable, Codable {
    var id: String
    var name: String
    var dosage: String
    var frequency: String
    var schedule: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func ==(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: String = UUID().uuidString, name: String = "", dosage: String = "", frequency: String = "", schedule: String = ""){
        self.id = id
        self.name = name
        self.dosage = dosage
        self.frequency = frequency
        self.schedule = schedule
    }
}
