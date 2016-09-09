//
//  JSONParser.m
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "JSONParser.h"

// model objects class
#import "Card.h"
#import "Draw.h"
#import "History.h"

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
  } else if (objectType == [User class]) {
    return [self userFromDictionary:jsonDictionry];
  } else if (objectType == [Message class]) {
    return [self messageFromDictionary:jsonDictionry];
  } else if (objectType == [Card class]) {
    return [self cardFromDictionary:jsonDictionry];
  } else if (objectType == [Draw class]) {
    return [self drawFromDictionary:jsonDictionry];
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
  message.messageId = jsonDictionary[@"_id"];
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

- (Draw *)drawFromDictionary:(NSDictionary *)jsonDictionary {
  Draw *draw = [Draw new];
  draw.user = [self userFromDictionary:jsonDictionary[@"user"]];
  draw.card = [self cardFromDictionary:jsonDictionary[@"card"]];
  return draw;
}
//
//- (History *)historyFromDictionary:(NSDictionary *)jsonDictionary {
//  History *history = [History new];
//  history.date = [self dateFromDictionary:jsonDictionary[@"date"]];
//  history.draw = [self drawFromDictionary:jsonDictionary[@"draw"]];
//  history.user = [self userFromDictionary:jsonDictionary[@"user"]];
//  return history;
//}

- (NSDate *)dateFromString:(NSString *)dateString {
    if (dateString.length > 0) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDate *date = [dateFormatter dateFromString:dateString];
        return date;
    }
    return nil;
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
