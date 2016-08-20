//
//  ConnectionManager.m
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFNetworking.h"
#import "JSONParser.h"

static NSString const *BaseURLString = @"http://krk.grapeup.com:8080/";

@interface ConnectionManager ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) JSONParser *parser;
@end

@implementation ConnectionManager

- (instancetype)init
{
  self = [super init];
  if (self) {
    _manager = [AFHTTPSessionManager manager];
    _parser = [JSONParser new];
  }
  return self;
}

+ (instancetype)sharedInstance {
  static ConnectionManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [self new];
  });
  return instance;
}


- (void)authenticateWithLogin:(NSString *)login password:(NSString *)passwd completionHandler:(void (^)(NSString *token, User *user, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@authenticate", BaseURLString];
  NSDictionary *params = @{@"email" : login,
                           @"password" : passwd
                           };

  [self.manager POST:endpointURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    User *user = [self.parser userFromDictionary:[responseObject objectForKey:@"user"]];
    if (completion) {
      completion([responseObject objectForKey:@"token"], user, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"auth error: %@", error);
    if (completion) {
      completion(nil, nil, error);
    }
  }];
}

- (void)pingWithToken:(NSString *)token completionHandler:(void (^)(NSDate *date, User *user, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@ping", BaseURLString];
  NSDictionary *params = nil;
  if (token) {
    params = @{@"token" : token};
  }

  [self.manager GET:endpointURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"ping response %@", responseObject);
    User *user = [self.parser userFromDictionary:[responseObject objectForKey:@"user"]];
    NSDate *date = [self.parser objectOfType:[NSDate class] fromJSONString:[responseObject objectForKey:@"date"]];

    if (completion) {
      completion(date, user, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"ping error %@", error);
    if (completion) {
      completion(nil, nil, error);
    }
  }];
}

- (void)retrieveUsersWithToken:(NSString *)token completionHandler:(void (^)(NSArray *users, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@api/users", BaseURLString];

  [self.manager GET:endpointURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"users response %@", responseObject);
    if (completion) {
      completion(responseObject, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"users error %@", error);
    if (completion) {
      completion(nil, error);
    }
  }];
}

- (void)retrieveCardsWithToken:(NSString *)token completionHandler:(void (^)(NSArray *cards, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@api/cards", BaseURLString];

  [self.manager GET:endpointURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"cards response %@", responseObject);
    if (completion) {
      completion(responseObject, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"cards error %@", error);
    if (completion) {
      completion(nil, error);
    }
  }];
}

@end