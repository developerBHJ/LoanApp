//
//  HomeNoticeCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface HomeNoticeCellModel : NSObject

- (instancetype)initWith:(NSString *)title completion:(nullable simpleCompletion)completion;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy,nullable) simpleCompletion completion;


@end


@interface HomeNoticeCell : UICollectionViewCell

@property (nonatomic, strong) HomeNoticeCellModel *model;

@end

NS_ASSUME_NONNULL_END
