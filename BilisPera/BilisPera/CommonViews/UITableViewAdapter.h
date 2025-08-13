//
//  UITableViewAdapter.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewAdapter : NSObject

@property (nonatomic, strong) Class cellType;
@property (nonatomic, strong, nullable) NSArray *cellData;
@property (nonatomic, strong, readonly) NSString *cellId;

- (instancetype)initWith:(Class)cellType cellData:(NSArray *)cellData;

@end

NS_ASSUME_NONNULL_END
