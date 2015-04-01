//
//  QuestionnaireStore.swift
//  AppListSurvey
//
//  Created by yue.dai on 15/3/29.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

import UIKit

class QuestionnaireStore {
    class var sharedInstance: QuestionnaireStore {
        struct Static {
            static let instance = QuestionnaireStore()
        }
        return Static.instance
    }

    let questions:Array<SurveyQuestion> = [
        SurveyQuestion(questionId:"1_1", question: "喜好异性", answers: ["男","女"]),
        SurveyQuestion(questionId:"1_2", question: "用户性别", answers: ["男","女"]),
        SurveyQuestion(questionId:"1_3", question: "薪水水平", answers: ["0-5K","5-10K","10-20K","2-K以上"]),
        SurveyQuestion(questionId:"1_4", question: "教育水平", answers: ["二本下","一本或硕士","博士上"]),
        SurveyQuestion(questionId:"1_5", question: "是否有婴儿", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_6", question: "是否社交狂人", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_7", question: "是否购物达人", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_8", question: "是否猎奇心理强", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_9", question: "年龄范围", answers: ["10-18","19-26","27-35","36-45","45以上"]),
        SurveyQuestion(questionId:"1_10", question: "婚姻状况", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_11", question: "是否有宠物", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_12", question: "是否怀孕", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_13", question: "是否有年迈父母", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_14", question: "是否热爱健身", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_15", question: "是否有海外留学背景", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_16", question: "是否热爱旅游", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_17", question: "热衷欧美海淘、喜欢咖啡馆、酒吧、境外游、西餐", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_18", question: "热衷无印良品、日韩餐、日韩海淘、宜家（虽然是瑞典）、喜欢猫、多肉植物、五道营、田子坊", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_19", question: "热衷中式服装、手串、茶叶", answers: ["是","否"]),
        SurveyQuestion(questionId:"1_20", question: "热衷火锅、烤鱼、羊蝎子、演唱会、爱看综艺节目、电视剧、小说类app", answers: ["是","否"])
    ]

    func question(#index: Int) -> SurveyQuestion? {
        if index >= questions.count {
            return nil
        }
        return questions[index]
    }

    func totalQuestionCount() -> Int {
        return questions.count
    }
}
