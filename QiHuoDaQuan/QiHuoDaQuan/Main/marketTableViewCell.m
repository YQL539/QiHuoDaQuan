//
//  marketTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import "marketTableViewCell.h"
#import "data.h"

@implementation marketTableViewCell

+(instancetype)initCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"marketTableViewCell";
    marketTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[marketTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initViews];
    }
    return self;
}
- (void)initViews {
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    
    self.priceNowLabel = [[UILabel alloc] init];
    self.priceNowLabel.textColor = [UIColor blackColor];
    self.priceNowLabel.textAlignment = NSTextAlignmentCenter;
    self.priceNowLabel.font =  [UIFont systemFontOfSize:15];
    
    self.priceChangeLabel = [[UILabel alloc] init];
    
    self.priceChangeLabel.textAlignment = NSTextAlignmentCenter;
    self.priceChangeLabel.layer.cornerRadius = 7;
    self.priceChangeLabel.clipsToBounds = YES;
    self.priceChangeLabel.font =  [UIFont systemFontOfSize:15];
    
    self.recumentLabel = [[UILabel alloc] init];
    self.recumentLabel.textColor = [UIColor blackColor];

    self.recumentLabel.textAlignment = NSTextAlignmentCenter;
    self.recumentLabel.font =  [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceNowLabel];
     [self.contentView addSubview:self.priceChangeLabel];
     [self.contentView addSubview:self.recumentLabel];
}

- (void)setModel:(dataModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.priceNowLabel.text = model.buyPrice;
    if ([model.zhangFu containsString:@"-"]) {
        self.priceChangeLabel.textColor = RGB(73.f, 128.f, 31.f);
    }else{
        self.priceChangeLabel.textColor = [UIColor redColor];
    }
    self.priceChangeLabel.text = model.zhangFu;
    
    NSString *reco = [self GettRandomNumber:70 to:100];
    self.recumentLabel.text = reco;
}

-(NSString *)GettRandomNumber:(int)iFrom to:(int)iTo
{
    CGFloat iRe = (CGFloat)(iFrom + (arc4random() % (iTo - iFrom + 1)));
    NSString *retStr = [NSString stringWithFormat:@"%.0f",iRe];
    return retStr;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iMarginX = 15;
    CGFloat iW = (self.frame.size.width)/4;
    self.nameLabel.frame = CGRectMake(0, 0, iW + 30, self.frame.size.height);
    self.priceNowLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 0, iW - 10, self.height);
    self.priceChangeLabel.frame = CGRectMake(CGRectGetMaxX(self.priceNowLabel.frame), 10, iW - 10, self.height - 20);
    self.recumentLabel.frame = CGRectMake(CGRectGetMaxX(self.priceChangeLabel.frame), 0, iW - 10, self.height);
}


@end
