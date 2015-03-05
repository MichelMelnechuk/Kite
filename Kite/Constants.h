//
//  Constants.h
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Error handling
static NSString *const kErrorDescriptionKey = @"Description";
#pragma mark - Security
static NSString * const kAECKey = @"I love you so much";

#pragma mark - NSUserDefaults
static NSString *const kLastUserKey = @"LastUser";

#pragma mark - KiteMenu
static NSString *const kMenuItemCellIdentifier = @"MenuItemCellIdentifier";
static const float kItemSide = 60.f;

#pragma mark - Segue Identifiers
static NSString *const kWrapTabBarSegueIdentifier = @"wrapTabBar";

@interface Constants : NSObject

@end
