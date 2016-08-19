//
//  Card.h
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Card : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL removed;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, weak) User *user;
@end
