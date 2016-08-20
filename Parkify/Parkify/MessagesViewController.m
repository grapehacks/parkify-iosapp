//
//  MessagesViewController.m
//  Parkify
//
//  Created by Robert Baran on 20.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "MessagesViewController.h"
#import "TopBarViewController.h"

@interface MessagesViewController ()
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
