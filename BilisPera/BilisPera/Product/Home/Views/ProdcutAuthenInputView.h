//
//  ProdcutAuthenInputView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenInputViewModel : NSObject

@property (nonatomic, assign) BPProductFormStyle style;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) UIColor *inputBgColor;
@property (nonatomic, strong) NSString *leftImage;
@property (nonatomic, strong,readonly) NSString *rightImageName;
@property (nonatomic, copy) simpleCompletion completion;
@property (nonatomic, copy) simpleStringCompletion valueChanged;
@property (nonatomic, assign) UIKeyboardType keyboardType;


- (instancetype)initWith:(BPProductFormStyle)style title:(NSString *)title text:(NSString *)text placeHolder:(NSString *)placeHolder inputBgColor:(UIColor *)inputBgColor completion:(simpleCompletion)completion valueChanged:(simpleStringCompletion)valueChanged;

@end

@interface ProdcutAuthenInputView : UIView

@property (nonatomic, strong) ProdcutAuthenInputViewModel *model;

@end

NS_ASSUME_NONNULL_END
