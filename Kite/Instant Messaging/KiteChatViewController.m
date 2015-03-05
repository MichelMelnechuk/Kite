//
//  KiteChatViewController.m
//  Kite
//
//  Created by ashkinder on 11/9/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "KiteChatViewController.h"
#import "KiteTableViewCell.h"
#import "KiteOtherTableViewCell.h"

@interface KiteChatViewController ()<UITextViewDelegate, UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputContainerHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *inputMessages;
@property (strong, nonatomic) NSMutableArray *usersMessages;

@end

@implementation KiteChatViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class])
                                                  owner:self
                                                options:nil]firstObject];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.inputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputView.layer.borderWidth = 1.f;
    self.inputView.layer.cornerRadius = 10.f;
    self.inputView.layer.masksToBounds = YES;
    self.inputView.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.usersMessages = [[NSMutableArray alloc]initWithObjects:@"Loh", nil];
    self.inputMessages = [[NSMutableArray alloc] initWithObjects:@"Hi here i am", nil];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect frame = textView.frame;
    [self.view layoutIfNeeded];
    if (frame.size.height != textView.contentSize.height) {
        CGFloat deltaHeight = textView.contentSize.height - frame.size.height;
        frame.size.height = textView.contentSize.height;
        [UIView animateWithDuration:0.1 animations:^{
            textView.frame = frame;
            self.inputContainerHeight.constant += deltaHeight;
            [self.view layoutIfNeeded];
        }];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.usersMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId =@"MyCustomCell";
    KiteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    KiteOtherTableViewCell *receiveCell = [tableView dequeueReusableCellWithIdentifier:@"MyCustomCell"];
    
    if(receiveCell == nil) {
        NSArray *arrObj = [[NSBundle mainBundle] loadNibNamed:@"KiteOtherTableViewCell" owner:self options:nil];
        receiveCell = [arrObj lastObject];
    }
    
    if(cell==nil) {
        NSArray *arrObj = [[NSBundle mainBundle] loadNibNamed:@"KiteTableViewCell" owner:self options:nil];
        cell = [arrObj firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textOfMessage.backgroundColor = [UIColor clearColor];
    cell.backgroundImage.image = [UIImage imageNamed:@"cell.png"];
    cell.textOfMessage.text = [self.usersMessages objectAtIndex:indexPath.row];
    
    receiveCell.backgroundColor = [UIColor clearColor];
    receiveCell.textOfMessage.backgroundColor = [UIColor clearColor];
    receiveCell.backgroundImage.image = [UIImage imageNamed:@"cell.png"];
    receiveCell.textOfMessage.text = [self.inputMessages objectAtIndex:indexPath.row];
    
    
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMessage:(UIButton *)sender {
    NSString *messsage = self.inputView.text;
    [self.usersMessages addObject:messsage];
    [self.tableView reloadData];
    self.inputView.text = @"";
}

- (void) receiveMessage
{

    
}
@end
