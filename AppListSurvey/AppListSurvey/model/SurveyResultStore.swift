//
//  SurveyResultStore.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class SurveyResultStore: NSObject {

    let result = SurveyResult()

    class var sharedInstance: SurveyResultStore {
        struct Static {
            static let instance = SurveyResultStore()
        }
        return Static.instance
    }

    func sendResult() -> Bool {
        let resultObject = AVObject(className: "SurveyResult", dictionary: result.dictionary())
        return resultObject.save()
    }
}
