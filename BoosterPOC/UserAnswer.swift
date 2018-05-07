//
//  UserAnswer.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import Foundation

class UserAnswer {
    var answers: [Answer]!
    
    init() {
        answers = []
    }
    
    func getTotalScore() -> Int {
        var total:Int = 0
        answers.forEach {
            total += $0.score
        }
        
        return total
    }
    
    func getInvestorType(totalScore: Int) -> TypeMap! {
        let allType = TypeMapRepo()
        var type:TypeMap!
        allType.dataItems.forEach {
            if $0.fromScore != nil {
                if $0.fromScore <= totalScore && totalScore <= $0.toScore {
                    type = $0
                }
            }
        }
        return type
    }
    
    func add(item: Answer) {
        answers.append(item)
    }
}
