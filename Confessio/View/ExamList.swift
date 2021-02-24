//
//  ExamList.swift
//  Confessio
//
//  Created by Branislav on 12/01/2021.
//

import SwiftUI

struct ExamList: View {
    
    @EnvironmentObject var modelData : DBViewModel
    @Environment(\.presentationMode) var presentation
    
    @State var items1: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos", "Grapefruit"]
    @State var selections: [String] = []
    @State var items2: [String] = ["Eggs", "Milk", "Bread", "Bums", "Juice", "Chocolate", "Ham", "Chips"]
    
    //    init() {
    //         UITableView.appearance().backgroundColor = .gray       // Change background color
    //         UITableViewCell.appearance().backgroundColor = .green    // Change each cell's background color
    //
    //    }
    init() {

          let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
          let font = UIFont.init(descriptor: descriptor, size: 30)
          UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]

       }
    
    var body: some View {
        
        NavigationView{
            List {
                Section(header: Text("First section")) {
                    ForEach(self.items1, id: \.self) { item in
                        
                        MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                            if self.selections.contains(item) {
                                self.selections.removeAll(where: { $0 == item })
                            }
                            else {
                                self.selections.append(item)
                                modelData.sinText = item
                                modelData.addData(presentation: presentation)
                            }
                        }
                    }
                    
                    
                    
                }
                
                
                Section(header: Text("Second section")) {
                    ForEach(self.items2, id: \.self) { item in
                        MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                            if self.selections.contains(item) {
                                self.selections.removeAll(where: { $0 == item })
                            }
                            else {
                                self.selections.append(item)
                                modelData.sinText = item
                                modelData.addData(presentation: presentation)
                            }
                        }
                    }
                    
                }
            }
 
            .navigationTitle("Examination of coscience")
            .onAppear(perform: modelData.setUpInitialData)
            .onDisappear(perform: modelData.deInitData)
        }
        //        .listStyle(InsetListStyle())
    }
    
    
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}


struct ExamList_Previews: PreviewProvider {
    static var previews: some View {
        ExamList()
    }
}
