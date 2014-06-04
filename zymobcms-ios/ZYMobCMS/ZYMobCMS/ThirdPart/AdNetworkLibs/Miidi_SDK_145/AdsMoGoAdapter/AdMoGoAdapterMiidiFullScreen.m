//
//  AdMoGoAdapterMiidiFullScreen.m
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 14-4-4.
//  Copyright (c) 2014年 Daxiong. All rights reserved.
//
#import "MiidiManager.h"
#import "MiidiAdSpot.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoAdapterMiidiFullScreen.h"

@interface AdMoGoAdapterMiidiFullScreen (){
    
    BOOL isReady;
    BOOL isStop;
    
}

@end
@implementation AdMoGoAdapterMiidiFullScreen

+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeMiidi;
}

+ (void)load {
	[[AdMoGoAdSDKInterstitialNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    
    isReady = NO;
    isStop = NO;
    
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:interstitial.configKey];
    AdViewType type =[configData.ad_type intValue];
    
	if (type == AdViewTypeFullScreen || type==AdViewTypeiPadFullScreen) {
        
        if (!isManagerCreate) {
            
            isManagerCreate = YES;
            [MiidiManager setAppPublisher:[[self.ration objectForKey:@"key"] objectForKey:@"appID"]
                            withAppSecret:[[self.ration objectForKey:@"key"] objectForKey:@"appPassword"] ];
            
        }
        
        [interstitial adapterDidStartRequestAd:self];
        
        if(![MiidiAdSpot isSpotAdReady]){ // 插屏广告还没有准备好
            
            id _timeInterval = [self.ration objectForKey:@"to"];
            if ([_timeInterval isKindOfClass:[NSNumber class]]) {
                timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
            }
            else{
                timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut8 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
            }
            
            [MiidiAdSpot requestSpotAd:^(NSError *error){ // 请求插屏数据源
                if(error != nil){ //失败
                    [self requestSpotAdError:error];
                }
                else{ // 获取数据成功
                    [self requestSpotAdSuccess];
                }
                
            }];
        }else{ // 数据都准备好了
            [self requestSpotAdSuccess];
        }
        
        
    }else{
        
        [interstitial adapter:self didFailAd:nil];
        
    }
    
    
}

- (void)stopBeingDelegate{

}

- (void)stopAd{
    
    isStop = YES;
    
}

- (BOOL)isReadyPresentInterstitial{
    return isReady;
}

- (UIViewController *)getViewControllerToMiidi{
    UIViewController *viewController = nil;
    if ([self.adMoGoInterstitialDelegate respondsToSelector:@selector(viewControllerForPresentingInterstitialModalView)]) {
        viewController = [self.adMoGoInterstitialDelegate viewControllerForPresentingInterstitialModalView];
    }
    if (viewController && [viewController navigationController]) {
        
        viewController = [viewController navigationController];
        
    }else if(!viewController){
        
        viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
    }
    
    return viewController;
}
- (void)presentInterstitial{
    // 呈现插屏广告
    
    if (isReady) {
        
        // 已经准备好了
        if([MiidiAdSpot isSpotAdReady])
        {
            [MiidiAdSpot displaySpotAdWithBlock:[self getViewControllerToMiidi] block:^(){ // 展示插屏广告
                [self MiidiAdSpotDidDismiss];
            }];
        }
        
    }
    
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (isStop) {
        return;
    }
    [super loadAdTimeOut:theTimer];
    [self stopTimer];
    [self stopBeingDelegate];
    [interstitial adapter:self didFailAd:nil];
}

- (void)stopTimer {
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (timer) {
            [timer invalidate];
            [timer release];
            timer = nil;
        }
        
    });
    
}
#pragma mark -
#pragma mark miidi block method

- (void)requestSpotAdSuccess{
    if (isStop) {
        return;
    }
    [self stopTimer];
    isReady = YES;
    
    [interstitial adapter:self didReceiveInterstitialScreenAd:nil];
    
}

- (void)requestSpotAdError:(NSError *)error{
    if (isStop) {
        return;
    }
    [self stopTimer];
    [interstitial adapter:self didFailAd:nil];
}

- (void)MiidiAdSpotDidDismiss{
    if (isStop) {
        return;
    }
    
    [interstitial adapter:self didDismissScreen:nil];
}
@end
