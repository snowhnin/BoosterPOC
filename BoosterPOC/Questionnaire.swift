//
//  Questionnaire.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import Foundation

class Questionnaire {
    var question:String!
    var answers:[Answer]!
    
    init(question:String, answers:Array<Answer>) {
        self.question = question
        self.answers = answers
    }
}

class Answer {
    var title:String!
    var score:Int!
    
    init(title:String, score:Int) {
        self.title = title
        self.score = score
    }
}

class QuestionnaireRepo {
    var data:[Questionnaire]!
    var currentQuestionnaire:Questionnaire!
    
    init() {
        self.setup()
    }
    
    func getNext() -> Questionnaire! {
        if let position = data.index(where: { $0 === currentQuestionnaire}) {
            if position < data.count-1 {
                currentQuestionnaire = data[position+1]
            }
            else {
                return nil
            }
        }
        else {
            currentQuestionnaire = data[0]
        }
        return currentQuestionnaire
    }
    
    func setup() {
        data = []
        data.append(
            Questionnaire(
                question:"Question 1:\n\nWhen do you plan to make a signiicant lump sum withdrawal from your portfolio, for example, for the purchase of a irst home or for retirement needs? (From age 65 at the earliest)", answers:[
                    Answer(title:"Within 2 years", score:1),
                    Answer(title:"In 2 to 5 years", score:3),
                    Answer(title:"In 6 to 10 years", score:5),
                    Answer(title:"In 11 to 20 years", score:7),
                    Answer(title:"More than 20 years", score:10)
                ]
            )
        )
        
        data.append(
            Questionnaire(
                question:"Question 2:\n\nWhich of the following questions best describes your thoughts about risks and returns?", answers:[
                    Answer(title:"minimise my risk and accept low returns", score:1),
                    Answer(title:"take a moderate amount of risk to generate low to medium returns", score:3),
                    Answer(title:"take a reasonable amount of risk to provide a more medium return", score:5),
                    Answer(title:"to receive higher returns, take a relatively high amount of risk", score:7),
                    Answer(title:"maximise my returns and accept a high level of risk", score:10)
                ]
            )
        )
        
        data.append(
            Questionnaire(
                question:"Question 3:\n\nProtecting my investment portfolio from a fall in value at any time is more important to me than achieving high returns?", answers:[
                    Answer(title:"Strongly Agree", score:1),
                    Answer(title:"Agree", score:3),
                    Answer(title:"Neither agree or disagree", score:5),
                    Answer(title:"Disagree", score:6),
                    Answer(title:"Strongly Disagree", score:10)
                ]
            )
        )
        
        data.append(
            Questionnaire(
                question:"Question 4:\n\nConsider you have an investment balance of at least $20,000 or more. If after a short period of time (less than 1 year) your balance has dropped in value, which statement relects best how you would feel about this?", answers:[
                    Answer(title:"I would be unhappy with any drop in value", score:1),
                    Answer(title:"I would be OK with a drop in value of no more than 5%", score:3),
                    Answer(title:"I would be OK with a drop in value of no more than 10%", score:5),
                    Answer(title:"I would be OK with a drop in value of up to 15%", score:6),
                    Answer(title:"I would be OK with a drop in value of up to 20%", score:10)
                ]
            )
        )
        
        data.append(
            Questionnaire(
                question:"Question 5:\n\nHow often would you tend to worry about your investment returns?", answers:[
                    Answer(title:"Daily", score:1),
                    Answer(title:"Monthly", score:3),
                    Answer(title:"Quarterly", score:5),
                    Answer(title:"Annually", score:6),
                    Answer(title:"Never or only occasionally over the longer term", score:10)
                ]
            )
        )
    }
}
