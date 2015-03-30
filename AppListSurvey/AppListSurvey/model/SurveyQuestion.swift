//
//  SurveyQuestion.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/29.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

struct SurveyQuestion {
    var question:String
    var answers:Array<String>

    init(question:String, answers:Array<String>) {
        self.question = question
        self.answers = answers
    }
}
