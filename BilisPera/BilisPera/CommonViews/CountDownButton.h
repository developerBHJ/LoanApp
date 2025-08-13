//
//  CountDownButton.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CountDownButton;

@protocol CountDownButtonDataSource <NSObject>

@required
// 设置起始倒计时秒数
- (NSUInteger)startCountDownNumOfCountDownButton:(CountDownButton *)countDownButton;

@end

@protocol CountDownButtonDelegate <NSObject>

@optional
// 倒计时按钮点击回调
- (void)countDownButtonDidClick:(CountDownButton *)countDownButton;
// 倒计时开始时的回调
- (void)countDownButtonDidStartCountDown:(CountDownButton *)countDownButton;

@required
// 倒计时进行中的回调
- (void)countDownButtonDidInCountDown:(CountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum;
// 倒计时结束时的回调
- (void)countDownButtonDidEndCountDown:(CountDownButton *)countDownButton;

@end
@interface CountDownButton : UIButton

#pragma mark - block版本

/**
 所有回调通过block配置
 
 @param duration            设置起始倒计时秒数
 @param buttonClicked       倒计时按钮点击回调
 @param countDownStart      倒计时开始时的回调
 @param countDownUnderway   倒计时进行中的回调
 @param countDownCompletion 倒计时结束时的回调
 */
- (void)configDuration:(NSUInteger)duration
         buttonClicked:(nullable dispatch_block_t)buttonClicked
        countDownStart:(nullable dispatch_block_t)countDownStart
     countDownUnderway:(void (^)(NSInteger restCountDownNum))countDownUnderway
   countDownCompletion:(dispatch_block_t)countDownCompletion;

#pragma mark - delegate版本

@property (nonatomic, weak, nullable) id <CountDownButtonDataSource> dataSource;
@property (nonatomic, weak, nullable) id <CountDownButtonDelegate> delegate;

#pragma mark - 开始/结束 倒计时

/**
 开始倒计时
 */
- (void)startCountDown;

/**
 结束倒计时
 倒计时结束时会自动调用此方法
 也可以主动调用此方法提前结束倒计时
 调用此方法会回调倒计时结束的block和代理方法
 */
- (void)endCountDown;

@end

NS_ASSUME_NONNULL_END
