//
//  MessagesViewController.m
//  Parkify
//
//  Created by Robert Baran on 20.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "MessagesViewController.h"
#import "TopBarViewController.h"
#import "MessageTableViewCell.h"
#import "ConnectionManager.h"
#import "AppDelegate.h"

//retriveMessages
@interface MessagesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) TopBarViewController *topBarViewController;
@property (strong, nonatomic) NSArray *messagesArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBarViewController = [[TopBarViewController alloc] initWithNibName:@"topBarViewController" bundle:nil];
    
    NSDictionary *views = @{@"topBar" : self.topBarViewController.view};
    [self.topBarView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.topBarView addSubview:self.topBarViewController.view];
    [self.topBarViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[topBar]-|" options:0 metrics:nil views:views]];
    [self.topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[topBar]-|" options:0 metrics:nil views:views]];
    [self.topBarViewController.winnersButton setHidden:YES];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[ConnectionManager sharedInstance] retrieveMessagesWithToken:appDelegate.session.token completionHandler:^(NSArray *messages, NSError *error) {
        if (!error) {
            self.messagesArray = messages;
        }
    }];
}

- (void)setMessagesArray:(NSArray *)messagesArray {
    _messagesArray = messagesArray;
    [self.tableView reloadData];
}

- (UIColor *)colorForMessageType:(MessageType)type {
    switch (type) {
        case MessageTypeWin:
        case MessageTypeWinReceive:
            return [UIColor greenColor];
        case MessageTypeInfo:
            return [UIColor yellowColor];
        case MessageTypeLoss:
        case MessageTypeLossReturn:
            return [UIColor redColor];
        case MessageTypeError:
            return [UIColor magentaColor];
        case MessageTypeWarning:
            return [UIColor magentaColor];
            
        default:
            break;
    }
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.titleLabel.text = ((Message *)self.messagesArray[indexPath.row]).topic;
    cell.descriptionLabel.text = ((Message *)self.messagesArray[indexPath.row]).text;
    [cell setBackgroundColor:[self colorForMessageType:((Message *)self.messagesArray[indexPath.row]).type]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

@end
