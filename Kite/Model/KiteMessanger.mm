//
//  KiteMessanger.m
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "KiteMessanger.h"
#import "AppDelegate.h"
#import "KiteAccountManager.h"
#import "SIPCallbackEventsProxy.h"

static KiteMessanger *sKitMessanger = nil;

@interface KiteMessanger()
{
    
}

@end

@implementation KiteMessanger 

#pragma mark - initialization

+ (void)initialize
{
    sKitMessanger = [[KiteMessanger alloc]init];
}

+ (instancetype)sharedInstance
{
    if (nil == sKitMessanger) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sKitMessanger = [[KiteMessanger alloc]init];
        });
    }
    return sKitMessanger;
}

- (id)init
{
    self = [super init];
    if (self) {
        _accountManager = [[KiteAccountManager alloc]init];
        _SIPEventProxy = [[SIPCallbackEventsProxy alloc]init];
        _sipSDK = [[PortSIPSDK alloc] init];
        _sipSDK.delegate = _SIPEventProxy;
        _chatManager = [[KiteChatManager alloc]init];
    }
    return self;
}

#pragma mark - overriden properties

- (NSManagedObjectContext *)dbContext
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}

#pragma mark dbLogic 

- (void)saveContextWithError:(NSError *__autoreleasing *)error {
    NSManagedObjectContext *managedObjectContext = self.dbContext;
    if (managedObjectContext != nil) {
        if (![managedObjectContext save:error]) {
            NSLog(@"Unresolved error %@, %@", *error, [*error userInfo]);
        }
    }
}

@end
