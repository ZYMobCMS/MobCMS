//
//  BAFNetWorkHelper.m
//  OPinion
//
//  Created by ZYVincent on 12-7-19.
//  Copyright (c) 2012年 __barfoo__. All rights reserved.
//

#import "BFNetWorkHelper.h"
#import "NSDictionary+UrlEncodedString.h"
#import "NSString+UrlCombine.h"
#import "CJSONDeserializer.h"
#import "ZYGlobalConfig.h"

static BFNetWorkHelper *_instance = nil;

@interface BFNetWorkHelper(PrivateMethod)
- (void)requestDone:(ASIFormDataRequest *)request;
- (void)requestWentFaild:(ASIFormDataRequest *)request;

@end

@implementation BFNetWorkHelper
@synthesize requestTimeoutInterval;

+ (BFNetWorkHelper *)shareHelper
{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc]init];
        }
    }
    return _instance;
}

#pragma mark - life cycle
- (id)init{
    self = [super init];
    if (self) {
        self.requestTimeoutInterval = 20;
        _connectionsForCallBackDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}
- (void)dealloc{
    
    [_connectionsForCallBackDict release];
    [super dealloc];
}

- (void)alertWithErrorCode:(NSInteger)errorCode
{
    NSString *errorMessage = nil;
    switch (errorCode) {
        case NSURLErrorBadURL:
            errorMessage = @"网络地址无效";
            break;
        case NSURLErrorCannotConnectToHost:
            errorMessage = @"服务器没有响应";
            break;
        case NSURLErrorCannotFindHost:
            errorMessage = @"无法找到指定主机";
            break;
        case NSURLErrorCannotParseResponse:
            errorMessage = @"无法解析回复";
            break;
        case NSURLErrorBadServerResponse:
            errorMessage = @"错误得服务器返回";
            break;
            
        default:
            errorMessage = nil;
            break;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络错误" message:errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

//合成请求接口地址
- (NSURL *)urlWithRequestType:(ZYCMSRequestType)requestType
{
    NSURL *requestUrl = nil;
    
    //合成接口地址
    NSString *urlString = nil;
    switch (requestType) {
            
            case ZYCMSRequestTypeAbout:
            urlString = ZYCMS_About_Interface;
            break;
            
            case ZYCMSRequestTypeArticleComment:
            urlString = ZYCMS_Article_Comment_Interface;
            break;
            
            case ZYCMSRequestTypeProductList:
            urlString = ZYCMS_Product_List_Interface;
            break;
            
            case ZYCMSRequestTypeArticleDetail:
            urlString = ZYCMS_Article_Detail_Interface;
            break;
            
            case ZYCMSRequestTypeCommentArticle:
            urlString = ZYCMS_Comment_Article_Interface;
            break;
            
            case ZYCMSRequestTypeFavoriteArticle:
            urlString = ZYCMS_Favorite_Article_Interface;
            break;
            
            case ZYCMSRequestTypeLogin:
            urlString = ZYCMS_Login_Interface;
            break;
            
            case ZYCMSRequestTypeMenuList:
            urlString = ZYCMS_Menu_List_Interface;
            break;
            
            case ZYCMSRequestTypeNewsList:
            urlString = ZYCMS_News_List_Interface;
            break;
            
            case ZYCMSRequestTypePictureList:
            urlString = ZYCMS_Picture_Interface;
            break;
            
            case ZYCMSRequestTypeProductDetail:
            urlString = ZYCMS_Product_Detail_Interface;
            break;
            
            case ZYCMSRequestTypeReply:
            urlString = ZYCMS_Reply_Interface;
            break;
            
            case ZYCMSRequestTypeRigist:
            urlString = ZYCMS_Rigist_Interface;
            break;
            
            case ZYCMSRequestTypeTabType:
            urlString = ZYCMS_Tab_Type_Interface;
            break;
            
            case ZYCMSRequestTypeUserComment:
            urlString = ZYCMS_User_Comment_Interface;
            break;
            
            case ZYCMSRequestTypeUserFavorite:
            urlString = ZYCMS_User_Favorite_Interface;
            break;
            
            case ZYCMSRequestTypeHotCommentList:
            urlString = ZYCMS_Hot_Comment_Interface;
            break;
            
            case ZYCMSRequestTypeApplicationName:
            urlString = ZYCMS_Menu_Application_Name_Interface;
            break;
            
            case ZYCMSRequestTypeSupportComment:
            urlString = ZYCMS_Supprot_Comment_Interface;
            break;
            
            case ZYCMSRequestTypeUnSupportComment:
            urlString = ZYCMS_UnSupport_Comment_Interface;
            break;
            
            case ZYCMSRequestTypeCancelFavoritePicture:
            urlString = ZYCMS_Cancel_Favorite_Picture_Interface;
            break;
            
            case ZYCMSRequestTypeCancelFavoriteProduct:
            urlString = ZYCMS_Cancel_Favorite_Product_Interface;
            break;
            
            case ZYCMSRequestTypeCommentPicture:
            urlString = ZYCMS_Comment_Picture_Interface;
            break;
            
            case ZYCMSRequestTypeCommentProduct:
            urlString = ZYCMS_Comment_Product_Interface;
            break;
            
            case ZYCMSRequestTypeFavoritePicture:
            urlString = ZYCMS_Favorite_Picture_Interface;
            break;
            
            case ZYCMSRequestTypeFavoriteProduct:
            urlString = ZYCMS_Favorite_Product_Interface;
            break;
            
            case ZYCMSRequestTypePictureCommentList:
            urlString = ZYCMS_Picture_Comment_List_Interface;
            break;
            
            case ZYCMSRequestTypeProductCommentList:
            urlString = ZYCMS_Product_Comment_List_Interface;
            break;
            
            case ZYCMSRequestTypeIsFavoritePicture:
            urlString = ZYCMS_Is_Favorite_Picture_Interface;
            break;
            
            case ZYCMSRequestTypeIsFavoriteProduct:
            urlString = ZYCMS_Is_Favorite_Product_Interface;
            break;
            
            case ZYCMSRequestTypeUserPictureCommentList:
            urlString = ZYCMS_User_Picture_Comment_Interface;
            break;
            
            case ZYCMSRequestTypeUserProductCommentList:
            urlString = ZYCMS_User_Product_Comment_Interface;
            break;
            
            case ZYCMSRequestTypePictureCommentSupport:
            urlString = ZYCMS_Picture_Comment_Support_Interface;
            break;
            
            case ZYCMSRequestTypePictureCommentUnSupport:
            urlString = ZYCMS_Picture_Comment_unSupport_Interface;
            break;
            
            case ZYCMSRequestTypeProductCommentSupport:
            urlString = ZYCMS_Product_Comment_Support_Interface;
            break;
            
            case ZYCMSRequestTypeProductCommentUnSupport:
            urlString = ZYCMS_Product_Comment_unSupport_Interface;
            break;
            
            case ZYCMSRequestTypeCancelFavoriteArticle:
            urlString = ZYCMS_Cancel_Favorite_Article_Interface;
            break;
            
            case ZYCMSRequestTypePictureDetail:
            urlString = ZYCMS_Picture_Detail_Interface;
            break;
            
            case ZYCMSRequestTypePictureTabTypes:
            urlString = ZYCMS_Picture_Tab_Type_Interface;
            break;
            
            case ZYCMSRequestTypeProductTabTypes:
            urlString = ZYCMS_Product_Tab_Type_Interface;
            break;
            
            case ZYCMSRequestTypeUserSaveDeivceToken:
            urlString = ZYCMS_User_Commit_Token_Interface;
            break;
            
            case ZYCMSRequestTypeUserPictureFavoriteList:
            urlString = ZYCMS_User_Picture_Favorite_List_Interface;
            break;
            
            case ZYCMSRequestTypeUserProductFavoriteList:
            urlString = ZYCMS_User_Product_Favorite_List_Interface;
            break;
            
            case ZYCMSRequestTypeUserPublicHome:
            urlString = ZYCMS_User_Pulic_Home_Interface;
            break;
            
            case ZYCMSRequestTypeUserLoginOut:
            urlString = ZYCMS_User_Login_Out_Interface;
            break;
            
            case ZYCMSRequestTypeUserShareRecord:
            urlString = ZYCMS_User_Share_Record_Interface;
            break;
            
        default:
            break;
    }
    requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ZYCMS_Base_Url,urlString]];
    
    return requestUrl;
}


- (NSString *)pulicParams
{
    NSMutableString *turl = [NSMutableString stringWithCapacity:50];
    [turl appendFormat:@"&appId=%@&userId=%@&userActiveOpen=%d",APPID,[ZYUserManager getCurrentUserId],[ZYUserManager getUserActiveRecordState]];
    return turl;//[[Passport getCurrentUser]urlEncodedString];
}


#pragma mark - request method
//符合当前Opinion得请求类型
- (NSString*)requestDataWithApplicationType:(ZYCMSRequestType)requestType withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString *)successMethod withFaildRequestMethod:(NSString *)faildMethod
{
    
    //是否需要读取缓存
    if ([[params allKeys]containsObject:@"pageIndex"]) {
        if (![[ZYCacheCenter shareCenter]isRequestTypeNeedRefreshData:requestType withConfig:params]) {
            NSDictionary *cacheDict = [[ZYCacheCenter shareCenter]readCacheDictWithRequestType:requestType withConfig:nil];
            
            if (cacheDict) {
                [CallBackDelegate performSelector:NSSelectorFromString(successMethod) withObject:cacheDict];
                
                return nil;
            }
        }
    }

    //如果没有链接网络
    if (![BFNetWorkChecker isConnectedToNetWork]) {
        
        if ([[params allKeys]containsObject:@"pageIndex"]) {
            //是否需要读取缓存
            if ([[ZYCacheCenter shareCenter]isRequestTypeCacheDataExist:requestType withConfig:params]) {
                NSDictionary *cacheDict = [[ZYCacheCenter shareCenter]readCacheDictWithRequestType:requestType withConfig:nil];
                
                if (cacheDict) {
                    [CallBackDelegate performSelector:NSSelectorFromString(successMethod) withObject:cacheDict];
                    
                    return nil;
                }else{
                    [CallBackDelegate performSelector:NSSelectorFromString(faildMethod) withObject:@"noNetwork" afterDelay:0.0f ];
                    return nil;
                }
            }else{
                [CallBackDelegate performSelector:NSSelectorFromString(faildMethod) withObject:@"noNetwork" afterDelay:0.0f ];
                
                return nil;
            }
        }else{
            [CallBackDelegate performSelector:NSSelectorFromString(faildMethod) withObject:@"noNetwork" afterDelay:0.0f ];
            
            return nil;
        }
        
    
    }
    
    //build URL with Requestion type
    NSURL *requestUrl = nil;
    //get url
    requestUrl = [self urlWithRequestType:requestType];
    
    //use url with function :RequestionMethod 
    //接收callbackDelegate 和 成功调用方法 失败调用方法
    NSMutableDictionary *callBackDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:CallBackDelegate,@"delegate",successMethod,@"success",faildMethod,@"faild",params,@"params", nil];
    
    //处理params
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *finalUrl = nil;
    //没有参数时附加公共参数
    NSString *string = paramDict ? [paramDict urlEncodedString] : @"";//编码成http页面能够接受得参数
    
    finalUrl = [NSString stringWithFormat:@"%@%@&%@", [requestUrl absoluteString], [self pulicParams], string];
    NSLog(@"final Url --->%@",finalUrl);

    
    
    //生成正确得请求地址
    requestUrl = [NSURL URLWithString:finalUrl];
    //设置请求参数
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestUrl];
    //https
    [request setValidatesSecureCertificate:NO];
    
    request.timeOutSeconds = self.requestTimeoutInterval;
    request.RequestType = requestType;
    //需要缓存第一页
    if ([[paramDict allKeys]containsObject:@"pageIndex"] && [[paramDict objectForKey:@"pageIndex"]intValue]==1) {
        request.requestPageIndex = 1;
    }
    request.requestFlagMark = [self getTimeStamp];
    request.responseEncoding = NSUTF8StringEncoding;
    [_connectionsForCallBackDict setObject:callBackDict forKey:request.requestFlagMark];
    
    request.delegate = self;
    [request setDidFailSelector:@selector(requestWentFaild:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];
    
    return request.requestFlagMark;
}

