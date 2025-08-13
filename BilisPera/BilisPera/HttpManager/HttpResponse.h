//
//  HttpResponse.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpResponse : NSObject
// 错误码
@property (nonatomic,assign) NSInteger resolution;
// 提示信息
@property (nonatomic,strong) NSString *forbreakfast;
// 数据
@property (nonatomic,strong) id couldsee;

@end

NS_ASSUME_NONNULL_END
