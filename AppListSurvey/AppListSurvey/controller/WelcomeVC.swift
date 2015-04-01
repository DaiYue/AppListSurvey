//
//  WelcomeVC.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/29.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SurveyResultStore.sharedInstance.fetchLocalInfo()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - Actions

    @IBAction func startAction(sender: AnyObject) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        NavigationHandler.jumpToSurveyVC(questionIndex: 0)
    }

}
