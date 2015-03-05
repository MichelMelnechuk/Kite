//
//  NSData.h
//  Kite
//
//  Created by Air on 06.11.14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (AES128)

-(NSData*)AES256EncryptWithKey:(NSString*)key;

-(NSData*)AES256DecryptWithKey:(NSString*)key;

@end
