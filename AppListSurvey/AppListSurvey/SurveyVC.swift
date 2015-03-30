//
//  ViewController.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/29.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class SurveyVC: UIViewController {

    var questionIndex:Int!
    var question:SurveyQuestion!

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // model
        question = QuestionnaireStore.question(index: questionIndex)

        // progress
        self.progressLabel.text = String(format: "%d/%d", questionIndex + 1, QuestionnaireStore.totalQuestionCount())

        // question
        self.questionLabel.text = question.question

        // answers
        var screenWidth = UIScreen.mainScreen().bounds.width
        var screenHeight = UIScreen.mainScreen().bounds.height
        var width = Float(screenWidth) / Float(question.answers.count)
        for var i = 0; i < question.answers.count; i++ {
            var answer = question.answers[i]
            var button = answerButton(title: answer, tag: i)
            button.frame = CGRectMake(CGFloat(Float(i) * Float(width)), CGFloat(Float(screenHeight) - width), CGFloat(width), CGFloat(width))
            self.view.addSubview(button)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - View

    func answerButton(#title:String, tag:Int) -> UIButton! {
        var button = UIButton()
        button.setTitle(title, forState: UIControlState.Normal)
        button.tag = tag
        var fontSize:Int
        switch question.answers.count {
        case 0...2:
            fontSize = 100
        default:
            fontSize = 20
        }
        button.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(fontSize))
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.addTarget(self, action: "answerClickedAction:", forControlEvents: UIControlEvents.TouchUpInside)

        if tag % 2 == 0 {
            button.setBackgroundImage(UIImage(named: "bg1.png"), forState: UIControlState.Normal)
        } else {
            button.setBackgroundImage(UIImage(named: "bg2.png"), forState: UIControlState.Normal)
        }

        return button
    }

    // MARK: - Action

    func answerClickedAction(sender: AnyObject) {
        if questionIndex + 1 >= QuestionnaireStore.totalQuestionCount() {
            NavigationHandler.jumpToEndVC()
        } else {
            NavigationHandler.jumpToSurveyVC(questionIndex: questionIndex + 1)
        }
    }

}

