//
//  ConfirmationModalViewController.m
//  Parkify
//
//  Created by Robert Baran on 20.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "ConfirmationModalViewController.h"
#import "ConnectionManager.h"
#import "AppDelegate.h"

@interface ConfirmationModalViewController ()
@property (strong, nonatomic) IBOutlet UILabel *confirmationLabel;
@property (strong, nonatomic) IBOutlet UISwitch *confirmationSwitch;
@property (strong, nonatomic) IBOutlet UILabel *confirmationDesctription;

@end

@implementation ConfirmationModalViewController

- (void)registerConfirmation {
    UIColor *green = [UIColor colorWithRed:0.376471 green:0.721569 blue:0.537255 alpha:1.0];
    [self.view setBackgroundColor:green];
    self.confirmationLabel.text = @"Czy jesteś pewien że chcesz zapisać się na listę osób biorących udział w losowaniu karty parkingowej?";
    self.confirmationDesctription.text = @"Zawsze chcę być zapisany";
}

- (void)unregisterConfirmation {
    UIColor *red = [UIColor colorWithRed:0.564706 green:0.313726 blue:0.321569 alpha:1.0];
    [self.view setBackgroundColor:red];
    self.confirmationLabel.text = @"Czy jesteś pewien że chcesz się wypisać z listy osób biorących udział w losowaniu karty parkingowej?";
    self.confirmationDesctription.text = @"Wypisz mnie na zawsze";
}

- (IBAction)noAction:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)yesAction:(id)sender {
  AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  switch (appDelegate.session.user.participate) {
    case ParticipateModeDecline:
    case ParticipateModeTentative: {
      [[ConnectionManager sharedInstance] participateRegisterWithToken:appDelegate.session.token remember:self.confirmationSwitch.isOn completionHandler:^(User *user, NSError *error) {
        appDelegate.session.user = user;
        [self dismissViewControllerAnimated:YES completion:nil];
      }];
      break;
    }
    case ParticipateModeAccept: {
      [[ConnectionManager sharedInstance] participateUnregisterWithToken:appDelegate.session.token remember:self.confirmationSwitch.isOn completionHandler:^(User *user, NSError *error) {
        appDelegate.session.user = user;
        [self dismissViewControllerAnimated:YES completion:nil];
      }];
      break;
    }
    default:
      break;
  }

}

- (IBAction)switchAction:(id)sender {

}


@end
