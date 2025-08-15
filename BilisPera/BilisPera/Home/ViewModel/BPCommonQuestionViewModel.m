//
//  BPCommonQuestionViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "BPCommonQuestionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPCommonQuestionViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

-(void)configData{
    NSArray *titles = @[@"1、Introduction Bilis Pera",@"2、How much can I borrow?",@"3、When will I receive my funds?",@"4、 Are there any hidden fees?"];
    NSArray *contentArray = @[@"We are a company that provides innovative financial services with a commitment to providing fast, safe and comfortable financial solutions",@"Your maximum available amount is ₱97,000. No worries about loans,Enjoy your life to the fullest",@"Once approved, the loan will be transferred directly to your bank account, usually within hours",@"Make Loan is committed to transparency. All costs and fees are clearly disclosed before you fınalize your loan."];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count; i ++) {
        BPCommonQuestionsListCellModel *model = [[BPCommonQuestionsListCellModel alloc] initWith:titles[i] content:contentArray[i]];
        [tempArray addObject:model];
    }
    HomeSectionModel *section = [[HomeSectionModel alloc] initWith:[BPCommonQuestionsListCell class] cellData:tempArray];
    self.dataSource = @[section];
}

@end

NS_ASSUME_NONNULL_END
