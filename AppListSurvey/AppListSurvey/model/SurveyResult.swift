//
//  SurveyResult.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class SurveyResult {
    var answers:[String:SurveyAnswer]
    var appList:[AppInfo]
    var deviceInfo:DeviceInfo!

    init () {
        answers = [:]
        appList = []
    }

    func saveAnswer(#questionId:String, choice:String) {
        answers[questionId] = SurveyAnswer(choice: choice)
    }

    func addApp(appInfo:AppInfo) {
        appList.append(appInfo)
    }
}

struct SurveyAnswer {
    var choices:Array<String?>?

    init(choice:String) {
        choices = [choice]
    }
}

struct DeviceInfo {
    var iOSVersion:String?
    var deviceVersion:String?
}

struct AppInfo {
    var bundleId:String?
    var type:String?
    var version:String?
    var appId:String?
    var appName:String?

    init(appInfoDictionary:[String:String]) {
        bundleId = appInfoDictionary["bundleId"]
        type = appInfoDictionary["type"]
        version = appInfoDictionary["version"]
        appId = appInfoDictionary["appId"]
        appName = appInfoDictionary["appName"]
    }
}
