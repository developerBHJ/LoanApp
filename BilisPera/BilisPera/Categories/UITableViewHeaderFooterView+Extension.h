//
//  UITableViewHeaderFooterView+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (Extension)

@property (nonatomic, strong, readonly) NSString *reuseId;

-(void)configData:(id)data;


@end


NS_ASSUME_NONNULL_END
