//
//  HomeViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import <Foundation/Foundation.h>
#import "HomeSectionModel.h"
#import "HomeHeaderCell.h"
#import "HomeKingKongCell.h"
#import "HomeCommonQuestionsCell.h"
#import "HomeLargeCell.h"
#import "HomeProductListCell.h"
#import "HomeNoticeCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HomePageEventDelegate <NSObject>

-(void)onPushProductDetail:(NSString *)prodcutId;
-(void)kingKongItemClick:(HomeKingKongType)type;
-(void)onpushCommonQuestionsView;
-(void)onpushOtherView:(NSString *)url;

@end

@interface HomeViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) id<HomePageEventDelegate> deleagete;

-(void)reloadData:(simpleCompletion)completion;

@end

NS_ASSUME_NONNULL_END
