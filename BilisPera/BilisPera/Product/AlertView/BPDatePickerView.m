//
//  BPDatePickerView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPDatePickerView.h"

NS_ASSUME_NONNULL_BEGIN
@implementation BPDatePickerViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentHeight = kRatio(436);
    }
    return self;
}

@end

@interface BPDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, assign) NSInteger selectedDay;
@property (nonatomic, assign) NSInteger selectedComponent;
@property (nonatomic, strong) NSArray<NSNumber *> *months;
@property (nonatomic, strong) NSArray<NSNumber *> *days;
@property (nonatomic, strong) NSDateComponents *currentDateCom;

@end

@implementation BPDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentDateCom = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        [self setupUI];
        [self applyModel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame model:(BPDatePickerViewModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        _currentDateCom = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        [self setupUI];
        [self applyModel];
    }
    return self;
}

#pragma mark - UI Setup

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    // PickerView
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 kScreenW,
                                                                 kRatio(200))];
    _pickerView.backgroundColor = [UIColor clearColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_pickerView];
    
    // Labels
    _firstLabel = [self createLabelWithText:@"Day"];
    _secondLabel = [self createLabelWithText:@"Month"];
    _thirdLabel = [self createLabelWithText:@"Year"];
    
    // StackView
    _stackView = [[UIStackView alloc] init];
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.distribution = UIStackViewDistributionFillEqually;
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_stackView addArrangedSubview:_firstLabel];
    [_stackView addArrangedSubview:_secondLabel];
    [_stackView addArrangedSubview:_thirdLabel];
    
    [self addSubview:_stackView];
    [self setupConstraints];
}

- (UILabel *)createLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    return label;
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // PickerView constraints
        [self.pickerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.pickerView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kRatio(44)],
        [self.pickerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.pickerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.pickerView.heightAnchor constraintEqualToConstant:kRatio(436)],
        
        // StackView constraints
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.stackView.heightAnchor constraintEqualToConstant:kRatio(44)]
    ]];
}

#pragma mark - Model Application

- (void)applyModel {
    [self.pickerView reloadAllComponents];
    NSDate *currentDate = [NSDate dateFromString:self.model.currentDate withFormat:@"dd-MM-yyyy"] ?: [NSDate date];
    
    NSDateComponents *dateCom = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger currentYear = dateCom.year ?: 0;
    NSInteger currentMonth = dateCom.month ?: 0;
    NSInteger currentDay = dateCom.day ?: 0;
    NSInteger currentYearIndex = self.currentDateCom.year - currentYear;
    
    [self.pickerView selectRow:currentYearIndex inComponent:2 animated:YES];
    [self.pickerView selectRow:currentMonth - 1 inComponent:1 animated:YES];
    [self.pickerView selectRow:currentDay - 1 inComponent:0 animated:YES];
    
    [self pickerView:self.pickerView didSelectRow:currentDay - 1 inComponent:0];
    [self pickerView:self.pickerView didSelectRow:currentMonth - 1 inComponent:1];
    [self pickerView:self.pickerView didSelectRow:currentYearIndex inComponent:2];
}

- (void)setModel:(BPDatePickerViewModel *)model{
    _model = model;
    [self applyModel];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 2) {
        return 100; // Years
    } else if (component == 1) {
        return self.months.count;
    } else {
        return self.days.count;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRatio(50);
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 2) {
        return [NSString stringWithFormat:@"%ld",
                (self.currentDateCom.year - row)];
    } else if (component == 1) {
        return [NSString stringWithFormat:@"%ld", (row + 1)];
    } else {
        return [NSString stringWithFormat:@"%ld", (row + 1)];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedComponent = component;
    self.selectedYear = (self.currentDateCom.year) - [pickerView selectedRowInComponent:2];
    self.selectedMonth = [pickerView selectedRowInComponent:1] + 1;
    self.selectedDay = [pickerView selectedRowInComponent:0] + 1;
    
    NSString *dateString = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",
                            self.selectedDay,
                            self.selectedMonth,
                            self.selectedYear];
    
    if (self.model.valueChanged) {
        self.model.valueChanged(dateString);
    }
    if (component == 2) {
        NSInteger year = [pickerView selectedRowInComponent:2] + self.currentDateCom.year;
        NSInteger currentMonth = [[NSDate date] currentMonth];
        NSInteger currentYear = [[NSDate date] currentYear];
        if (year == currentYear) {
            self.months = [self createMonthArrayUpTo:currentMonth];
        } else {
            self.months = [self createMonthArray];
        }
        [pickerView reloadComponent:1];
    }
    if (component == 1) {
        NSInteger year = [pickerView selectedRowInComponent:2] + self.currentDateCom.year;
        NSInteger month = [pickerView selectedRowInComponent:1] + 1;
        NSInteger daysInMonth = [self daysInMonth:month year:year];
        NSInteger currentMonth = [[NSDate date] currentMonth];
        NSInteger currentYear = [[NSDate date] currentYear];
        NSInteger currentDay = [[NSDate date] currentDay];
        if (year == currentYear && month == currentMonth) {
            self.days = [self createDayArrayUpTo:currentDay];
        } else {
            self.days = [self createDayArrayUpTo:daysInMonth];
        }
        [pickerView reloadComponent:0];
    }
}

- (NSArray<NSNumber *> *)createMonthArray {
    NSMutableArray *months = [NSMutableArray array];
    for (int i = 1; i <= 12; i++) {
        [months addObject:@(i)];
    }
    return [months copy];
}

- (NSArray<NSNumber *> *)createMonthArrayUpTo:(NSInteger)month {
    NSMutableArray *months = [NSMutableArray array];
    for (int i = 1; i <= month; i++) {
        [months addObject:@(i)];
    }
    return [months copy];
}

- (NSArray<NSNumber *> *)createDayArray {
    return [self createDayArrayUpTo:31];
}

- (NSArray<NSNumber *> *)createDayArrayUpTo:(NSInteger)day {
    NSMutableArray *days = [NSMutableArray array];
    for (int i = 1; i <= day; i++) {
        [days addObject:@(i)];
    }
    return [days copy];
}

- (NSInteger)daysInMonth:(NSInteger)month year:(NSInteger)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

@end


NS_ASSUME_NONNULL_END
