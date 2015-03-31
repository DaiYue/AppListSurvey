//
//  EndVC.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class EndVC: UIViewController {

    @IBOutlet weak var sendStatisticsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sendStatisticsAction(sender: AnyObject) {
        sendStatisticsButton.setTitle("正在发送...", forState: UIControlState.Normal)
        if SurveyResultStore.sharedInstance.sendResult() == true {
            sendStatisticsButton.setTitle("发送成功:)", forState: UIControlState.Normal)
            sendStatisticsButton.enabled = false
        } else {
            sendStatisticsButton.setTitle("发送失败:)", forState: UIControlState.Normal)
            sendStatisticsButton.enabled = true
        }
    }
}
