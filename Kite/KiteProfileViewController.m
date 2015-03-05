//
//  KiteProfileViewController.m
//  Kite
//
//  Created by Air on 10.11.14.
//  Copyright (c) 2014 Air. All rights reserved.
//


#import "KiteProfileViewController.h"
#import "KiteMessanger.h"
#import "KiteAccountManager.h"

@interface KiteProfileViewController() <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIImageView *profileContent;
@property (weak, nonatomic) IBOutlet UIImageView *leftProfileColum;
@property (weak, nonatomic) IBOutlet UIImageView *rightProfileColum;
@property (weak, nonatomic) IBOutlet UILabel *displayNameField;
@property (strong,nonatomic) UITapGestureRecognizer *tapGestoreRecongnizer;

-(void)getPhoto:(id)sender;

@end

@implementation KiteProfileViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        self.view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class])
                                                  owner:self
                                                options:nil]firstObject];
    }
    
    self.profileContent.backgroundColor = [UIColor colorWithRed:68.f/225
                                                          green:68.f/225
                                                           blue:68.f/225
                                                          alpha:1];
    self.leftProfileColum.backgroundColor = [UIColor colorWithRed:78.f/225
                                                             green:182.f/225
                                                              blue:96.f/225
                                                             alpha:1];
    self.rightProfileColum.backgroundColor = [UIColor colorWithRed:51.f/225
                                                             green:69.f/225
                                                              blue:79.f/225
                                                             alpha:1];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.layer.masksToBounds = YES;
    NSString * str =[[KiteMessanger sharedInstance].accountManager.currentUser sipURI];
    self.displayNameField.text = str;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tapGestoreRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(handleTaps)];
    [self.profilePicture addGestureRecognizer:self.tapGestoreRecongnizer];
}

- (void)handleTaps {
    [self getPhoto:nil];
}

- (void)getPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.profilePicture = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
