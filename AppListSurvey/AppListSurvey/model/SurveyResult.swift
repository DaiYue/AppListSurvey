//
//  SurveyResult.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class SurveyResult {
    var deviceUUID:String!
    var deviceInfo:DeviceInfo!
    var appList:[AppInfo]
    var answers:[String:SurveyAnswer]

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

    func dictionary() -> [String:AnyObject] {
        var answersDictionary = [String:AnyObject]()
        for (questionId,answer) in answers {
            answersDictionary[questionId] = answer.dictionary()
        }

        var appListArray = [AnyObject]()
        for appInfo in appList {
            appListArray.append(appInfo.dictionary())
        }

        return ["answers":answersDictionary,
                "appList":appListArray,
             "deviceInfo":deviceInfo.dictionary(),
             "deviceUUID":deviceUUID];
    }
}

struct SurveyAnswer {
    var choices:Array<String>?

    init(choice:String) {
        choices = [choice]
    }

    func dictionary() -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        if choices != nil {
            dict["choices"] = choices
        }
        return dict
    }
}

struct DeviceInfo {
    var iOSVersion:String?
    var deviceVersion:String?

    func dictionary() -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        if iOSVersion != nil {
            dict["iOSVersion"] = iOSVersion
        }
        if deviceVersion != nil {
            dict["deviceVersion"] = deviceVersion
        }
        return dict
    }
}

struct AppInfo {
    var bundleId:String?
    var type:String?
    var version:String?
    var appId:NSNumber?
    var appName:String?

    init(appInfoDictionary:NSDictionary) {
        bundleId = appInfoDictionary["bundleId"] as? String
        type = appInfoDictionary["type"] as? String
        version = appInfoDictionary["version"] as? String
        appId = appInfoDictionary["appId"] as? NSNumber
        appName = appInfoDictionary["appName"] as? String
    }

    func dictionary() -> [String:AnyObject] {
        //TODO: refactor this garbage!!!!!!!!!!
        var dict = [String:AnyObject]()
        if bundleId != nil {
            dict["bundleId"] = bundleId
        }
        if type != nil {
            dict["type"] = type
        }
        if version != nil {
            dict["version"] = version
        }
        if appId != nil && appId?.integerValue != 0 {
            dict["appId"] = appId
        }
        if appName != nil {
            dict["appName"] = appName
        }
        return dict
    }
}
