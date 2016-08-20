//
//  TopBarViewController.h
//  Parkify
//
//  Created by Robert Baran on 19.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *winnersButton;
@property (strong, nonatomic) IBOutlet UIButton *personButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;

@end
