//
//  KiteChatManager.h
//  Kite
//
//  Created by ashkinder on 11/14/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KiteChatManager : NSObject

- (void)handleTextMessage:(NSString *)message
                  fromURI:(NSString *)sender
                    toURI:(NSString *)reciver;

@end
