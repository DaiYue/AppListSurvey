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

    func fetchLocalInfo() {
        // deviceUUID
        result.deviceUUID = LocalInfoFetcher.deviceUUID()
        
        // deviceInfo
        result.deviceInfo = DeviceInfo(iOSVersion:LocalInfoFetcher.systemVersion(), deviceVersion:LocalInfoFetcher.deviceVersion())

        // appList
        for appInfoDictionary in LocalInfoFetcher.appList() {
            let appInfo = AppInfo(appInfoDictionary: appInfoDictionary as NSDictionary)
            result.addApp(appInfo)
        }
    }

    func sendResult() -> Bool {
        let resultObject = AVObject(className: "SurveyResult", dictionary: result.dictionary())
        return resultObject.save()
    }
}
