//
//  ViewController.m
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainUserViewController.h"
#import "ConnectionManager.h"

@class UserSession;

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
  [[ConnectionManager sharedInstance] authenticateWithLogin:self.userNameTextField.text
                                                   password:self.passwordTextField.text
                                          completionHandler:^(NSString *token, User *user, NSError *error) {
                                            if (!error) {
                                              UserSession *session = [[UserSession alloc] initWithUser:user token:token];
                                              AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                              appDelegate.session = session;

                                              UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                              UIViewController *mainUserViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MainUserViewController"];
                                              mainUserViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                                              [self presentViewController:mainUserViewController animated:YES completion:NULL];
                                            } else {
                                              UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login error"
                                                                                                             message:error.localizedDescription
                                                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
                                              UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                                      style:UIAlertActionStyleDefault
                                                                                                    handler:^(UIAlertAction * action) {}];
                                              [alert addAction:defaultAction];
                                              [self presentViewController:alert animated:YES completion:^{
                                                self.userNameTextField.text = @"";
                                                self.passwordTextField.text = @"";
                                              }];
                                            }
  }];
}

@end
