//
//  KiteAccountManager.m
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "KiteAccountManager.h"
#import "KiteMessanger.h"
#import "KiteUser.h"
#import <PortSIPLib/PortSIPSDK.h>
#import "NSData+AES128.h"
#import "Constants.h"
#import "KiteContact.h"

@implementation KiteAccountManager

- (BOOL)signInWithUserName:(NSString *)userName
                  password:(NSString *)password
                 andDomain:(NSString *)domain
                     error:(NSError *__autoreleasing *)error
{
    NSData *encryptPassword = [[password dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:kAECKey];
    BOOL result = YES;
    _currentUser = [self searchUserWithName:userName password:encryptPassword];
    
    if (!_currentUser) {
        _currentUser = [self addUserWithName:userName
                                    password:encryptPassword
                                   andDomain:domain
                                       error:error];
    }
    int ret = [[KiteMessanger sharedInstance].sipSDK initialize:TRANSPORT_UDP
                                                       loglevel:PORTSIP_LOG_NONE
                                                        logPath:NULL
                                                        maxLine:8
                                                          agent:@"PortSIP SDK for IOS"
                                             virtualAudioDevice:FALSE
                                             virtualVideoDevice:FALSE];
    
    if (ret == 0) {
        ret = [[KiteMessanger sharedInstance].sipSDK setUser:userName //delete res
                                                 displayName:userName
                                                    authName:userName
                                                    password:password
                                                     localIP:@"0.0.0.0"
                                                localSIPPort:1234
                                                  userDomain:@""
                                                   SIPServer:domain
                                               SIPServerPort:5060
                                                  STUNServer:@""
                                              STUNServerPort:0
                                              outboundServer:@""
                                          outboundServerPort:0];
        if (ret == 0) {
            ret = [[KiteMessanger sharedInstance].sipSDK setLicenseKey:@"PORTSIP_TEST_LICENSE"];
            if (ret == 0 || ret == ECoreTrialVersionLicenseKey) {
               [[KiteMessanger sharedInstance].sipSDK registerServer:90 retryTimes:1];
            } else  {
                *error = [[KiteMessanger sharedInstance].accountManager userFriendlyErrorForSipErrCode:ret];
                result = NO;
            }
        } else {
           *error = [[KiteMessanger sharedInstance].accountManager userFriendlyErrorForSipErrCode:ret];
            result = NO;
        }
    } else {
        *error = [[KiteMessanger sharedInstance].accountManager userFriendlyErrorForSipErrCode:ret];
        result = NO;
    }
    
    if (!_currentUser  ) {
        result = NO;
    }
    return result;
}

- (void)signOut
{
    _currentUser = nil;
    [[KiteMessanger sharedInstance].sipSDK unRegisterServer];
    [[KiteMessanger sharedInstance].sipSDK unInitialize];
}

- (KiteUser *)searchUserWithName:(NSString *)userName
                        password:(NSData *)password
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sipURI == %@ AND password == %@", userName, password];
    NSArray *users = [self queryUsersUsingPredicate:predicate];
    return users.count ? users.firstObject : nil;
}

- (KiteUser *)addUserWithName:(NSString *)userName
                     password:(NSData *)password
                    andDomain:(NSString *)domain
                        error:(NSError *__autoreleasing *)error
{
    NSString *entityName = NSStringFromClass([KiteUser class]);
    NSManagedObjectContext *context = [KiteMessanger sharedInstance].dbContext;
    KiteUser *user = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                   inManagedObjectContext:context];
    NSString *contactEntity = NSStringFromClass([KiteContact class]);
    
    KiteContact *selfContact = [NSEntityDescription insertNewObjectForEntityForName:contactEntity
                                                             inManagedObjectContext:context];
    selfContact.sipURI = userName;
    
    user.sipURI = userName;
    user.password = password;
    user.domain = domain;
    user.selfContact = selfContact;
    selfContact.owner = user;
    
    NSError *err = nil;
    [[KiteMessanger sharedInstance] saveContextWithError:&err];
    if (err) {
        *error = err;
        user = nil;
    }
    return user;
}

- (NSArray *)queryUsersUsingPredicate:(NSPredicate *)predicate
{
    NSString *entityName = NSStringFromClass([KiteUser class]);
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:entityName];
    request.predicate = predicate;
    return [[KiteMessanger sharedInstance].dbContext executeFetchRequest:request
                                                                   error:nil];
}

- (NSError *)userFriendlyErrorForSipErrCode:(int)errorCode
{ 
    NSString *description = nil;
    switch (errorCode) {
        case 6000:
            description = @"CoreAlreadyInitialized	" ;
        break;
        case 6001:
            description = @"CoreNotInitialized	" ;
            break;
        case 6002:
            description = @"CoreSDKObjectNull	" ;
            break;
        case 6003:
            description = @"CoreArgumentNull	" ;
            break;
        case 6004:
            description = @"CoreInitializeWinsockFailure	" ;
            break;
            
            default: description = @"you are looser bro";
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:kErrorDescriptionKey];
    NSError *err = [NSError errorWithDomain:@"Registration error" code:errorCode userInfo:userInfo];
    return err;
};

@end
