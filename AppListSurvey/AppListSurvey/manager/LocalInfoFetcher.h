//
//  LocalInfoManager.h
//  AppListSurvey
//
//  Created by Dai Yue on 15-3-31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LocalInfoFetcher : NSObject

/** 设备唯一ID，第一次启动时生成，保存在UserDefault中 */
+ (NSString*)deviceUUID;

/** 手机型号，对照关系见文档 */
+ (NSString *)deviceVersion;

/** iOS 系统版本 */
+ (NSString*)systemVersion;

/** app 列表，属性字段见文档 */
+ (NSArray*)appList;

@end
