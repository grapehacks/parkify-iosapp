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
#import "ConfirmationModalViewController.h"
#import "AppDelegate.h"

@interface MainUserViewController ()
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) IBOutlet UIView *bottomBarView;
@property (strong, nonatomic) IBOutlet UIButton *enableButton;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;
@property (strong, nonatomic) IBOutlet UIButton *saveUnsaveButton;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) ConfirmationModalViewController *confirmationModalViewController;

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

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  switch ([self participateMode]) {
    case ParticipateModeDecline:
    case ParticipateModeTentative:
      [self setupForUnregisteredUser];
      break;
    case ParticipateModeAccept:
      [self setupForRegisteredUser];
  }
}

- (ParticipateMode)participateMode {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.session.user.participate;
}

- (IBAction)registerUnregisterAction:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.confirmationModalViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ConfirmationModalViewController"];
    self.confirmationModalViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    switch ([self participateMode]) {
        case ParticipateModeDecline:
        case ParticipateModeTentative:
            [self.confirmationModalViewController registerConfirmation];
        break;
        case ParticipateModeAccept:
            [self.confirmationModalViewController unregisterConfirmation];
    }
    
    [self presentViewController:self.confirmationModalViewController animated:YES completion:NULL];
}

- (void)setupForRegisteredUser {
    [self.enableButton setImage:[UIImage imageNamed:@"onState"] forState:UIControlStateNormal];
    [self.saveUnsaveButton setBackgroundImage:[UIImage imageNamed:@"greenButton"] forState:UIControlStateNormal];
    [self.saveUnsaveButton setTitle:@"ZAPISANO" forState:UIControlStateNormal];
}

- (void)setupForUnregisteredUser {
    [self.enableButton setImage:[UIImage imageNamed:@"offState"] forState:UIControlStateNormal];
    [self.saveUnsaveButton setBackgroundImage:[UIImage imageNamed:@"redButton"] forState:UIControlStateNormal];
    [self.saveUnsaveButton setTitle:@"NIE ZAPISANO" forState:UIControlStateNormal];
}

@end
