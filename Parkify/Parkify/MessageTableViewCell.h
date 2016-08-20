//
//  MessageTableViewCell.h
//  Parkify
//
//  Created by Robert Baran on 20.08.2016.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
