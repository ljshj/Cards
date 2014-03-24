
#import <Foundation/Foundation.h>

@class ASIHTTPRequest;
@class ASIFormDataRequest;

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
	ASIHTTPRequest*		connection;
    ASIFormDataRequest* formRequest;
    BOOL misGetMode;
    id<HTTPURLConnectionDelegate> mdelegate;
}

@property (nonatomic, assign) enum NetActionType netActionType;
@property (nonatomic, copy) NSString *responseString;

- (int)getLocalJsonFileVersion:(NSString*)strFile;
- (BOOL)isJSONFileEmpty:(NSString*)strFile;
- (void)loadFromJSONFile:(NSString*)strFile;
- (void)writeToJSONFile:(NSString*)strFile content:(NSString*)content;

- (void)DoGetRequestURL:(NSString*)strUrl bsyn:(BOOL)bsyn delegate:(id<HTTPURLConnectionDelegate>)delegate;
- (void)DoPostRequestURL:(NSString*)strUrl bsyn:(BOOL)bsyn data:(id)data params:(NSArray*)params delegate:(id<HTTPURLConnectionDelegate>)delegate;
- (void)cancel;

- (BOOL)isValidDictionary:(NSObject*)obj;
- (BOOL)isValidNSArray:(NSObject*)obj;

@end
