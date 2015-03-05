//
//  SIPCallbackEventsProxy.h
//  Kite
//
//  Created by Air on 04.11.14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PortSIPLib/PortSIPEventDelegate.h>
#import "SIPRegistrationDelegate.h"

@interface SIPCallbackEventsProxy : NSObject <PortSIPEventDelegate>

@property (strong, nonatomic) id<SIPRegistrationDelegate> regDelegate;

- (void)onRegisterSuccess:(char *) statusText statusCode:(int)statusCode;
- (void)onRegisterFailure:(char *) statusText statusCode:(int)statusCode;
- (void)onInviteIncoming:(long)sessionId
       callerDisplayName:(char*)callerDisplayName
                  caller:(char*)caller
       calleeDisplayName:(char*)calleeDisplayName
                  callee:(char*)callee
             audioCodecs:(char*)audioCodecs
             videoCodecs:(char*)videoCodecs
             existsAudio:(BOOL)existsAudio
             existsVideo:(BOOL)existsVideo;


@end
