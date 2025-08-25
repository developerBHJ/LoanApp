//
//  BPAddressPickerView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPAddressPickerView.h"

NS_ASSUME_NONNULL_BEGIN
@implementation BPAddressPickerViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentHeight = kRatio(200);
    }
    return self;
}

@end

@interface BPAddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *thirdButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) NSLayoutConstraint *indicatorCenterXConstraint;

@property (nonatomic, assign) NSInteger selectedType;
@property (nonatomic, strong) BPAddressModel *selectedProvince;
@property (nonatomic, strong) BPAddressModel *selectedCity;
@property (nonatomic, strong) BPAddressModel *selectedStreet;

@end

@implementation BPAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self applyModel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame model:(BPAddressPickerViewModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self setupUI];
        [self applyModel];
    }
    return self;
}

- (void)setModel:(BPAddressPickerViewModel *)model {
    _model = model;
    [self applyModel];
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
    
    // Buttons
    _firstButton = [self createButtonWithTitle:@"Street" tag:1000];
    _secondButton = [self createButtonWithTitle:@"Town" tag:1001];
    _thirdButton = [self createButtonWithTitle:@"State" tag:1002];
    
    // Line View
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor blackColor];
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_firstButton];
    [self addSubview:_secondButton];
    [self addSubview:_thirdButton];
    [self addSubview:_lineView];
    
    // Constraints
    [self setupConstraints];
}

- (UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(segementEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.tag = tag;
    return button;
}

- (void)setupConstraints {
    CGFloat buttonWidth = (kScreenW - kRatio(44)) / 3;
    self.indicatorCenterXConstraint = [self.lineView.centerXAnchor constraintEqualToAnchor:self.firstButton.centerXAnchor];
    
    [NSLayoutConstraint activateConstraints:@[
        // PickerView constraints
        [self.pickerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.pickerView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kRatio(44)],
        [self.pickerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.pickerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.pickerView.heightAnchor constraintEqualToConstant:kRatio(436)],
        
        // First button constraints
        [self.firstButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kRatio(22)],
        [self.firstButton.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.firstButton.heightAnchor constraintEqualToConstant:kRatio(44)],
        [self.firstButton.widthAnchor constraintEqualToConstant:buttonWidth],
        
        // Second button constraints
        [self.secondButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.secondButton.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.secondButton.heightAnchor constraintEqualToConstant:kRatio(44)],
        [self.secondButton.widthAnchor constraintEqualToConstant:buttonWidth],
        
        // Third button constraints
        [self.thirdButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kRatio(22)],
        [self.thirdButton.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.thirdButton.heightAnchor constraintEqualToConstant:kRatio(44)],
        [self.thirdButton.widthAnchor constraintEqualToConstant:buttonWidth],
        
        // Line view constraints
        self.indicatorCenterXConstraint,
        [self.lineView.topAnchor constraintEqualToAnchor:self.firstButton.bottomAnchor constant:-kRatio(5)],
        [self.lineView.heightAnchor constraintEqualToConstant:kRatio(3)],
        [self.lineView.widthAnchor constraintEqualToConstant:kRatio(32)]
    ]];
}

#pragma mark - Model Application

- (void)applyModel {
    [self.pickerView reloadAllComponents];
    [self segementEvent:self.firstButton];
}

#pragma mark - Button Actions

- (void)segementEvent:(UIButton *)sender {
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectedButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.selectedButton = sender;
    
    self.indicatorCenterXConstraint.active = NO;
    self.indicatorCenterXConstraint = [self.lineView.centerXAnchor constraintEqualToAnchor:sender.centerXAnchor];
    self.indicatorCenterXConstraint.active = YES;
    
    NSInteger tag = sender.tag - 1000;
    self.selectedType = tag;
    [self.pickerView reloadComponent:0];
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    
    [self setNeedsLayout];
}

- (void)nextStep {
    if (self.selectedProvince && !self.selectedCity) {
        [self segementEvent:self.secondButton];
    } else if (self.selectedProvince && self.selectedCity) {
        [self segementEvent:self.thirdButton];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.selectedType) {
        case 0: return self.model.dataSource.count;
        case 1: return self.selectedProvince.andwalked.count;
        case 2: return self.selectedCity.andwalked.count;
        default: return 0;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRatio(50);
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.selectedType) {
        case 0:
            return row < self.model.dataSource.count ? self.model
                .dataSource[row].tongues : nil;
        case 1:
            return row < self.selectedProvince.andwalked.count ? self.selectedProvince
                .andwalked[row].tongues : nil;
        case 2:
            return row < self.selectedCity.andwalked.count ? self.selectedCity
                .andwalked[row].tongues : nil;
        default:
            return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *address = @"";
    BOOL completed = NO;
    
    switch (self.selectedType) {
        case 0:
            if (row < self.model.dataSource.count) {
                self.selectedProvince = self.model.dataSource[row];
                address = self.selectedProvince.tongues ?: @"";
            }
            break;
            
        case 1:
            if (row < self.selectedProvince.andwalked.count) {
                self.selectedCity = self.selectedProvince.andwalked[row];
                NSString *province = self.selectedProvince.tongues ?: @"";
                NSString *city = self.selectedCity.tongues ?: @"";
                address = [NSString stringWithFormat:@"%@-%@", province, city];
            }
            break;
            
        case 2:
            if (row < self.selectedCity.andwalked.count) {
                self.selectedStreet = self.selectedCity.andwalked[row];
                NSString *province = self.selectedProvince.tongues ?: @"";
                NSString *city = self.selectedCity.tongues ?: @"";
                NSString *street = self.selectedStreet.tongues ?: @"";
                address = [NSString stringWithFormat:@"%@-%@-%@",
                           province,
                           city,
                           street];
                completed = YES;
            }
            break;
    }
    if (self.model.valueChanged) {
        self.model.valueChanged(address);
    }
    if (self.model.completed) {
        self.model.completed(completed);
    }
}

@end

NS_ASSUME_NONNULL_END
