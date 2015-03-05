//
//  SIPCallbackEventsProxy.m
//  Kite
//
//  Created by Air on 04.11.14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "SIPCallbackEventsProxy.h"


@implementation SIPCallbackEventsProxy

-(void)onRegisterSuccess:(char *)statusText statusCode:(int)statusCode
{
    NSString *statusStr = [NSString stringWithUTF8String:statusText];
    [self.regDelegate onRegisterSuccess:statusStr statusCode:statusCode];
}

- (void)onRegisterFailure:(char*) statusText statusCode:(int)statusCode
{
    NSString *statusStr = [NSString stringWithUTF8String:statusText];
    [self.regDelegate onRegisterFailure:statusStr statusCode:statusCode];
}

- (void)onInviteIncoming:(long)sessionId
       callerDisplayName:(char*)callerDisplayName
                  caller:(char*)caller
       calleeDisplayName:(char*)calleeDisplayName
                  callee:(char*)callee
             audioCodecs:(char*)audioCodecs
             videoCodecs:(char*)videoCodecs
             existsAudio:(BOOL)existsAudio
             existsVideo:(BOOL)existsVideo
{

}
@end
