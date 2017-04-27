#import "DFNettyChatClient.h"
#import "DataPackage.h"

@implementation DFNettyChatClient

static DFNettyChatClient *_client=nil;

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_client == nil) {
            _client = [[DFNettyChatClient alloc] init];
        }
    }
    return _client;
}

-(NSData *) getHeartbeatData
{
    DataPackage *pkg = [DataPackage simpleMsgPackage];
    NSData *content = nil;
    pkg.content = content;
    return [DataPackage encode:pkg];
}

-(NSString*)dataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


@end
