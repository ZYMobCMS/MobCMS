//
//  AdMoGoAdapterXingYunInterstitial.m
//  CTAdsMogoSample
//
//  Created by Chasel on 14-3-19.
//  Copyright (c) 2014年 Chasel. All rights reserved.
//

#import "AdMoGoAdapterXingYunInterstitial.h"
#import <AdWalker/GuUserConfig.h>
#import <AdWalker/GuInitServer.h>
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"


@implementation AdMoGoAdapterXingYunInterstitial

+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeXingYun;
}

+ (void)load{
    [[AdMoGoAdSDKInterstitialNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    isLoaded =NO;
    isStop =NO;
    //初始化配置
    [GuUserConfig getInstance].guAppKey =[self.ration objectForKey:@"key"];//应用key
    [GuUserConfig getInstance].guChannel =@"adsmogo";//渠道(选填)
    //应用启动时候初始化..
    GuInitServer *initServer = [[GuInitServer alloc]init];
    [initServer getInit];
    [initServer release];
    
     //发送请求数量
    [interstitial adapterDidStartRequestAd:self];
    
   UIViewController* viewController = [self.adMoGoInterstitialDelegate viewControllerForPresentingInterstitialModalView];
    
    
    
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:interstitial.configKey];
    
    AdViewType type =[configData.ad_type intValue];
    
    switch (type) {
        case AdViewTypeFullScreen:
        case AdViewTypeiPadFullScreen:
            //特殊控制释放
            if ([PobFrameWall getInstance].delegate) {
                 [PobFrameWall getInstance].delegate = nil; [PobFrameWall destroy];
            }
            [[PobFrameWall getInstance]orientation:@"Portrait" andDelegate:self andUIViewController:viewController];
        break;
        default:
            break;
    }
    id _timeInterval = [self.ration objectForKey:@"to"];
    if ([_timeInterval isKindOfClass:[NSNumber class]]) {
        timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
    else{
        timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut15 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
}



- (void)loadAdTimeOut:(NSTimer*)theTimer{
    [super loadAdTimeOut:theTimer];
    [self stopBeingDelegate];
    [interstitial adapter:self didFailAd:nil];
}




- (void)stopBeingDelegate {
    [self stopTimer];
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)stopAd{
    isStop = YES;
    [self stopBeingDelegate];
}

- (BOOL)isReadyPresentInterstitial{
    return isLoaded;
}


- (void)presentInterstitial{
     [[PobFrameWall getInstance] showpobFrame];
}


#pragma mark --delegate


#pragma mark -插屏弹出成功
-(void)showPobFrameSucess
{

}
#pragma mark -插屏弹出失败
-(void)showPobFrameFail
{

}
#pragma mark -插屏关闭
-(void)closeGuFrameWall
{
    [interstitial adapter:self didDismissScreen:nil];
}
#pragma mark -插屏预加载成功
-(void)initPobFrameSuccess
{
    if (isStop) {
        return;
    }
    isLoaded=YES;
      [self stopTimer];
    //插屏预加载成功，调用展示插屏接口
   [interstitial adapter:self didReceiveInterstitialScreenAd:nil];
}
#pragma mark -插屏预加载失败
-(void)initPobFrameFail

{
    if (isStop) {
        return;
    }
    [self stopTimer];
    [interstitial adapter:self didFailAd:nil];
}


-(void)dealloc{
    [super dealloc];
}


@end
