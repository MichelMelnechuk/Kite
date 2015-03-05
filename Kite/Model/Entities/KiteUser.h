//
//  KiteUser.h
//  Kite
//
//  Created by ashkinder on 11/23/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KiteUser : NSManagedObject

@property (nonatomic, retain) NSString * domain;
@property (nonatomic, retain) NSData * password;
@property (nonatomic, retain) NSString * sipURI;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSManagedObject *selfContact;
@end

@interface KiteUser (CoreDataGeneratedAccessors)

- (void)addContactsObject:(NSManagedObject *)value;
- (void)removeContactsObject:(NSManagedObject *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

@end
