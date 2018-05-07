//
//  TypeMap.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import Foundation

class TypeMap {
    var key:String!
    var title:String!
    var fileName:String!
    var fromScore:Int!
    var toScore:Int!
    
    init(key:String, title:String, fileName:String) {
        self.key = key
        self.title = title
        self.fileName = fileName
    }
    
    convenience init(key:String, title:String, fileName:String, fromScore:Int, toScore:Int) {
        self.init(key: key, title: title, fileName: fileName)
        self.fromScore = fromScore
        self.toScore = toScore
    }
}

class TypeMapRepo {
    var dataItems:[TypeMap]!
    
    init() {
        dataItems = []
        setup()
    }
    
    func setup()  {
        dataItems.append(contentsOf:[
            TypeMap(key:"title", title: "Title", fileName:"title"),
            TypeMap(key:"defensive", title: "Defensive", fileName:"defensive", fromScore: 5, toScore: 12),
            TypeMap(key:"conservative", title: "Conservative", fileName:"conservative", fromScore:13, toScore:20),
            TypeMap(key:"balanced", title: "Balanced", fileName:"balanced", fromScore:21, toScore:29),
            TypeMap(key:"balancedgrowth", title: "Balanced Growth", fileName:"balancedgrowth", fromScore:30, toScore:37),
            TypeMap(key:"growth", title: "Growth", fileName:"growth", fromScore:38, toScore:44),
            TypeMap(key:"aggressivegrowth", title: "Aggressive Growth", fileName:"aggressivegrowth", fromScore:45, toScore:50),
            TypeMap(key:"questionnaire", title: "Questionnaire", fileName:"questionnaire"),
            TypeMap(key:"submit", title: "Submit", fileName:"submit")
            ]
        )
    }
}
