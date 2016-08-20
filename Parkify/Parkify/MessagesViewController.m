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

@interface MessagesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) TopBarViewController *topBarViewController;

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
}

#pragma mark - Table View Data Source 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.titleLabel.text = @"dupa";
    cell.descriptionLabel.text = @"dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa dupa ";
    [cell setBackgroundColor:color];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

@end
