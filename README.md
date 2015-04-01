# AppListSurvey

AppListSurvey 是一个用于收集用户安装的 app list 与用户个人信息的 iOS app。简易文档如下：

## 流程

界面跳转：`WelcomeVC` -> `SurveyVC` -> `SurveyVC` -> ... -> `EndVC`

逻辑流程：首次运行时生成设备ID -> 收集用户数据 -> 让用户答题 -> 答题结束后发送数据

## 工程结构

共有 manager、controller、model 3 个 group。

### manager

`LocalInfoFetcher` : 用于获取设备信息，如系统版本、手机型号和 app list 等。首次运行时生成设备ID，保存在`UserDefault`中，此后从`UserDefault`中取出设备ID。

`NavigationHandler` : 管理跳转。

### controller

`WelcomeVC` : 显示欢迎语，收集用户数据，存储在`SurveyResultStore`中。

`SurveyVC` : 显示问题，用户选择答案，存储在`SurveyResultStore`中。

`EndVC` : 显示结束语，发送数据。

### model 

`SurveyQuestion` : 调查问题数据结构

`QuestionnaireStore` : 调查问卷Store，负责存储调查问题

`SurveyResult` : 调查结果数据结构

`SurveyResultStore` : 调查结果Store，负责存储答案、发送数据

## 数据结构

一条数据格式示例：

```
 {
  "deviceUUID": "289AB186-061C-4C65-A8D5-BE361CC169F1",
  "deviceInfo": {
    "deviceVersion": "iPhone7,1",
    "iOSVersion": "8.2"
  },
  "answers": {
    "1_1": {
      "choices": [
        "1"
      ]
    },
    "1_2": {
      "choices": [
        "1"
      ]
    }
  },
  "appList": [
    {
      "version": "1.0",
      "type": "System",
      "bundleId": "com.apple.Passbook"
    },
    {
      "appId": 863882795,
      "appName": "斗鱼TV",
      "type": "User",
      "bundleId": "tv.douyu.live",
      "version": "1.01"
    }
  ],
  "ACL": {
    "*": {
      "write": true,
      "read": true
    }
  },
  "objectId": "551bb86ce4b0201c860210f3",
  "createdAt": "2015-04-01T17:20:44.978Z",
  "updatedAt": "2015-04-01T17:20:44.978Z"
}
```

字段说明：

- `deviceUUID` : `String` _必有_ &#160;&#160; 设备唯一ID，32位UUID。首次运行时生成。
- `deviceInfo` : `JsonObject` _必有_&#160;&#160; 设备信息
  - `deviceVersion` : `String` _必有_&#160;&#160; 设备型号。对照表后附。
  - `iOSVersion` : `String` _必有_&#160;&#160; 系统版本
- `answers` : `JsonObject` _必有_&#160;&#160; key数与问题数相等。
  - `1_1` : `String` 问题id。下划线前为文件版本，后为题号。
    - `choices` : `JsonArray` _选择题必有，其他没有_&#160;&#160; 回答选项。每个选项为一个字符串格式的数字，表示选项序号，从0开始。
- `appList` : `JsonArray` _必有_&#160;&#160; app 列表。每个元素对应一个 app。
  - `bundleId` : `String` _必有_&#160;&#160; app bundle ID
  - `appName` : `String` _可选_&#160;&#160; app 名
  - `appId` : `String` _可选_&#160;&#160; appStore ID
  - `version` : `String` _可选_&#160;&#160; app 版本。
  - `type` : `String` _必有_&#160;&#160; 取值为`"User"`或`"System"`
- `createdAt` : `ISODate` _必有_&#160;&#160; 数据创建时间 
- `updatedAt` : `ISODate` _必有_&#160;&#160; 数据最后更新时间   

## 相关数据

### 问卷数据
```
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
```

### 文案

欢迎语：

```
这里是一些参与调查的说明。如：  欢迎参加xxxx调查，接下来请选择符合自己情况的选项。Have a nice day!
```

结束语：

```
写一些结束语，如：谢谢您的参与，您将得到一栋豪华别墅 / 一辆炫酷跑车 / 一部崭新iPhone 6 Plus / 帮助别人的满足感和一天愉快的心情
```

### 设备型号对应关系

不全，缺一些新款。遇到再补充。

| Proxy         | Device        |
| ------------- | ------------- |
| iPhone1,1      | iPhone 1G |
| iPhone1,2      | iPhone 3G      |
| iPhone2,1 | iPhone 3GS     |
| iPhone3,1 | iPhone 4     |
| iPhone3,3 | Verizon iPhone 4     |
| iPod1,1 | iPod Touch 1G     |
| iPod2,1 | iPod Touch 2G     |
| iPod3,1 | iPod Touch 3G     |
| iPod4,1 | iPod Touch 4G     |
| iPad1,1 | iPad     |
| iPad2,1 | iPad 2 (Wifi)     |
| iPad2,2 | iPad 2 (GSM)    |
| iPad2,3 | iPad 2 (CDMA)    |
| i386 | Simulator     |

_有问题请联系[daiyue10@gmail.com](mailto:daiyue10@gmail.com)_