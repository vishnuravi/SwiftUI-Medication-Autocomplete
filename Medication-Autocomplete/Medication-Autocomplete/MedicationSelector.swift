//
//  MedicationSelector.swift
//  Medication-Autocomplete
//
//  Created by Vishnu Ravi on 3/13/21.
//

import SwiftUI

struct MedicationSelector: View {
     
     @ObservedObject var medicationsViewModel = MedicationsViewModel()
     
     func delete(at offsets: IndexSet) {
          self.medicationsViewModel.medications.remove(atOffsets: offsets)
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
          VStack(alignment: .center) {
               VStack {
                    HStack {
                         ClearableTextField(placeholder: "Enter a medication name...", text: $medicationsViewModel.searchText).autocapitalization(.none).padding()
                         Button(action: {
                              if (!self.medicationsViewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                                   self.medicationsViewModel.searchText = ""
                              }
                         }){
                              Image(systemName: "plus.circle.fill")
                                   .resizable()
                                   .frame(width: 45, height: 45)
                                   .shadow(radius: 15)
                         }.padding()
                    }.padding(.top)
                    
                    
                    if !medicationsViewModel.filteredMedications.isEmpty && !(medicationsViewModel.searchText == "") {
                         ScrollView {
                              VStack(alignment: .leading){
                                   List {
                                        ForEach(medicationsViewModel.filteredMedications, id: \.self) { medication in
                                             Button(action: {
                                                  self.medicationsViewModel.selectedMedication = medication
                                                  self.medicationsViewModel.isShowingMedicationDetailView.toggle()
                                             }){
                                                  highlightedText(str: medication.lowercased(), searched: self.medicationsViewModel.searchText.lowercased())
                                             }
                                        }
                                   }.frame(height: CGFloat(medicationsViewModel.filteredMedications.count * 50))
                                   Spacer()
                              }
                         }
                         .padding(.bottom)
                         .shadow(radius: 2)
                         .cornerRadius(5)
                         .sheet(isPresented: self.$medicationsViewModel.isShowingMedicationDetailView){
                              MedicationDetailView(medicationsViewModel: self.medicationsViewModel)
                         }
                    }
               }
               Spacer()
               
               if (self.medicationsViewModel.medications.count > 0){
                    Text("Medication List").font(.title)
                    List{
                         ForEach(self.medicationsViewModel.medications, id: \.self){ medication in
                              VStack(alignment: .leading, spacing: 0) {
                                   Text(medication.name.uppercased()).font(.headline)
                                   Text("Take \(medication.dosage) \(medication.frequency), \(medication.schedule)").font(.subheadline)
                              }
                         }.onDelete(perform: delete)
                    }
               }
               
          }
          
     }
}

struct MedicationSelector_Previews: PreviewProvider {
     static var previews: some View {
          MedicationSelector()
     }
}
