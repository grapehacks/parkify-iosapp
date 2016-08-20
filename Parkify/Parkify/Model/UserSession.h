//
//  UserSession.h
//  Parkify
//
//  Created by Sławek Derwisz on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserSession : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) User *user;

- (instancetype)initWithUser:(User *)user token:(NSString *)token;

@end
