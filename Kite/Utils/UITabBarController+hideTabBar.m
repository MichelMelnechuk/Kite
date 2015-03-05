//
//  UITabBarController+hideTabBar.m
//  Kite
//
//  Created by ashkinder on 11/6/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "UITabBarController+hideTabBar.h"

@implementation UITabBarController (hideTabBar)

- (void)hideTabBar
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    for(UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, screenHeight +20, view.frame.size.width, view.frame.size.height)];
        } else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,screenHeight )];
        }
    }
}

@end
