//
//  ViewController.m
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "ViewController.h"
#import "MainUserViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"footer" owner:self options:nil] lastObject];
    [self.footerView addSubview:containerView];
    
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.footerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = @{@"container" : containerView};
    
    [self.footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[container]-|" options:0 metrics:nil views:views]];
    [self.footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[container]-|" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    BOOL userCanLogin = YES; //should be modify
    if (userCanLogin) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *mainUserViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MainUserViewController"];
        mainUserViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:mainUserViewController animated:YES completion:NULL];
    }
}

@end
