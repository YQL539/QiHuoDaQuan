//
//  data.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface data : NSObject
//获取行情
+ (NSArray *)getDataWithRootTitle:(NSString *)rootTitle subTitle:(NSString *)subTitle;
@end


@interface dataModel : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *salePrice;
@property (copy, nonatomic) NSString *buyPrice;
@property (copy, nonatomic) NSString *zhangFu;
@property (copy, nonatomic) NSString *kuiSun;
@end
NS_ASSUME_NONNULL_END
