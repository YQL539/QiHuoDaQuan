//
//  bookModel.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bookModel : NSObject
@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * bid;
@property (nonatomic,copy) NSString * click_number;
@property (nonatomic,copy) NSString * create_time;
@property (nonatomic,copy) NSString * desc;
@property (nonatomic,copy) NSString * ID;
@property (nonatomic,copy) NSString * images;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * title;
@end

NS_ASSUME_NONNULL_END
