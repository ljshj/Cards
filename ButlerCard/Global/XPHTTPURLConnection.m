
#import "XPHTTPURLConnection.h"
#import "AFNetworking.h"
#import "SBJson4.h"

static const int SyncGetTimeOutSeconds = 30;
static const int AsyncGetTimeOutSeconds = 30;
static const int SyncPostTimeOutSeconds = 30;
static const int ASyncPostTimeOutSeconds = 30;

@interface XPHTTPURLConnection ()
- (BOOL)isValidHeader:(NSString*)response;
- (void)processResponse:(NSData*)data;
- (void)processErrorInfo:(int)errorType;
@end

@implementation XPHTTPURLConnection
@synthesize netActionType;
@synthesize responseString;

#pragma mark 
#pragma mark - init and dealloc
- (id)init
{
    if (self = [super init])
    {
        self.responseString = nil;
        mdelegate = nil;
        self.netActionType = TYPE_NULL;
    }
    return self;
}

#pragma mark - 
- (BOOL)isValidHeader:(NSString*)response
{
    return YES;
}

- (void)processErrorInfo:(int)errorType
{
    NSString *errInfo = nil;
    switch (errorType)
    {
        case 0:
            errInfo = @"网络连接超时, 请检查网络连接";
            break;
        case 1:
            errInfo = @"数据返回格式错误";
            break;
        default:
            break;
    }
    if(mdelegate != nil)[mdelegate ProcessRequestError:errInfo];
}

- (void)processResponse:(NSData*)data
{
    NSStringEncoding strEncode =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSString *tempString = nil;
    tempString = [[NSString alloc] initWithData:data encoding:strEncode];
    if(!tempString || ![self isValidHeader:tempString])
    {
        [self processErrorInfo:1];
        return;
    }
    self.responseString = tempString;
    
    SBJson4ValueBlock block = ^(id v, BOOL *stop) {
        if(![self isValidDictionary:v])
        {
            [self processErrorInfo:1];
            return;
        }
        
        if(mdelegate != nil)[mdelegate ProcessRequestOK:(NSDictionary*)v];
    };
    SBJson4ErrorBlock eh = ^(NSError* err) {
        [self processErrorInfo:1];
    };
    
    id parser = [SBJson4Parser parserWithBlock:block allowMultiRoot:YES unwrapRootArray:YES errorHandler:eh];
    [parser parse:data];
}

#pragma mark get methods
- (void)DoGetRequestURL:(NSString*)strUrl parent:(UIViewController*)parent delegate:(id<HTTPURLConnectionDelegate>)delegate
{
    mdelegate = delegate;
    mProgressHUD = [[MBProgressHUD alloc] initWithView:parent.view];
	[parent.view addSubview:mProgressHUD];
	mProgressHUD.delegate = nil;
	mProgressHUD.labelText = @"正在请求数据...";
	//mProgressHUD.detailsLabelText = @"updating data";
	mProgressHUD.square = YES;
	[mProgressHUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processErrorInfo:0];
    }];
}

- (void)DoPostRequestURL:(NSString*)strUrl parent:(UIViewController*)parent params:(NSDictionary*)params delegate:(id<HTTPURLConnectionDelegate>)delegate
{
    mdelegate = delegate;
    mProgressHUD = [[MBProgressHUD alloc] initWithView:parent.view];
	[parent.view addSubview:mProgressHUD];
	mProgressHUD.delegate = nil;
	mProgressHUD.labelText = @"Loading";
	mProgressHUD.square = YES;
	[mProgressHUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:strUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //[formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processErrorInfo:0];
    }];
}

#pragma mark get from local file
- (void)loadFromJSONFile:(NSString*)strFile
{
    NSString* file = strFile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];//去处需要的路径//[[NSBundle mainBundle] bundlePath];
	NSString* finalPath = [path stringByAppendingPathComponent:file];
    NSString* fileData = [NSString stringWithContentsOfFile:finalPath encoding:NSUTF8StringEncoding error:nil];
    
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSString *textFile  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self setResponseString:fileData];
    if(mdelegate != nil)[mdelegate ProcessRequestOK:self.responseString];
}

- (void)writeToJSONFile:(NSString*)strFile content:(NSString*)content
{
    NSString* file = strFile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];//去处需要的路径//[[NSBundle mainBundle] bundlePath];
	NSString* finalPath = [path stringByAppendingPathComponent:file];

    NSError *error = nil;
    [content writeToFile:finalPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error != nil)NSLog(@"write to file error,info:%@", error.localizedDescription);
}

#pragma mark - extra event
- (BOOL)isValidDictionary:(NSObject*)obj
{
    if(obj == nil)
        return NO;
    
    if([obj isKindOfClass:[NSArray class]])
        return YES;
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)obj;
        if([dict count]<=0)
        {
            return NO;
        }
        return YES;
    }
    
    return YES;
}
- (BOOL)isValidNSArray:(NSObject*)obj
{
    if(obj == nil)
        return NO;
    
    if(![obj isKindOfClass:[NSArray class]])
        return NO;
    
    //if( [(NSArray*)obj count] > 0)
    //    return YES;
    
    return YES;
}

@end
