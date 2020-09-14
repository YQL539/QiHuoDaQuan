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
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    
    self.priceNowLabel = [[UILabel alloc] init];
    self.priceNowLabel.textAlignment = NSTextAlignmentCenter;
    self.priceNowLabel.font =  [UIFont systemFontOfSize:15];
    
    self.priceChangeLabel = [[UILabel alloc] init];
    self.priceChangeLabel.textAlignment = NSTextAlignmentCenter;
    self.priceChangeLabel.layer.cornerRadius = 7;
    self.priceChangeLabel.clipsToBounds = YES;
    self.priceChangeLabel.font =  [UIFont systemFontOfSize:15];
    
    self.recumentLabel = [[UILabel alloc] init];
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
        self.priceChangeLabel.backgroundColor = [UIColor greenColor];
    }else{
        self.priceChangeLabel.backgroundColor = [UIColor redColor];
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
    CGFloat iW = (self.frame.size.width - iMarginX * 5)/4;
    self.nameLabel.frame = CGRectMake(iMarginX, 0, iW, self.frame.size.height);
    self.priceNowLabel.frame = CGRectMake((iW + iMarginX)*1, 0, iW, self.height);
    self.priceChangeLabel.frame = CGRectMake((iW + iMarginX)*2 + 10, 10, iW - 20, self.height - 20);
    self.recumentLabel.frame = CGRectMake((iW + iMarginX)*3, 0, iW, self.height);
}


@end
