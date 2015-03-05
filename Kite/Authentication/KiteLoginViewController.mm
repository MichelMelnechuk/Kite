 //
//  KiteLoginViewController.m
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "KiteLoginViewController.h"
#import "UITextField+Customization.h"
#import "KiteMessanger.h"
#import "KiteAccountManager.h"
#import "Constants.h"
#import "NSData+AES128.h"

@interface KiteLoginViewController () <SIPRegistrationDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sipURIField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *domainField;
@property (weak, nonatomic) IBOutlet UIButton *signIn;

@end

@implementation KiteLoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                  owner:self
                                                options:nil] firstObject];
        [self setupAppearance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillPersistedInfo];
    // Do any additional setup after loading the view from its nib.
    [KiteMessanger sharedInstance].SIPEventProxy.regDelegate = self;
}

#pragma mark - UI
- (void)setupAppearance
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background.png"]];
    [self.sipURIField customize];
    [self.passwordField customize];
    [self.domainField customize];
}

#pragma mark - User Actions
- (IBAction)signIn:(UIButton *)sender
{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NSError *error = nil;
//    if (self.switcherRem.isOn) {
//        [[NSUserDefaults standardUserDefaults] setObject:self.sipURIField.text
//                                                  forKey:kLastUserKey];
//    } else {
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kLastUserKey];
//    }
//    BOOL result = [[KiteMessanger sharedInstance].accountManager signInWithUserName:self.sipURIField.text
//                                                                           password:self.passwordField.text
//                                                                          andDomain:self.domainField.text
//                                                                              error:&error];
//    if (result) {
//        //TODO: Log line
//    } else {
//        NSString *message = [error.userInfo objectForKey:kErrorDescriptionKey];
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.domain
//                                                                       message:message
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok"
//                                                         style:UIAlertActionStyleCancel
//                                                       handler:nil];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
    [self onRegisterSuccess:nil statusCode:0];
}

- (void)fillPersistedInfo
{
    NSString *storedSip = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUserKey];
    if (storedSip) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sipURI == %@", storedSip];
        KiteUser *lastUser = [[[KiteMessanger sharedInstance].accountManager queryUsersUsingPredicate:predicate] firstObject];
        if (lastUser) {
            self.sipURIField.text = lastUser.sipURI;
            self.passwordField.text = [[NSString alloc]initWithData:[lastUser.password AES256DecryptWithKey:kAECKey]
                                                           encoding:NSUTF8StringEncoding];
            self.domainField.text = lastUser.domain;
        }
    }
}

- (void)onRegisterSuccess:(NSString*)statusText statusCode:(int)statusCode
{
    [self performSegueWithIdentifier:@"LoginSegue" sender:self];
}

- (void) onRegisterFailure:(NSString *)statusText statusCode:(int)statusCode
{
    
}

- (IBAction)unwindFromMenu:(UIStoryboardSegue*)sender
{
    [[KiteMessanger sharedInstance].accountManager signOut];
    
}
@end
