//
//  SheQuDetailModel.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SheQuZanModel;
@protocol SheQuReplyModel;

@interface SheQuDetailModel : JSONModel

@property(nonatomic,assign)NSInteger uid;
@property(nonatomic, copy)NSString *qid;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * detail;
@property(nonatomic,copy)NSString * add_time;
@property(nonatomic,copy)NSString * user_name;
@property(nonatomic,copy)NSString * avatar_url;
@property(nonatomic,copy)NSArray<SheQuZanModel> * agree_users;
@property(nonatomic,copy)NSArray<SheQuReplyModel> * answers;
@end

@interface SheQuZanModel : JSONModel

@property(nonatomic,copy)NSString * user_name;

@end

@interface SheQuReplyModel : JSONModel

@property(nonatomic,copy)NSString * answer_content;
@property(nonatomic,copy)NSString * avatar_url;
@property(nonatomic,copy)NSString * user_name;
@property(nonatomic,copy)NSString * add_time;
@property(nonatomic,copy)NSString * answer_id;
@property(nonatomic, assign)NSInteger uid;

@end
NS_ASSUME_NONNULL_END
