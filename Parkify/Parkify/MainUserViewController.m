//
//  MainUserViewController.m
//  Parkify
//
//  Created by Robert Baran on 19.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "MainUserViewController.h"
#import "TopBarViewController.h"

@interface MainUserViewController ()
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) IBOutlet UIView *bottomBarView;
@property (strong, nonatomic) TopBarViewController *topBarViewController;
@end

@implementation MainUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBarViewController = [[TopBarViewController alloc] initWithNibName:@"topBarViewController" bundle:nil];
    
    UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"footer" owner:self options:nil] lastObject];
    
    [self.bottomBarView addSubview:containerView];
    [self.topBarView addSubview:self.topBarViewController.view];
    
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bottomBarView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.topBarView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.topBarViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = @{@"container" : containerView,
                            @"topBar" : self.topBarViewController.view};
    
    [self.bottomBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[container]-|" options:0 metrics:nil views:views]];
    [self.bottomBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[container]-|" options:0 metrics:nil views:views]];
    
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
