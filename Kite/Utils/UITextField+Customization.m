//
//  UITextField+Customization.m
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "UITextField+Customization.h"

@implementation UITextField (Customization)

- (void)customize
{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 2.f;
    self.layer.borderColor = [UIColor colorWithRed:98.0 / 255
                                                         green:191.f / 255
                                                          blue:74.f /255
                                                         alpha:1].CGColor;
    self.layer.masksToBounds = YES;

}
@end
