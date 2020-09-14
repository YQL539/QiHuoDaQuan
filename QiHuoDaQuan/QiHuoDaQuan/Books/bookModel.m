//
//  bookModel.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "bookModel.h"

@implementation bookModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc": @"description",@"ID": @"id"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.bid forKey:@"bid"];
    [aCoder encodeObject:self.click_number forKey:@"click_number"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.title forKey:@"title"];

}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.bid = [aDecoder decodeObjectForKey:@"bid"];
        self.click_number = [aDecoder decodeObjectForKey:@"click_number"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
  
    }
    
    return self;
}
@end
