//
//  SIMNetStatusManager.h
//  AFNetworking
//
//  on 2020/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * 网络状态值
 */
typedef NS_ENUM(NSInteger,SIMNetworkType) {
    
    /** 当前无网络 */
    SIMNetworkType_NONE=0,
    
    /** 当前网络是WIFI */
    SIMNetworkType_WIFI,
    
    /** 当前网络是4G */
    SIMNetworkType_4G,
    
    /** 当前网络是3G */
    SIMNetworkType_3G,
    
    /** 当前网络是GPRS */
    SIMNetworkType_GPRS,
    
    /** 当前网络为LAN类型 */
    SIMNetworkType_LAN,
    
    /** 当前网络为其他 */
    SIMNetworkType_Other,
};



@interface SIMNetStatusManager : NSObject

@property (nonatomic, assign) SIMNetworkType networkType;    //当前网络的状态

@property (nonatomic, assign) SIMNetworkType networkType_ImageObserve;

+ (instancetype)sharedInstanced;

- (void)listenerNet;
- (void)pullNetWorkState;

@end

NS_ASSUME_NONNULL_END
