//
//  AdMoGoAdapterXingYunInterstitial.h
//  CTAdsMogoSample
//
//  Created by Chasel on 14-3-19.
//  Copyright (c) 2014年 Chasel. All rights reserved.
//

#import "AdMoGoAdNetworkAdapter.h"
#import <AdWalker/PobFrameWall.h>
@interface AdMoGoAdapterXingYunInterstitial : AdMoGoAdNetworkAdapter<PobFrameWallDelegate>
{
    BOOL isStop;
    NSTimer *timer;
    BOOL isLoaded;
    CGRect initAdChinaFrame;
}
@end
