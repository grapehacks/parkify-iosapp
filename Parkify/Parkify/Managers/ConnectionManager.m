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
#import "ParkifyNotification.h"

static NSString const *BaseURLString = @"http://parkify.grapeup.com/";

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
    NSDictionary *userDictionary = [responseObject objectForKey:@"user"];
    NSString *dateString = [responseObject objectForKey:@"date"];
    NSDate *date = nil;
    User *user = nil;
    if (dateString) {
      date = [self.parser objectOfType:[NSDate class] fromJSONString:[responseObject objectForKey:@"date"]];
        
      if (userDictionary) {
        user = [self.parser userFromDictionary:userDictionary];
      }
    }
    
      
    [[ParkifyNotification sharedInstance] setupNotificationForUser:user andDate:[self.parser dateFromString:[responseObject objectForKey:@"date"]]];
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

- (void)retrieveMessagesWithToken:(NSString *)token completionHandler:(void (^)(NSArray *messages, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@api/messages", BaseURLString];
  NSDictionary *params = nil;
  if (token) {
    params = @{@"token" : token};
  }

  [self.manager GET:endpointURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"messages response %@", responseObject);
    NSMutableArray *messages = [NSMutableArray new];
    NSArray *messagesDicts = responseObject;
    for (NSDictionary * messageDict in messagesDicts) {
      Message *message = [self.parser messageFromDictionary:messageDict];
      [messages addObject:message];
    }
    if (completion) {
      completion(messages, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"messages error %@", error);
    if (completion) {
      completion(nil, error);
    }
  }];
}

- (void)participateRegisterWithToken:(NSString *)token remember:(BOOL)remember completionHandler:(void (^)(User *user, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@api/participate/register", BaseURLString];
  NSDictionary *params = nil;
  if (token) {
    params = @{@"token" : token,
               @"rememberLastChoice" : @(remember)
               };
  }
  [self.manager POST:endpointURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    User *user = [self.parser userFromDictionary:responseObject];
    if (completion) {
      completion(user, nil);
    }

  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (completion) {
      completion(nil, error);
    }
  }];
}

- (void)participateUnregisterWithToken:(NSString *)token remember:(BOOL)remember completionHandler:(void (^)(User *user, NSError *error))completion {
  NSString *endpointURL = [NSString stringWithFormat:@"%@api/participate/unregister", BaseURLString];
  NSDictionary *params = nil;
  if (token) {
    params = @{@"token" : token,
               @"rememberLastChoice" : @(remember)
               };
  }
  [self.manager POST:endpointURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    User *user = [self.parser userFromDictionary:responseObject];
    if (completion) {
      completion(user, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (completion) {
      completion(nil, error);
    }
  }];
}

@end
