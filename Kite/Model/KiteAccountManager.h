//
//  KiteAccountManager.h
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPCallbackEventsProxy.h"

@class KiteUser;

@interface KiteAccountManager : NSObject

@property (strong, nonatomic, readonly) KiteUser *currentUser;

- (BOOL)signInWithUserName:(NSString *)userName
                  password:(NSString *)password
                 andDomain:(NSString *)domain
                     error:(NSError **)error;
- (void)signOut;
- (NSArray *)queryUsersUsingPredicate:(NSPredicate *)predicate;

@end
