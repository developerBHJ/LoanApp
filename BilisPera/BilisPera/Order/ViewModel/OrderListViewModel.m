//
//  OrderListViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "OrderListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation OrderListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

-(void)configData{
    OrderListSectionModel *model = [self configList];
    self.dataSource = @[model];
}

-(OrderListSectionModel *)configList{
    OrderListCellModel *model = [[OrderListCellModel alloc] init];
    model.type = OrderListTypeApply;
    model.name = @"Bilis Pera";
    model.amount = @"₱97,000";
    model.amountDesc = @"Max Amount";
    model.dateStr = @"Payment Date：11-02-2024";
    model.buttonTitle = @"Repayment";
    model.status = @"Repayment";
    model.remind = @"🔔Pay on time to increase your creditscore, pay now";
    
    OrderListCellModel *model1= [[OrderListCellModel alloc] init];
    model1.type = OrderListTypeDelay;
    model1.name = @"Bilis Pera";
    model1.amount = @"₱97,000";
    model1.amountDesc = @"Max Amount";
    model1.dateStr = @"Payment Date：11-02-2024";
    model1.buttonTitle = @"Repayment";
    model1.status = @"Repayment";
    model1.remind = @"🔔Pay on time to increase your creditscore, pay now";
    
    OrderListCellModel *model2 = [[OrderListCellModel alloc] init];
    model2.type = OrderListTypeRepayment;
    model2.name = @"Bilis Pera";
    model2.amount = @"₱97,000";
    model2.amountDesc = @"Max Amount";
    model2.dateStr = @"Payment Date：11-02-2024";
    model2.buttonTitle = @"Repayment";
    model2.status = @"Repayment";
    model2.remind = @"🔔Pay on time to increase your creditscore, pay now";
    
    OrderListCellModel *model3 = [[OrderListCellModel alloc] init];
    model3.type = OrderListTypeReview;
    model3.name = @"Bilis Pera";
    model3.amount = @"₱97,000";
    model3.amountDesc = @"Max Amount";
    model3.dateStr = @"Payment Date：11-02-2024";
    model3.buttonTitle = @"Repayment";
    model3.status = @"Repayment";
    model3.remind = @"🔔Pay on time to increase your creditscore, pay now";
    
    OrderListCellModel *model4 = [[OrderListCellModel alloc] init];
    model4.type = OrderListTypeFinish;
    model4.name = @"Bilis Pera";
    model4.amount = @"₱97,000";
    model4.amountDesc = @"Max Amount";
    model4.dateStr = @"Payment Date：11-02-2024";
    model4.buttonTitle = @"Repayment";
    model4.status = @"Repayment";
    model4.remind = @"🔔Pay on time to increase your creditscore, pay now";
    
    OrderListSectionModel *section = [[OrderListSectionModel alloc] initWith:[OrderListCell class] cellData:@[model,model1,model2,model3,model4]];
    return section;
}

@end

NS_ASSUME_NONNULL_END
