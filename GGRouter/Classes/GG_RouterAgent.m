//
//  GG_RouterAgent.m
//  GGRouter
//
//  Created by gaolijun on 2019/4/8.
//

#import "GG_RouterAgent.h"
#import "GG_Router.h"

@interface GG_RouterAgent ()

@property(nonatomic,strong) NSMutableDictionary *routableDic;
@property(nonatomic,strong) NSDictionary *urlHostMap; // host转换map
@property(nonatomic,strong) NSMutableDictionary *routableViewInfo;

@end

@implementation GG_RouterAgent

- (NSMutableDictionary *)routableDic {
    if (!_routableDic) {
        _routableDic = [NSMutableDictionary dictionary];
    }
    return _routableDic;
}

- (NSMutableDictionary *)routableViewInfo {
    if (!_routableViewInfo) {
        _routableViewInfo = [NSMutableDictionary dictionary];
    }
    return _routableViewInfo;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static GG_RouterAgent *routableAgreement = nil;
    dispatch_once(&onceToken, ^{
        routableAgreement = [[self alloc] init];
    });
    return routableAgreement;
}

/** 设置na转rn的界面 */
- (void)setNAToRNViews:(NSArray *)views {
    for (NSString *host in views) {
        GG_RouterModel *model = [[GG_RouterModel alloc] init];
        model.host = host;
        model.viewType = GGRoutableAgreementViewTypeNaToRnNoParmas;
        [self.routableViewInfo setObject:model forKey:host];
    }
}

- (void)setNAToRNParmasViews:(NSArray *)views {
    for (NSString *host in views) {
        GG_RouterModel *model = [[GG_RouterModel alloc] init];
        model.host = host;
        model.viewType = GGRoutableAgreementViewTypeNaToRnParmas;
        [self.routableViewInfo setObject:model forKey:host];
    }
}

- (void)setMap:(Class)controller host:(NSString *)host viewType:(GGRoutableAgreementViewType)viewType {
    
    if (viewType != GGRoutableAgreementViewTypeSysSetting) {
        
    }
    
    NSString *mapURL = [NSString stringWithFormat:@"%@/:page",host];
    [self.routableDic setObject:mapURL forKey:host];
    [[GG_Router sharedRouter] map:mapURL toController:controller];
    
    GG_RouterModel *model = [[GG_RouterModel alloc] init];
    model.host = host;
    model.viewType = viewType;
    [self.routableViewInfo setObject:model forKey:host];
}

- (BOOL)setNavigationController:(UINavigationController *)navController {
    
    if (navController != nil) {
        [[GG_Router sharedRouter] setNavigationController:navController];
        return YES;
    }
    
    UINavigationController *nav = [self currentNavigationController];
    if (nav == nil) {
        return NO;
    }
    [[GG_Router sharedRouter] setNavigationController:nav];
    
    return YES;
}

- (UINavigationController *)currentNavigationController {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *vcc = [(UITabBarController *)vc selectedViewController];
        return vcc;
    }else if ([vc isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)vc;
    }else {
        return nil;
    }
}

/** 转换为真实跳转链接 */
- (NSString *)exchangeTrueUrl:(NSString *)url {
    NSString *sub = @"";
    NSString *urlStr = nil;
    for (int i = 0; i < url.length; i++) {
        NSString *s = [url substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"?"]) {
            sub = [url substringFromIndex:i + 1];
            urlStr = [url substringToIndex:i];
            break;
        }
    }
    
    if ([sub isEqualToString:@""]) {
        urlStr = url;
    }
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    if (URL != nil) {
        NSString *host = URL.host;
        if (self.urlHostMap[host] != NULL) {
            return [NSString stringWithFormat:@"tengyue://%@?%@",self.urlHostMap[host],sub];
        }
    }
    return url;
}

- (void)setTrueUrlHostDic:(NSDictionary *)dic {
    self.urlHostMap = dic;
}

#pragma mark - 跳转
- (void)pushController:(NSString *)url {
    [[GG_Router sharedRouter] open:url];
}

@end
