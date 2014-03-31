
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

enum NetActionType
{
    TYPE_NULL = 0,
    TYPE_LOGIN,
    TYPE_REGISTE,
    TYPE_MODIFYPASS,
    TYPE_MODIFYCARDPASS,
    TYPE_CARDBINDING
};

@protocol HTTPURLConnectionDelegate <NSObject>

- (void)ProcessRequestOK:(id)response;
- (void)ProcessRequestError:(NSString*)response;

@end

@interface XPHTTPURLConnection : NSObject
{
    id<HTTPURLConnectionDelegate> mdelegate;
    MBProgressHUD *mProgressHUD;
}

@property (nonatomic, assign) enum NetActionType netActionType;
@property (nonatomic, copy) NSString *responseString;

//下面两个函数是存取文件的操作
- (NSString*)loadFromJSONFile:(NSString*)strFile;
- (void)writeToJSONFile:(NSString*)strFile content:(NSString*)content;

/******************************************************************
 下面两个函数是HTTP请求网络数据的两种方式Get和Post
 strUrl:请求的服务器接口地址的后缀
 parent:请求数据的页面，用于接收IndicatorView
 delegate:请求结果的回调
 *****************************************************************/
- (void)DoGetRequestURL:(NSString*)strUrl parent:(UIViewController*)parent delegate:(id<HTTPURLConnectionDelegate>)delegate;
- (void)DoPostRequestURL:(NSString*)strUrl parent:(UIViewController*)parent params:(NSDictionary*)params delegate:(id<HTTPURLConnectionDelegate>)delegate;

@end
