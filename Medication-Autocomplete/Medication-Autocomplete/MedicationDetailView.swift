//
//  MedicationDetailView.swift
//  Medication-Autocomplete
//
//  Created by Vishnu Ravi on 3/15/21.
//

import SwiftUI

struct MedicationDetailView: View {
    
    @ObservedObject var medicationsViewModel: MedicationsViewModel
    
    @State private var selectedDosage: String = ""
    
    @State private var selectedUnit: String = ""
    var units: [String] = ["tablet(s)", "capsule(s)", "milliliters", "units", "grams", "milligrams"]
    
    @State private var selectedFrequency: String = ""
    var frequency = ["once a day", "twice a day", "three times a day", "four times a day", "every 6 hours", "every 8 hours", "every 12 hours", "other"]
    
    @State private var selectedDays: String = ""
    var days = ["every day", "every monday, wednesday, and friday", "every tuesday and thursday", "once a week", "other"]
    
    var body: some View {
        VStack {
            VStack {
                NavigationView {
                    Form {
                        Section(header: Text("Dosage")) {
                            HStack{
                                TextField("Quantity", text: $selectedDosage)
                                Picker("Unit", selection: $selectedUnit){
                                    ForEach(units, id: \.self){
                                        Text($0)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Frequency")) {
                            Picker("How often do you take it?", selection: $selectedFrequency){
                                ForEach(frequency, id: \.self){
                                    Text($0)
                                }
                            }
                        }
                        
                        Section(header: Text("Schedule")) {
                            Picker("On which days do you take it?", selection: $selectedDays){
                                ForEach(days, id: \.self){
                                    Text($0)
                                }
                            }.scaledToFit()
                        }
                    }.navigationTitle(self.medicationsViewModel.selectedMedication)
                }
            }
            Spacer()
            HStack {
                Button("Add this Medication"){
                    self.medicationsViewModel.medications.append(Medication(name: self.medicationsViewModel.selectedMedication, dosage: selectedDosage, frequency: selectedFrequency, schedule: selectedDays))
                    self.medicationsViewModel.searchText = ""
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(5)
                
                Button("Cancel"){
                    self.medicationsViewModel.searchText = ""
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(5)
            }
            Spacer()
        }.background(Color(UIColor.systemGray5))
    }
}

struct MedicationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationDetailView()
    }
}
