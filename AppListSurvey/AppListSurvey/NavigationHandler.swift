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
        var keyWindow = UIApplication.sharedApplication().delegate?.window!
        var rootNavigationController = keyWindow?.rootViewController as UINavigationController

        return rootNavigationController
    }

    class func jumpToSurveyVC(#questionIndex:Int){
        var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var nextVC = storyBoard.instantiateViewControllerWithIdentifier("SurveyVC") as SurveyVC
        nextVC.questionIndex = questionIndex

        mainNavigationController().pushViewController(nextVC, animated: true)
    }

    class func jumpToEndVC(){
        var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var endVC = storyBoard.instantiateViewControllerWithIdentifier("EndVC") as UIViewController

        mainNavigationController().pushViewController(endVC, animated: true)
    }
}
