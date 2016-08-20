//
//  MainUserViewController.m
//  Parkify
//
//  Created by Robert Baran on 19.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "MainUserViewController.h"
#import "TopBarViewController.h"
#import "MessagesViewController.h"

@interface MainUserViewController ()
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) IBOutlet UIView *bottomBarView;
@property (strong, nonatomic) IBOutlet UIButton *enableButton;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;
@property (strong, nonatomic) IBOutlet UIButton *saveUnsaveButton;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

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
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void)respondToTapGesture:(UITapGestureRecognizer *)recognizer {
    if (self.topBarViewController.popupView) {
        [self.topBarViewController.popupView removeFromSuperview];
    }
}
@end
