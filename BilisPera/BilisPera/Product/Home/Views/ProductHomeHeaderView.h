//
//  ProductHomeHeaderView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductHomeHeaderViewModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *amountDesc;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) NSString *rightImageName;

@end

@interface ProductHomeHeaderView : BaseTableViewCell


@end

NS_ASSUME_NONNULL_END
