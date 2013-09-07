//
//  BAFNetWorkHelper.h
//  OPinion
//
//  Created by ZYVincent on 12-7-19.
//  Copyright (c) 2012年 __barfoo__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NetWorkConst.h"
#import "BFNetWorkChecker.h"

typedef enum {
    
    ZYCacheDataArticle = 0,
    ZYCacheDataPicture,
    ZYCacheDataProduct,
    
}ZYCacheDataType;

typedef enum {
    ZYCMSRequestTypeLogin = 0,
    ZYCMSRequestTypeRigist,
    ZYCMSRequestTypeMenuList,
    ZYCMSRequestTypeTabType,
    ZYCMSRequestTypeNewsList,
    ZYCMSRequestTypeArticleDetail,
    ZYCMSRequestTypeArticleComment,
    ZYCMSRequestTypeCommentArticle,
    ZYCMSRequestTypeFavoriteArticle,
    ZYCMSRequestTypeCancelFavoriteArticle,
    ZYCMSRequestTypePictureList,
    ZYCMSRequestTypeProductList,
    ZYCMSRequestTypeProductDetail,
    ZYCMSRequestTypeHotCommentList,
    ZYCMSRequestTypeAbout,
    ZYCMSRequestTypeReply,
    ZYCMSRequestTypeUserFavorite,
    ZYCMSRequestTypeUserComment,
    ZYCMSRequestTypeApplicationName,
    ZYCMSRequestTypeSupportComment,
    ZYCMSRequestTypeUnSupportComment,
    ZYCMSRequestTypeFavoritePicture,
    ZYCMSRequestTypeCancelFavoritePicture,
    ZYCMSRequestTypePictureCommentList,
    ZYCMSRequestTypeCommentPicture,
    ZYCMSRequestTypeFavoriteProduct,
    ZYCMSRequestTypeCancelFavoriteProduct,
    ZYCMSRequestTypeCommentProduct,
    ZYCMSRequestTypeProductCommentList,
    ZYCMSRequestTypeIsFavoritePicture,
    ZYCMSRequestTypeIsFavoriteProduct,
    ZYCMSRequestTypeUserPictureCommentList,
    ZYCMSRequestTypeUserProductCommentList,
    ZYCMSRequestTypePictureCommentSupport,
    ZYCMSRequestTypePictureCommentUnSupport,
    ZYCMSRequestTypeProductCommentSupport,
    ZYCMSRequestTypeProductCommentUnSupport,
    ZYCMSRequestTypePictureDetail,
    ZYCMSRequestTypePictureTabTypes,
    ZYCMSRequestTypeProductTabTypes,
    ZYCMSRequestTypeUserSaveDeivceToken,
    ZYCMSRequestTypeUserPictureFavoriteList,
    ZYCMSRequestTypeUserProductFavoriteList,
    ZYCMSRequestTypeUserPublicHome,
    ZYCMSRequestTypeUserLoginOut,
    ZYCMSRequestTypeUserShareRecord,
    
}ZYCMSRequestType;

@interface BFNetWorkHelper : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>
{
@private    
    NSTimeInterval requestTimeoutInterval;
    
    NSMutableDictionary *_connectionsForCallBackDict;
    
}
@property (nonatomic)NSTimeInterval requestTimeoutInterval;

+ (BFNetWorkHelper *)shareHelper;

- (NSString *)getTimeStamp;

- (void)cancelRequestWithTimeStamp:(NSString*)timeStamp;

//为特定应用程序请求数据
- (NSString*)requestDataWithApplicationType:(ZYCMSRequestType)requestType
                            withParams:(NSDictionary *)params 
                    withHelperDelegate:(id)CallBackDelegate 
              withSuccessRequestMethod:(NSString *)successMethod 
                withFaildRequestMethod:(NSString *)faildMethod;

//请求某个网络地址数据
- (void)requestDataFromURL:(NSString*)url 
                withParams:(NSDictionary*)params 
        withHelperDelegate:(id)CallBackDelegate 
  withSuccessRequestMethod:(NSString*)successMethod 
    withFaildRequestMethod:(NSString*)faildMethod;


@end