#pragma mark -
#pragma mark requestMethod

//请求数据
- (void)requestDataFromURL:(NSString *)url withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString*)successMethod withFaildRequestMethod:(NSString*)faildMethod
{
    //check if there have network
    if(![BFNetWorkChecker isConnectedToNetWork])
    {
        [SVProgressHUD showErrorWithStatus:@"没有网络链接"];
        return;
    }
    
    //接收callbackDelegate 和 成功调用方法 失败调用方法
    NSMutableDictionary *callBackDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:CallBackDelegate,@"delegate",successMethod,@"success",faildMethod,@"faild", nil];
    
    NSDictionary *paramDict = params;
    NSMutableData *paramData = [NSMutableData data];
    NSMutableString *paramString = [NSMutableString string];
    //处理params
    if (nil == params) {
        
    }else{
        
        for (id key in [paramDict keyEnumerator]) {
            NSString *string = [NSString stringWithFormat:@"\"%@\":\"%@,",key,[params valueForKey:key]];
            [paramString appendString:string];
            
        }
        [paramData appendData:[[NSString stringWithFormat:@"{%@",paramString] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    //设置请求参数
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeOutSeconds = self.requestTimeoutInterval;
    request.RequestType = 8888;
    request.requestFlagMark = [self getTimeStamp];
    request.responseEncoding = NSUTF8StringEncoding;
    [_connectionsForCallBackDict setObject:callBackDict forKey:request.requestFlagMark];
    
    
    request.delegate = self;
    [request setDidFailSelector:@selector(requestWentFaild:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];
}

#pragma mark - request method
- (void)requestDone:(ASIFormDataRequest *)request
{
    NSData *data = [request responseData];
    NSDictionary *result = [[CJSONDeserializer deserializer]deserialize:data error:nil];
    
    NSDictionary *targetCallBack = [_connectionsForCallBackDict objectForKey:request.requestFlagMark];
    [[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"success"]) withObject:result];

    //缓存
    NSDictionary *params = [targetCallBack objectForKey:@"params"];
    if ([[params allKeys]containsObject:@"pageIndex"]) {
        if ([[ZYCacheCenter shareCenter] isRequestTypeNeedRefreshData:request.RequestType withConfig:params]) {
            
            if ([[result objectForKey:@"status"]boolValue]) {
                
                [[ZYCacheCenter shareCenter]cacheDataWithRequestType:request.RequestType withDict:result withConfig:params];
                
            }
        }
    }
    
    
	[_connectionsForCallBackDict removeObjectForKey:request.requestFlagMark];
    
    //隐藏网络请求提示
    if ([[_connectionsForCallBackDict allKeys]count]==0) {
        
        [ASIHTTPRequest hideNetworkActivityIndicator];
    }
}

- (void)requestWentFaild:(ASIFormDataRequest *)request
{
    NSDictionary *targetCallBack = [_connectionsForCallBackDict objectForKey:request.requestFlagMark];
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
    NSString *tips = @"connection error";
    //check if there have network
//    if(![BFNetWorkChecker isConnectedToNetWork])
//    {
//        tips = nil;
//    }
	[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"faild"]) withObject:tips];
	[_connectionsForCallBackDict removeObjectForKey:request.requestFlagMark];
}

-(NSString *)getTimeStamp{
	NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
	return [NSString stringWithFormat:@"%u",timestamp];
}

//退出某个请求
- (void)cancelRequestWithTimeStamp:(NSString *)timeStamp
{
    //如果时间戳是空得,什么都不做
    if (timeStamp==nil) {
        return;
    }
        
    //如果链接已经完成了
    if (![[_connectionsForCallBackDict allKeys]containsObject:timeStamp]) {
        return;
    }
    
    NSDictionary *callBackDict = [_connectionsForCallBackDict objectForKey:timeStamp];
    
    //如果链接没有完成还存在
    if (callBackDict) {
        
        ASIHTTPRequest *request = [callBackDict objectForKey:timeStamp];
        
        //退出请求
        [request clearDelegatesAndCancel];
        
        NSLog(@"finish cancel request by timeStamp ++++>>>>>>> :%@",timeStamp);
        
        [_connectionsForCallBackDict removeObjectForKey:timeStamp];
        
    }
}


@end
