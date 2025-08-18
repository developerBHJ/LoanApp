//
//  BPProductAuthInfoConfirmViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "ProductAuthenSectionModel.h"
#import "ProductAuthenIndetyInfoModel.h"
#import "ProdcutAuthenticationUserInfoCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BPProductAuthInfoConfirmViewDelegate <NSObject>

-(void)pickerDate;

@end

@interface BPProductAuthInfoConfirmViewModel : NSObject

@property (nonatomic, strong) ProductAuthenIndetyInfoModel *infoModel;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *birthDay;

@property (nonatomic, strong) NSString *productId;

@property (nonatomic, weak) id<BPProductAuthInfoConfirmViewDelegate> delegate;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
