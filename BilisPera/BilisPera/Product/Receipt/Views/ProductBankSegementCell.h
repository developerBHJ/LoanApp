//
//  ProductBankSegementCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductBankSegementCellModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSNumber *> *values;
@property (nonatomic, copy) simpleIntCompletion completion;
@property (nonatomic, assign) NSInteger defaultType;

- (instancetype)initWith:(NSArray<NSString *> *)titles values:(NSArray<NSNumber *> *)values completion:(simpleIntCompletion)completion;

@end

@interface ProductBankSegementCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
