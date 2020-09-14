//
//  DateSignViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "DateSignViewController.h"

@interface DateSignViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *calendarView;
@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong)  UIButton *signInBtn;
@property (nonatomic,strong) FSCalendar *fsCalendar;
@property (nonatomic,strong) NSMutableArray *dateArr;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *signInList;
@property (assign, nonatomic) NSInteger SignCount;
@property (assign, nonatomic) NSInteger count;
@property (strong,nonatomic) NSString *dateStr;

@end

@implementation DateSignViewController
#pragma mark - FSCalendarDelegate,FSCalendarDataSource
- (nullable NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date{
    if ([self.gregorian isDateInToday:date]){
        return @"今";
    }
    return nil;
}

-(UIColor *)GetColor:(NSString *)color
{
    NSString* string = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([string length] < 6) {
        return [UIColor clearColor];
    }
    if ([string hasPrefix:@"0X"])
        string = [string substringFromIndex:2];
    if ([string hasPrefix:@"#"])
        string = [string substringFromIndex:1];
    if ([string length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [string substringWithRange:range];
    range.location = 2;
    NSString *gString = [string substringWithRange:range];
    range.location = 4;
    NSString *bString = [string substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//设置选中日期的border颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date {
    return [UIColor whiteColor];
}

//最大时间今天
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    return [NSDate date];
}

// 未签到的不可点击
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    return NO;
}

// 已签到的不可点击
- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    return NO;
}
- (void)getCache{
    //从缓存中先把数据取出来
    NSArray *cache = [[NSUserDefaults standardUserDefaults] objectForKey:KISSIGNED];
    self.signInList = [NSMutableArray arrayWithArray:cache];
    //允许用户选择,其实是允许系统来选中签到日期
    self.fsCalendar.allowsSelection = YES;
    self.fsCalendar.allowsMultipleSelection = YES;
    if (cache.count) {//如果cache里面有数据
        //选中日期,只有不在选中之列的才去选中它
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
        for (NSInteger i = 0; i<cache.count; i++) {
            NSDate *date = [self.dateFormatter dateFromString:cache[i]];
            if (![self.fsCalendar.selectedDates containsObject:date]) {
                [self.fsCalendar selectDate:date];
            }
        }
        NSString *dateStr = [Util GetCurrentDate];
        if ([cache containsObject:dateStr]) {
            [_signInBtn setImage:[UIImage imageNamed:@"signIned"] forState:UIControlStateNormal];
            NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:@"已完成签到，再接再厉哟" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
            self.desLabel.attributedText = desString;
        }
    }else{
        NSMutableArray *cache = [NSMutableArray array];
        [[NSUserDefaults standardUserDefaults] setValue:cache forKey:KISSIGNED];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //选择完毕后关闭可选项,不让用户自己点
    self.fsCalendar.allowsSelection = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getCache];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日签到";
    self.signInList = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [self setUI];
    [self signInHistory];
}

- (void)setUI{
     __block typeof(self)weakSelf = self;
    self.headerView = [[UIView alloc]init];
    [self.view addSubview:self.headerView];
    self.calendarView = [[UIView alloc]init];
    [self.view addSubview:self.calendarView];
    //头部view
    self.headerView.backgroundColor = MAINCOLOR;;
    self.signInBtn = [[UIButton alloc] init];
    [_signInBtn setImage:[UIImage imageNamed:@"signIn"] forState:UIControlStateNormal];
    [_signInBtn addTarget:self action:@selector(onSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_signInBtn];
    
    self.desLabel = [[UILabel alloc] init];
    NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:@"请坚持签到" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    self.desLabel.attributedText = desString;
    [self.headerView addSubview:self.desLabel];
    //日历部分
    self.calendarView.layer.cornerRadius = 5;
    self.calendarView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.calendarView.layer.shadowOpacity = 0.2f;
    self.calendarView.layer.shadowRadius = 4.f;
    self.calendarView.layer.shadowOffset = CGSizeMake(1,1);
    [self.calendarView addSubview:self.fsCalendar];
   
    CGFloat headerScale = 0.3;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT + headerScale * SCREENWIDTH);
    }];
    
    CGFloat calendarScale = 0.86;
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.top.equalTo(weakSelf.headerView.mas_bottom).offset(0);
        make.height.mas_equalTo(calendarScale * (SCREENWIDTH - (28)));
    }];
    
    [self.fsCalendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.calendarView);
    }];

    [_signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(weakSelf.headerView.mas_top).offset(44);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(40);
    }];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerView);
        make.top.equalTo(_signInBtn.mas_bottom).offset(20);
    }];
}

- (void)onSignInBtn:(UIButton *)sender{
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"signIn"]]) {
        [_signInBtn setImage:[UIImage imageNamed:@"signIned"] forState:UIControlStateNormal];
        NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:@"已完成签到!" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        self.desLabel.attributedText = desString;
        ////  设置默认选中日期是今天
        NSString *dateStr = [Util GetCurrentDate];
        if (![self.signInList containsObject:dateStr]) {
            [self.signInList addObject:dateStr];
        }
        NSArray *cacheArray = (NSArray *)self.signInList;
        [[NSUserDefaults standardUserDefaults] setObject:cacheArray forKey:KISSIGNED];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self getCache];
        return;
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"已签到" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (FSCalendar *)fsCalendar {
    if (!_fsCalendar) {
        //日历控件初始化
        _fsCalendar = [[FSCalendar alloc] init];
        //设置是否用户多选
        _fsCalendar.allowsMultipleSelection = YES;
        _fsCalendar.appearance.weekdayTextColor = [UIColor blackColor];
        _fsCalendar.appearance.headerTitleColor = [UIColor blackColor];
        _fsCalendar.appearance.titleDefaultColor = [UIColor darkGrayColor];
        _fsCalendar.appearance.selectionColor = MAINCOLOR;
        _fsCalendar.appearance.headerDateFormat = @"yyyy-MM";
        _fsCalendar.appearance.todayColor = [UIColor lightGrayColor];
        _fsCalendar.appearance.titleTodayColor = [UIColor whiteColor];
        // 设置代理
        _fsCalendar.layer.cornerRadius = 5;
        _fsCalendar.delegate = self;
        _fsCalendar.dataSource = self;
        _fsCalendar.firstWeekday = 2;     //设置周一为第一天
        _fsCalendar.appearance.borderRadius = 1.0;  // 设置当前选择是圆形,0.0是正方形
        _fsCalendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        _fsCalendar.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        _fsCalendar.locale = locale;  // 设置周次是中文显示
        _fsCalendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;  // 设置周次为一,二
        _fsCalendar.placeholderType = FSCalendarPlaceholderTypeNone;
        
    }
    return _fsCalendar;
}


- (void)signInHistory{
    UIColor *color = [self GetColor:@"#123456"];
    [self.fsCalendar setCurrentPage:[NSDate date] animated:YES];
}

@end
