//
//  GG_RouterModel.h
//  GGRouter
//
//  Created by gaolijun on 2019/4/8.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GGRoutableAgreementViewType) {
    GGRoutableAgreementViewTypeNativePageParmas = 0,
    GGRoutableAgreementViewTypeNaToRnNoParmas = 1, // NA转RN界面
    GGRoutableAgreementViewTypeRNNoParmas = 2, // RN界面无参数
    GGRoutableAgreementViewTypeSysSetting = 3, // 跳转到设置
    GGRoutableAgreementViewTypePresentView = 4, // present跳转街界面
    GGRoutableAgreementViewTypeNaToRnParmas = 5,
    GGRoutableAgreementViewTypeOther = 6
};

NS_ASSUME_NONNULL_BEGIN

@interface GG_RouterModel : NSObject

@property(nonatomic,copy) NSString *host;
@property (nonatomic, assign) GGRoutableAgreementViewType viewType;

@end

NS_ASSUME_NONNULL_END
