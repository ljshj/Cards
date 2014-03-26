
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

- (void)loadFromJSONFile:(NSString*)strFile;
- (void)writeToJSONFile:(NSString*)strFile content:(NSString*)content;

- (void)DoGetRequestURL:(NSString*)strUrl parent:(UIViewController*)parent delegate:(id<HTTPURLConnectionDelegate>)delegate;
- (void)DoPostRequestURL:(NSString*)strUrl parent:(UIViewController*)parent params:(NSDictionary*)params delegate:(id<HTTPURLConnectionDelegate>)delegate;

- (BOOL)isValidDictionary:(NSObject*)obj;
- (BOOL)isValidNSArray:(NSObject*)obj;

@end
