//
//  SIPRegistrationDelegate.h
//  Kite
//
//  Created by Air on 04.11.14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SIPRegistrationDelegate <NSObject>

//char* - > NSString*
- (void)onRegisterSuccess:(NSString*) statusText statusCode:(int)statusCode;
- (void)onRegisterFailure:(NSString*) statusText statusCode:(int)statusCode;

@end
