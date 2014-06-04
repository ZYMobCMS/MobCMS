//
//  AdMoGoAdapterPuchBoxFullScreen.m
//  wanghaotest
//
//  Created by MOGO on 13-9-28.
//
//

#import "PBInterstitialSingleton.h"
#import "AdMoGoAdapterPuchBoxFullScreen.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoDeviceInfoHelper.h"

@interface AdMoGoAdapterPuchBoxFullScreen ()<PBInterstitialSingletonDelegate>{
    
    PBInterstitialSingleton *pbSingleton;
    
}

@property (nonatomic, retain) PBInterstitial *pbInterstitial;

@end

@implementation AdMoGoAdapterPuchBoxFullScreen

+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypePuchBox;
}

+ (void)load {
	[[AdMoGoAdSDKInterstitialNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    isReady = NO;
    isFail = NO;
    isClosed = NO;
    
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:interstitial.configKey];
    
    AdViewType type =[configData.ad_type intValue];
    
    
    switch (type) {
        case AdViewTypeFullScreen:
        case AdViewTypeiPadFullScreen:
            break;
        default:
            [interstitial adapter:self didFailAd:nil];
            return;
    }
    
    NSString *mPunchBoxID = nil;
    NSString *mAdMobiID = nil;
    NSString *mPlacementID = nil;
    id key = [self.ration objectForKey:@"key"];
    if ([key isKindOfClass:[NSDictionary class]]) {
        mPunchBoxID = [key objectForKey:@"mPunchBoxID"];
        mAdMobiID = [key objectForKey:@"mAdMobiID"];
        mPlacementID = [key objectForKey:@"placementID"];
    }else{
        [interstitial adapter:self didFailAd:nil];
        return;
    }
    
    pbSingleton = [PBInterstitialSingleton shareInstanceWithPID:mPunchBoxID];

    [pbSingleton initInterstitialWithPlaceId:mPlacementID];

    [interstitial adapterDidStartRequestAd:self];

    if (pbSingleton.isReady) {

        pbSingleton.delegate = self;
        isReady = YES;
        [interstitial adapter:self didReceiveInterstitialScreenAd:nil];
    }else if(pbSingleton.isError){
        
        [interstitial adapter:self didFailAd:nil];
        
    }else{

        pbSingleton.delegate = self;
        
        id _timeInterval = [self.ration objectForKey:@"to"];
        if ([_timeInterval isKindOfClass:[NSNumber class]]) {
            timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
        else{
            timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut15 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
        
    }
}

- (void)loadAdTimeOut:(NSTimer*)theTimer{
    [self stopTimer];
    [self interstitalFail];
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
//    self.pbInterstitial.delegate = nil;
//    self.pbInterstitial = nil;
    
    if (pbSingleton.delegate == self) {
        pbSingleton.delegate = nil;
    }
    
    [self stopTimer];
}
- (void)dealloc {
    MGLog(MGT, @"%s",__func__);
    
    if (pbSingleton.delegate == self) {
        pbSingleton.delegate = nil;
    }
    
    [super dealloc];
}

- (void)interstitalFail{
    if (!isFail&&!isClosed) {
        isFail = YES;
        [interstitial adapter:self didFailAd:nil];
    }
}


- (BOOL)isReadyPresentInterstitial{
    return isReady;
}

- (void)presentInterstitial{

//    BOOL showstatus=[self.pbInterstitial showInterstitialWithScale:0.9f];
//    UIViewController* viewController = [self puchBoxBaseViewController];
//    
//    if (!showstatus) {
//        [self.pbInterstitial showInterstitialOnRootView:viewController.view withScale:0.9f];
//    }
    
    
    [pbSingleton showInterstitialWithScale:0.9f];
    
    
}


- (UIViewController *)puchBoxBaseViewController{
    
    UIViewController *viewController=[UIApplication sharedApplication].keyWindow.rootViewController;
    if (!viewController ) {
        viewController = [self.adMoGoInterstitialDelegate viewControllerForPresentingInterstitialModalView];

    }
    return viewController;
}


#pragma mark -
#pragma mark PBInterstitialSingletonDelegate method

// 弹出广告加载完成
- (void)pbInterstitialDidLoadAd:(PBInterstitial *)pbInterstitial{
    if (isReady) {
        return;
    }
    isReady = YES;
    [self stopTimer];
    if (!isClosed) {
        [interstitial adapter:self didReceiveInterstitialScreenAd:nil];
    }
}

// 弹出广告加载错误
- (void)pbInterstitial:(PBInterstitial *)pbInterstitial
loadAdFailureWithError:(PBRequestError *)requestError{
    
    if (isFail) {
        return;
    }
    
    [self stopTimer];
    [self interstitalFail];
}

// 弹出广告打开完成
- (void)pbInterstitialDidPresentScreen:(PBInterstitial *)pbInterstitial{
    
}

// 弹出广告将要关闭
- (void)pbInterstitialWillDismissScreen:(PBInterstitial *)pbInterstitial{

}

// 弹出广告关闭完成
- (void)pbInterstitialDidDismissScreen:(PBInterstitial *)pbInterstitial{
    if (!isClosed) {
        isClosed = YES;
        [self performSelectorOnMainThread:@selector(dismissInterstitial:) withObject:pbInterstitial waitUntilDone:NO];
    }
    
}

- (void)dismissInterstitial:(PBInterstitial *)pbInterstitial{
    [interstitial adapter:self didDismissScreen:pbInterstitial];
}
@end
