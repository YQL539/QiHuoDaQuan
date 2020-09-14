//
//  data.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import "data.h"


@implementation data
//获取行情
+ (NSArray *)getDataWithRootTitle:(NSString *)rootTitle subTitle:(NSString *)subTitle{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *dic0 = dic[rootTitle];
    NSArray *dataArray = dic0[subTitle];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i ++) {
        NSDictionary *mmDic = dataArray[i];
        dataModel *model = [[dataModel alloc] init];
        model.name = mmDic[@"name"];
        model.buyPrice = mmDic[@"buyPrice"];
        model.salePrice = mmDic[@"salePrice"];
        model.zhangFu = mmDic[@"zhangFu"];
        model.kuiSun = mmDic[@"kuiSun"];
        [resultArray addObject:model];
    }
    return resultArray.copy;
}



@end
@implementation dataModel

@end
