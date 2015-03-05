//
//  KiteMessanger.h
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SIPCallbackEventsProxy.h"
#import <PortSIPLib/PortSIPSDK.h>
#import "KiteUser.h"
#import "KiteChatManager.h"

@class KiteAccountManager;

@interface KiteMessanger : NSObject 

@property (strong, nonatomic, readonly) KiteAccountManager *accountManager;
@property (strong, nonatomic, readonly) KiteChatManager *chatManager;
@property (strong, nonatomic, readonly) NSManagedObjectContext *dbContext;
@property (strong,nonatomic,readonly) SIPCallbackEventsProxy *SIPEventProxy;
@property (strong,nonatomic,readonly) PortSIPSDK * sipSDK;

+ (instancetype)sharedInstance;
- (void)saveContextWithError:(NSError * __autoreleasing *)error;

@end
