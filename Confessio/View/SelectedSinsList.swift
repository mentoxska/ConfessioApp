//
//  SelectedSinsList.swift
//  Confessio
//
//  Created by Branislav on 15/01/2021.
//

import SwiftUI

struct SelectedSinsList: View {
    @EnvironmentObject var modelData: DBViewModel
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 15){
                    ForEach(modelData.sins){sin in
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text(sin.sinText)

                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(menuItems: {
                            
                            Button(action: {modelData.deleteData(object: sin)}, label: {
                                Text("Delete Item")
                            })
                            
                            Button(action: {
                                modelData.updateObject = sin
                                //                                modelData.openNewPage.toggle()
                            }, label: {
                                Text("Update Item")
                            })
                        })
                    }
                }
                .padding()
            }
            .navigationTitle("Saved sins")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if modelData.sins.count > 0 {
                        Button(action: {
                                self.showingAlert.toggle()
                        }) {
                            Image(systemName: "trash")
                                .font(.title2)
                        }
                    } else {
                            Image(systemName: "trash")
                                .font(.title2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    //                    Button(action: {modelData.openNewPage.toggle()}) {
                    
                    Image(systemName: "plus")
                        .font(.title2)
                }
                
            }
            .alert(isPresented:$showingAlert) {
                Alert(title: Text("Are you sure you want to delete all sins?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
                    modelData.deleteAllData()
                }, secondaryButton: .cancel())
            }
        }
        //            .sheet(isPresented: $modelData.openNewPage, content: {
        //                AddPageView()
        //                    .environmentObject(modelData)
        //            })
    }
}
//}

struct SelectedSinsList_Previews: PreviewProvider {
    static var previews: some View {
        SelectedSinsList()
    }
}
