//
//  KiteLoginViewController.h
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KiteLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch *switcherRem;


- (IBAction)switcherChanged:(id)sender;

@end
