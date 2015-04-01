//
//  LocalInfoManager.m
//  AppListSurvey
//
//  Created by Dai Yue on 15-3-31.
//  Copyright (c) 2015年 Senz+. All rights reserved.
//

#import "LocalInfoFetcher.h"
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/utsname.h>
#include <objc/runtime.h>

static NSString* const kDeviceUUIDKey = @"deviceUUID";

@implementation LocalInfoFetcher

/*
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
*/

+ (NSString *)deviceVersion {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);

    return platform;
}

+ (NSString*)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

/*

 @property(readonly) NSArray * UIBackgroundModes;
 @property(readonly) NSArray * VPNPlugins;
 @property(readonly) NSArray * appTags;
 @property(readonly) NSString * applicationDSID;
 @property(readonly) NSString * applicationIdentifier;
 @property(readonly) NSString * applicationType;
 @property(readonly) NSArray * audioComponents;
 @property(readonly) NSString * bundleVersion;
 @property(readonly) NSArray * deviceFamily;
 @property(readonly) NSUUID * deviceIdentifierForVendor;
 @property(readonly) NSArray * directionsModes;
 @property(readonly) NSNumber * dynamicDiskUsage;
 @property(readonly) NSArray * externalAccessoryProtocols;
 @property(readonly) BOOL fileSharingEnabled;
 @property(readonly) NSDictionary * groupContainers;
 @property(readonly) NSArray * groupIdentifiers;
 @property(readonly) BOOL hasSettingsBundle;
 @property(readonly) BOOL iconIsPrerendered;
 @property(readonly) NSProgress * installProgress;
 @property(readonly) unsigned int installType;
 @property(readonly) BOOL isAppUpdate;
 @property(readonly) BOOL isBetaApp;
 @property(readonly) BOOL isContainerized;
 @property(readonly) BOOL isInstalled;
 @property(readonly) BOOL isNewsstandApp;
 @property(readonly) BOOL isPlaceholder;
 @property(readonly) BOOL isPurchasedReDownload;
 @property(readonly) BOOL isRestricted;
 @property(readonly) BOOL isWatchKitApp;
 @property(readonly) NSNumber * itemID;
 @property(readonly) NSString * itemName;
 @property(readonly) NSString * minimumSystemVersion;
 @property(readonly) unsigned int originalInstallType;
 @property(readonly) NSArray * plugInKitPlugins;
 @property(readonly) BOOL profileValidated;
 @property(readonly) NSArray * requiredDeviceCapabilities;
 @property(readonly) NSString * roleIdentifier;
 @property(readonly) NSString * sdkVersion;
 @property(readonly) NSString * shortVersionString;
 @property(readonly) NSString * sourceAppIdentifier;
 @property(readonly) NSNumber * staticDiskUsage;
 @property(readonly) NSString * storeCohortMetadata;
 @property(readonly) NSNumber * storeFront;
 @property(readonly) BOOL supportsAudiobooks;
 @property(readonly) BOOL supportsExternallyPlayableContent;
 @property(readonly) NSString * teamID;
 @property(readonly) NSString * vendorName;
 */

+ (NSArray*)appList {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];

    NSMutableArray* array = [NSMutableArray array];
    for (id applicationProxy in [workspace performSelector:@selector(allApplications)]) {
        NSMutableDictionary* appInfoDictionary = [NSMutableDictionary dictionary];
        [self dictionary:appInfoDictionary setObjectSafe:[applicationProxy performSelector:@selector(applicationIdentifier)] forKey:@"bundleId"];
        [self dictionary:appInfoDictionary setObjectSafe:[applicationProxy performSelector:@selector(applicationType)] forKey:@"type"];
        [self dictionary:appInfoDictionary setObjectSafe:[applicationProxy performSelector:@selector(bundleVersion)] forKey:@"version"];
        [self dictionary:appInfoDictionary setObjectSafe:[applicationProxy performSelector:@selector(itemID)] forKey:@"appId"];
        [self dictionary:appInfoDictionary setObjectSafe:[applicationProxy performSelector:@selector(itemName)] forKey:@"appName"];
        [array addObject:appInfoDictionary];
    }

#pragma clang diagnostic pop

    return [array copy];
}

+ (void)dictionary:(NSMutableDictionary*)dictionary setObjectSafe:(id)object forKey:(NSString*)key {
    if (object == nil) {
        return;
    }

    dictionary[key] = object;
}

+ (NSString*)deviceUUID {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

    NSString* deviceUUID = [defaults objectForKey:kDeviceUUIDKey];
    if (deviceUUID == nil) {
        deviceUUID = [[NSUUID UUID] UUIDString];
        [defaults setObject:deviceUUID forKey:@"deviceUUID"];
    }

    return deviceUUID;
}

@end
