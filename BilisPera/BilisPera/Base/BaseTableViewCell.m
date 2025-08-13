//
//  BaseTableViewCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
