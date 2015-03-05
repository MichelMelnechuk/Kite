//
//  KiteContact.h
//  Kite
//
//  Created by ashkinder on 11/23/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KiteMessage, KiteUser, KiteUserInfo;

@interface KiteContact : NSManagedObject

@property (nonatomic) int16_t presentance;
@property (nonatomic, retain) NSString * sipURI;
@property (nonatomic) int16_t status;
@property (nonatomic, retain) NSSet *inbox;
@property (nonatomic, retain) KiteUserInfo *info;
@property (nonatomic, retain) NSSet *outbox;
@property (nonatomic, retain) KiteUser *user;
@property (nonatomic, retain) KiteUser *owner;
@end

@interface KiteContact (CoreDataGeneratedAccessors)

- (void)addInboxObject:(KiteMessage *)value;
- (void)removeInboxObject:(KiteMessage *)value;
- (void)addInbox:(NSSet *)values;
- (void)removeInbox:(NSSet *)values;

- (void)addOutboxObject:(KiteMessage *)value;
- (void)removeOutboxObject:(KiteMessage *)value;
- (void)addOutbox:(NSSet *)values;
- (void)removeOutbox:(NSSet *)values;

@end
