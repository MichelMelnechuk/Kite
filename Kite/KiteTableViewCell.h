//
//  KiteTableViewCell.h
//  Kite
//
//  Created by Air on 01.12.14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KiteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textOfMessage;
@property (weak, nonatomic) IBOutlet UILabel *msgDate;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
