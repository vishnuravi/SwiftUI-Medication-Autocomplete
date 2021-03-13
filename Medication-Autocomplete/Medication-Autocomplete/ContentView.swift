//
//  ContentView.swift
//  Medication-Autocomplete
//
//  Created by Vishnu Ravi on 3/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var medicationsModel = MedicationsViewModel()
    
    @State var medications: [String] = []
    
    func delete(at offsets: IndexSet) {
        self.medications.remove(atOffsets: offsets)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(alignment: .center) {
                    VStack {
                        HStack {
                            TextField("Enter a medication name...", text: $medicationsModel.searchText).padding()
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
                        }.padding(20)
                        
                        
                        if !medicationsModel.filteredMedications.isEmpty {
                            ScrollView {
                                VStack(alignment: .leading){
                                    List {
                                        ForEach(medicationsModel.filteredMedications, id: \.self) { medication in
                                            Button(action: {
                                                self.medications.append(medication)
                                            }){
                                                Text(medication)
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
                    
                    Spacer()
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
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
