//
//  ViewController.m
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *footerView;
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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
