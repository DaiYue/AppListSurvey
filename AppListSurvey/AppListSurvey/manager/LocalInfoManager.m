//
//  LocalInfoManager.m
//  AppListSurvey
//
//  Created by Dai Yue on 15-3-31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

#import "LocalInfoManager.h"
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/utsname.h>
#include <objc/runtime.h>

@implementation LocalInfoManager

+ (NSString *) platformString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    return @"";
}

+ (void)getLocalInfo {
    
    
    NSLog(@"%@",[self platformString]);
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    
    
    
    
    //设备名称
    NSLog(@"name: %@", [[UIDevice currentDevice] name]);
    //系统名称
    NSLog(@"systemName: %@", [[UIDevice currentDevice] systemName]);
    //系统版本
    NSLog(@"systemVersion: %@", [[UIDevice currentDevice] systemVersion]);
}

@end
