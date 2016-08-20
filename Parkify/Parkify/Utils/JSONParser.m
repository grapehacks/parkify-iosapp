//
//  JSONParser.m
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "JSONParser.h"

// model objects class
#import "User.h"
#import "Message.h"
#import "Card.h"

@implementation JSONParser

- (NSDictionary *)dictionaryFronJSonString:(NSString *)jsonString {
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error = nil;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
  return jsonDictionary;
}

- (id)objectOfType:(Class)objectType fromJSONString:(NSString *)jsonString {
  NSDictionary *jsonDictionry = [self dictionaryFronJSonString:jsonString];
  if (objectType == [NSDate class]) {
    return [self dateFromDictionary:jsonDictionry];
    // I don't know
  } else if (objectType == [User class]) {
    return [self userFromDictionary:jsonDictionry];
  }
  return nil;
}

- (User *)userFromDictionary:(NSDictionary *)jsonDictionary {
  User *user = [User new];
  user.email = jsonDictionary[@"email"];
  user.name = jsonDictionary[@"name"];
  user.type = [jsonDictionary[@"type"] integerValue];
  user.unreadMsgCounter = [jsonDictionary[@"unreadMsgCounter"] integerValue];
  user.rememberChoice = [jsonDictionary[@"rememberLastChoice"] boolValue];
  user.participate = [jsonDictionary[@"participate"] integerValue];
  return user;
}

- (Message *)messageFromDictionary:(NSDictionary *)jsonDictionary {
  Message *message = [Message new];
  message.text = jsonDictionary[@"text"];
  message.topic = jsonDictionary[@"topic"];
  message.type = [jsonDictionary[@"type"] integerValue];
  message.read = [jsonDictionary[@"read"] boolValue];
  message.date = [self dateFromDictionary:jsonDictionary];
  return message;
}

- (Card *)cardFromDictionary:(NSDictionary *)jsonDictionary {
  Card *card = [Card new];
  card.name = jsonDictionary[@"name"];
  card.type = jsonDictionary[@"type"];
  card.removed = [jsonDictionary[@"read"] boolValue];
  card.active = [jsonDictionary[@"active"] boolValue];
  card.user = [self userFromDictionary:jsonDictionary[@"user"]];
  return card;
}

- (NSDate *)dateFromDictionary:(NSDictionary *)dateDictionary {
  NSString *dateString = dateDictionary[@"date"];
  if (dateString.length > 0) {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
  }
  return nil;
}

@end
