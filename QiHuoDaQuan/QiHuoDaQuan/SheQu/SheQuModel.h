//
//  SheQuModel.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SheQuModel : JSONModel
@property(nonatomic,copy)NSString * headImage;
@property(nonatomic,copy)NSString * nickName;
@property(nonatomic,copy)NSString * date;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * loolNum;
@property(nonatomic,copy)NSString * reply;
@property(nonatomic,copy)NSString * qi;
@property(nonatomic, assign)NSInteger uid;
@end

NS_ASSUME_NONNULL_END
