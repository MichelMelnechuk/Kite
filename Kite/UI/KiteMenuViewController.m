//
//  KiteMenuViewController.m
//  Kite
//
//  Created by ashkinder on 11/4/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "KiteMenuViewController.h"
#import "Constants.h"
#import "KiteMenuCell.h"
#import "UITabBarController+hideTabBar.h"

@interface KiteMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuWidth;
@property (nonatomic) BOOL menuPresent;
@property (weak, nonatomic) IBOutlet UIView *menuPanel;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *items;
@property (weak, nonatomic) UITabBarController *embededTabBar;
@property (weak, nonatomic) IBOutlet UIView *containderView;
@property (strong,nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation KiteMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleTaps)];
    [self.tapGestureRecognizer setDelegate:self];
    
    [self.containderView addGestureRecognizer:self.tapGestureRecognizer];
    self.menuWidth.constant = 0.f;
    [self.view layoutIfNeeded];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:78/255.f
                                                                           green:192/255.f
                                                                            blue:96/255.f
                                                                           alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]];
    self.menuPresent = NO;
    self.menuTableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.menuTableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - user actions
                                 
- (void)handleTaps
{
    if (self.menuPresent)
    {
        [self showMenu:nil];
    }
}

- (IBAction)showMenu:(UIBarButtonItem *)sender
{
    [self.view layoutIfNeeded];
    self.menuWidth.constant = !self.menuPresent ? kItemSide : 0.f;
    [UIView animateWithDuration:0.75f animations:^{
        [self.view layoutIfNeeded];
    }];
    self.menuPresent = !self.menuPresent;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KiteMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuItemCellIdentifier];
    cell.image.image = ((UITabBarItem *)self.items[indexPath.row]).image;
    cell.title.text = ((UITabBarItem *)self.items[indexPath.row]).title;
    cell.title.textColor = [UIColor whiteColor];
    if (indexPath.row == self.embededTabBar.selectedIndex) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selectedItem.png"]];
    } else {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ItemBack.png"]];
    }
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.embededTabBar setSelectedIndex:indexPath.row];
    [self.menuTableView reloadData];
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kWrapTabBarSegueIdentifier]) {
        UITabBarController *tabBarVC = (UITabBarController *)segue.destinationViewController;
        _items = tabBarVC.tabBar.items;
        _embededTabBar = tabBarVC;
        [tabBarVC hideTabBar];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
