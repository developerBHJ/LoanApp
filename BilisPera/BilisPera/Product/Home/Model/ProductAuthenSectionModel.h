//
//  ProductAuthenSectionModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductAuthenSectionModel : UITableViewAdapter

@property (nonatomic, assign) NSInteger sectionType;
@property (nonatomic, strong) Class headerClass;
@property (nonatomic, strong) id headerModel;

@property (nonatomic, strong) NSString *headerId;
@property (nonatomic, assign) CGFloat headerHeight;

- (instancetype)initWith:(Class)cellType cellData:(NSArray *)cellData sectionType:(NSInteger)sectionType;

@end

NS_ASSUME_NONNULL_END
