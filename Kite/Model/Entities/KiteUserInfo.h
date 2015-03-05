//
//  KiteUserInfo.h
//  Kite
//
//  Created by ashkinder on 11/23/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KiteUserInfo : NSManagedObject

@property (nonatomic) NSTimeInterval avatar;
@property (nonatomic, retain) NSString * nick;
@property (nonatomic, retain) NSString * personalStatus;
@property (nonatomic, retain) NSManagedObject *contact;

@end
