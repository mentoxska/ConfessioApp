//
//  Sin.swift
//  Confessio
//
//  Created by Branislav on 15/01/2021.
//

import SwiftUI
import RealmSwift

// Creating Realm Object....

class Sin: Object,Identifiable {
    
    @objc dynamic var id : Date = Date()
    @objc dynamic var sinText = ""
    @objc dynamic var sinCount = 0
}
