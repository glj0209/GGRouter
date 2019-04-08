//
//  GG_RouterAgent.h
//  GGRouter
//
//  Created by gaolijun on 2019/4/8.
//

#import <Foundation/Foundation.h>
#import "GG_RouterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GG_RouterAgent : NSObject

/** 跳转协议map */
@property(nonatomic,strong,readonly) NSMutableDictionary *routableDic;
/** 跳转界面信息 */
@property (nonatomic, strong,readonly) NSMutableDictionary *routableViewInfo;
/** 获取单例 */
+ (instancetype)sharedInstance;
/** 设置navigation */
- (BOOL)setNavigationController:(UINavigationController *)navController;
/** 跳转到指定界面 */
- (void)pushController:(NSString *)url;
/** 设置na转rn的界面 */
- (void)setNAToRNViews:(NSArray *)views;
- (void)setNAToRNParmasViews:(NSArray *)views;
/** 添加新的跳转协议 */
- (void)setMap:(Class)controller host:(NSString *)host viewType:(GGRoutableAgreementViewType)viewType;
/** 转换为真实跳转链接 */
- (NSString *)exchangeTrueUrl:(NSString *)url;
- (void)setTrueUrlHostDic:(NSDictionary *)dic;
- (UINavigationController *)currentNavigationController;

@end

NS_ASSUME_NONNULL_END
