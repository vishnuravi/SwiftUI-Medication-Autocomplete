//
//  MedicationSelector.swift
//  Medication-Autocomplete
//
//  Created by Vishnu Ravi on 3/13/21.
//

import SwiftUI

struct MedicationSelector: View {
    
    @ObservedObject var medicationsModel = MedicationsViewModel()
    
    @State var medications: [String] = []
    
    func delete(at offsets: IndexSet) {
        self.medications.remove(atOffsets: offsets)
    }
    
    func highlightedText(str: String, searched: String) -> Text {
        guard !str.isEmpty && !searched.isEmpty else { return Text(str) }
        
        var result: Text!
        let parts = str.components(separatedBy: searched)
        for i in parts.indices {
            result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
            if i != parts.count - 1 {
                result = result + Text(searched).bold()
            }
        }
        return result ?? Text(str)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(alignment: .center) {
                    VStack {
                        HStack {
                            ClearableTextField(placeholder: "Enter a medication name...", text: $medicationsModel.searchText).autocapitalization(.none).padding()
                            Button(action: {
                                if (!self.medicationsModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                                    self.medications.append(self.medicationsModel.searchText)
                                    self.medicationsModel.searchText = ""
                                }
                            }){
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .shadow(radius: 15)
                            }.padding()
                        }.padding(.top)
                        
                        
                        if !medicationsModel.filteredMedications.isEmpty && !(medicationsModel.searchText == "") {
                            ScrollView {
                                VStack(alignment: .leading){
                                    List {
                                        ForEach(medicationsModel.filteredMedications, id: \.self) { medication in
                                            Button(action: {
                                                self.medications.append(medication)
                                                self.medicationsModel.searchText = ""
                                            }){
                                                highlightedText(str: medication.lowercased(), searched: self.medicationsModel.searchText.lowercased())
                                            }
                                        }
                                    }.frame(height: CGFloat(medicationsModel.filteredMedications.count * 50))
                                    Spacer()
                                }
                            }
                            .padding()
                            .shadow(radius: 2)
                            .cornerRadius(5)
                        }
                    }
                    
                    List{
                        ForEach(self.medications, id: \.self){ medication in
                            Text(medication)
                        }.onDelete(perform: delete)
                    }
                    
                }
                
                Spacer()
                
            }
        }
    }
    }
    
    struct MedicationSelector_Previews: PreviewProvider {
        static var previews: some View {
            MedicationSelector()
        }
    }
