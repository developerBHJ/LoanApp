//
//  LoginInputView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^sendCodeCompletion)(void);
typedef void(^textFieldValueChanged)(NSString *);

@interface LoginInputView : UIView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder needLeftView:(BOOL)needLeftView needRightView:(BOOL)needRightView  sendCode:(nullable sendCodeCompletion)sendCode;
@property (nonatomic, copy) textFieldValueChanged didEndEditting;

-(void)cutDown;
-(void)endCutDown;
@end

NS_ASSUME_NONNULL_END
