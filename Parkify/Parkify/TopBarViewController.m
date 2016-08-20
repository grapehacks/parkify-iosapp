//
//  TopBarViewController.m
//  Parkify
//
//  Created by Robert Baran on 19.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "TopBarViewController.h"

@implementation TopBarViewController

- (IBAction)showMessages:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *messagesViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    [self showViewController:messagesViewController sender:sender];
}

- (IBAction)personalAction:(id)sender {
}

- (IBAction)infoAction:(id)sender {
}

@end
