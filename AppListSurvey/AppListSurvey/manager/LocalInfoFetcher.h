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

+ (NSString *)deviceVersion;
+ (NSString*)systemVersion;
+ (NSArray*)appList;

@end
