//
//  BPCommonQuestionsListCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPCommonQuestionsListCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
- (instancetype)initWith:(NSString *)title content:(NSString *)content;

@end


@interface BPCommonQuestionsListCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
