//
//  UserDefaults.m
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "UserDefaults.h"

static NSString *kTokenKey = @"userToken";

@implementation UserDefaults

+ (void)saveActiveToken:(NSString *)token {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:token forKey:kTokenKey];
  [defaults synchronize];
}

+ (NSString *)activeToken {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults stringForKey:kTokenKey];
}


@end
