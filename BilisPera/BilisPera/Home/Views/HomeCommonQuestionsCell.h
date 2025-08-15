//
//  HomeCommonQuestionsCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCommonQuestionsCellModel : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, copy,nullable) simpleCompletion completion;

@end

@interface HomeCommonQuestionsCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
