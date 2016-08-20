//
//  TopBarViewController.m
//  Parkify
//
//  Created by Robert Baran on 19.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "TopBarViewController.h"
#import "AppDelegate.h"

@interface TopBarViewController()
@property (strong, nonatomic) IBOutlet UIView *popUpBackgroundView;
@property (strong, nonatomic) IBOutlet UIView *popupView;

@end

@implementation TopBarViewController


- (void)viewDidLoad {
    self.popUpBackgroundView.layer.borderWidth = 1;
    self.popUpBackgroundView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.popUpBackgroundView.layer.cornerRadius = 15;
    self.popUpBackgroundView.layer.masksToBounds = YES;
}

- (IBAction)showMessages:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *messagesViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    [self showViewController:messagesViewController sender:sender];
}

- (IBAction)personalAction:(id)sender {
    UIButton *button = sender;
    [self.popupView setFrame:CGRectMake(button.frame.origin.x - self.popupView.bounds.size.width/2 - button.frame.size.width + 15/2, button.frame.origin.y + button.frame.size.height, self.popupView.bounds.size.width, self.popupView.bounds.size.height)];
    
    [self.view addSubview:self.popupView];    
}

- (IBAction)infoAction:(id)sender {
}

@end
