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
