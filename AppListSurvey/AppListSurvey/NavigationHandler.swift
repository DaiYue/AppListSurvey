//
//  NavigationHandler.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/29.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class NavigationHandler: NSObject {

    class func mainNavigationController() -> UINavigationController {
        let keyWindow = UIApplication.sharedApplication().delegate?.window!
        let rootNavigationController = keyWindow?.rootViewController as UINavigationController

        return rootNavigationController
    }

    class func jumpToSurveyVC(#questionIndex:Int){
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let nextVC = storyBoard.instantiateViewControllerWithIdentifier("SurveyVC") as SurveyVC
        nextVC.questionIndex = questionIndex

        mainNavigationController().pushViewController(nextVC, animated: true)
    }

    class func jumpToEndVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let endVC = storyBoard.instantiateViewControllerWithIdentifier("EndVC") as UIViewController

        mainNavigationController().pushViewController(endVC, animated: true)
    }
}
