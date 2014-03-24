
#import "XPHTTPURLConnection.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSDictionaryAdditions.h"
#import "NSStringAdditions.h"

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
        misGetMode = YES;
        mdelegate = nil;
        self.netActionType = TYPE_NULL;
    }
    return self;
}

- (void)dealloc
{
	[self cancel];
    self.responseString = nil;
	[super dealloc];
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
    id retJSON = nil;
    NSStringEncoding strEncode =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSString *tempString = nil;
    tempString = [[NSString alloc] initWithData:data encoding:strEncode];
    if(!tempString || ![self isValidHeader:tempString])
    {
        [self processErrorInfo:1];
        return;
    }
    self.responseString = tempString;
    [tempString release];
    
    retJSON = [self.responseString JSONValue];
    if(![self isValidDictionary:retJSON])
    {
        [self processErrorInfo:1];
        return;
    }
    
    if(mdelegate != nil)[mdelegate ProcessRequestOK:(NSDictionary*)retJSON];
}

#pragma mark ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = nil;
    if(misGetMode)responseData = [connection responseData];
    else responseData = [formRequest responseData];
    
    [self processResponse:responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	[self processErrorInfo:0];
}

#pragma mark get methods
- (void)DoGetRequestURL:(NSString*)strUrl bsyn:(BOOL)bsyn delegate:(id<HTTPURLConnectionDelegate>)delegate
{
    mdelegate = delegate;
    NSString *utf8RUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [ NSURL URLWithString:utf8RUrl];
    
    misGetMode = YES;
    [self cancel];
    connection = [[ASIHTTPRequest alloc] initWithURL:url];
    if(bsyn)
    {
        [connection setTimeOutSeconds:SyncGetTimeOutSeconds];
        [connection setDelegate:nil];
        [connection startSynchronous];
    }
    else
    {
        [connection setTimeOutSeconds:AsyncGetTimeOutSeconds];
        [connection setDelegate:self];
        [connection setDidFinishSelector:@selector(requestFinished:)];
        [connection setDidFailSelector:@selector(requestFailed:)];
        [connection startAsynchronous];
        return;
    }
    
    NSError *error = [connection error];
    if(error)
    {
        [self processErrorInfo:0];
        return;
    }
    [self processResponse:[connection responseData]];
}

- (void)DoPostRequestURL:(NSString*)strUrl bsyn:(BOOL)bsyn data:(id)data params:(NSArray*)params delegate:(id<HTTPURLConnectionDelegate>)delegate
{
    NSString *utf8RUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [ NSURL URLWithString:utf8RUrl];
    
    misGetMode = NO;
    [self cancel];
    formRequest = [[ASIFormDataRequest alloc]initWithURL:url];
    for(NSDictionary* dict in params)
    {
        NSString* strKey = [dict valueForKey:@"key"];
        id idValue = [dict objectForKey:@"value"];
        [formRequest addPostValue:idValue forKey:strKey];
    }
    if(bsyn)
    {
        [formRequest setDelegate:nil];
        [formRequest setUseKeychainPersistence:YES];
        if(data != nil)[formRequest setData:data withFileName:@"postDefault.png" andContentType:@"image/png" forKey:@"file"];
        [formRequest setTimeOutSeconds:SyncPostTimeOutSeconds];
        [formRequest startSynchronous];
    }
    else
    {
        [formRequest setDelegate:self];
        [formRequest setUseKeychainPersistence:YES];
        if(data)[formRequest setData:data withFileName:@"postDefault.png" andContentType:@"image/png" forKey:@"file"];
        [formRequest setTimeOutSeconds:ASyncPostTimeOutSeconds];
        [formRequest startAsynchronous];
        return;
    }
    
    NSError *error = [formRequest error];
    if(error)
    {
        [self processErrorInfo:0];
        return;
    }
    [self processResponse:[formRequest responseData]];
}

#pragma mark get from local file
- (int)getLocalJsonFileVersion:(NSString*)strFile
{
    NSString* file = strFile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];//去处需要的路径//[[NSBundle mainBundle] bundlePath];
	NSString* finalPath = [path stringByAppendingPathComponent:file];
    NSString* fileData = [NSString stringWithContentsOfFile:finalPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary* dict = nil;
    
    if([NSString isEmptyOrWhitespace:fileData])return 0;
    if(![self isValidHeader:fileData])return 0;
    dict = [fileData JSONValue];
    if(![self isValidDictionary:dict])return 0;
    return [[dict getStringValueForKey:@"version" defaultValue:@"0"] intValue];
}

- (BOOL)isJSONFileEmpty:(NSString*)strFile
{
    NSString* file = strFile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];//去处需要的路径//[[NSBundle mainBundle] bundlePath];
	NSString* finalPath = [path stringByAppendingPathComponent:file];
    NSString* fileData = [NSString stringWithContentsOfFile:finalPath encoding:NSUTF8StringEncoding error:nil];

    return [NSString isEmptyOrWhitespace:fileData];
}

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
    if(mdelegate != nil)[mdelegate ProcessRequestOK:[self.responseString JSONValue]];
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

#pragma mark - cancel connect
- (void)cancel
{
    if (connection != nil)
    {
        [connection setDelegate:nil];
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (formRequest != nil)
    {
        [formRequest setDelegate:nil];
        [formRequest cancel];
        [formRequest release];
        formRequest = nil;
    }
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
