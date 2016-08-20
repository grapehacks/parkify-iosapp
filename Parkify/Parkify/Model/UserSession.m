//
//  UserSession.m
//  Parkify
//
//  Created by Sławek Derwisz on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession

- (instancetype)initWithUser:(User *)user token:(NSString *)token {
  self = [super init];
  if (self) {
    _user = user;
    _token = token;
  }
  return self;
}

@end
