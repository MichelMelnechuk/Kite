//
//  KiteMessage.h
//  Kite
//
//  Created by ashkinder on 11/23/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KiteMessage : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSManagedObject *reciver;
@property (nonatomic, retain) NSManagedObject *sender;

@end
