//
//  DBViewModel.swift
//  Confessio
//
//  Created by Branislav on 14/01/2021.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    // Data
    
    @Published var sinText = ""
    @Published var sinCount = 0

    // Fetched Data...
    @Published var sins : [Sin] = []
    
    // Data Updation...
    @Published var updateObject : Sin?
    
    init() {
        fetchData()
    }
    
    // Fetching Data...
    
    func fetchData(){
        
        guard let dbRef = try? Realm() else {return}
        
        let results = dbRef.objects(Sin.self)
        
        // Displaying results...
        
        self.sins = results.compactMap({ (sin) -> Sin? in
            return sin
        })
    }
    
    // Adding New Data...
    
    func addData(presentation: Binding<PresentationMode>){
        
        if sinText == "" /*|| sinCount == 0 */{return}
        
        let sin = Sin()
        sin.sinText = sinText
        sin.sinCount = sinCount
        
        // Getting Refrence....
        
        guard let dbRef = try? Realm() else{return}
        
        // Writing Data...
        
        try? dbRef.write{
            
            
            // Checking and Writing Data....
            
            guard let availableObject = updateObject else{
                
                dbRef.add(sin)
                return
            }
            
            availableObject.sinText = sinText
            availableObject.sinCount = sinCount
        }
        
        // Updating UI
        fetchData()
        
        
        // CLosing View...
        presentation.wrappedValue.dismiss()
    }
    
    // Deleting Data...
    
    func deleteData(object: Sin){
        
        guard let dbRef = try? Realm() else{return}
        
        try? dbRef.write{
            
            dbRef.delete(object)
            
            fetchData()
        }
    }
    
    func deleteAllData(){
        
        guard let dbRef = try? Realm() else{return}
        
        try? dbRef.write{
            
            dbRef.deleteAll()
            
            fetchData()
        }
    }
    
    // Setting And Clearing Data...
    
    func setUpInitialData(){
        
        // Updation...
        
        guard let updateData = updateObject else{return}
        
        // Checking if it's update object and assigning values...
        
        sinText = updateData.sinText
        sinCount = updateData.sinCount
    }
    
    func deInitData(){
        
        updateObject = nil
        sinText = ""
        sinCount = 0
    }
    
    
}
