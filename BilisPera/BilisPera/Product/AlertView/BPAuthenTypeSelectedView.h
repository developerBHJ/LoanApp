//
//  BPAuthenTypeSelectedView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>
#import "ProductSectionModel.h"
#import "BPAuthenTypeSelectedItemCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPAuthenTypeSelectedViewModel : NSObject

@property (nonatomic, assign) Class cellType;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, strong) NSArray<ProductSectionModel *> *dataSource;
@property (nonatomic, copy) simpleStringCompletion completion;

@end

@interface BPAuthenTypeSelectedView : UIView

@property (nonatomic, strong) BPAuthenTypeSelectedViewModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(BPAuthenTypeSelectedViewModel *)model;

@end

NS_ASSUME_NONNULL_END
