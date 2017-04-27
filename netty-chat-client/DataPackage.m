#import "DataPackage.h"

static const NSUInteger TOATAL_SIZE_FIELD_LENGTH = 4;
static const NSUInteger HEADER_LENGTH = 0;

static DataPackage * _heartbeatPackage;
static DataPackage * _loginPackage;

@implementation DataPackage


- (instancetype)initWithContent: (NSData *) content
{
    self = [super init];
    if (self) {
    
        self.content = content;
    }
    return self;
}



//+(DataPackage *) heartbeatPackage
//{
//    if (_heartbeatPackage == nil) {
//        NSData *data = [NSData dataWithBytes: TYPE_HEARTBEAT length:TYPE_FIELD_LENGTH];
//        _heartbeatPackage = [[DataPackage alloc] initWithContent:<#(NSData *)#>data];
//    }
//    
//    return  _heartbeatPackage;
//}
//


+(DataPackage *) simpleMsgPackage
{
    DataPackage *pkg = [[DataPackage alloc] initWithContent:nil];
    return  pkg;
}


+(NSData *) encode:(DataPackage *) pkg
{
    NSMutableData *data = [NSMutableData data];
    
    NSUInteger size = HEADER_LENGTH;
    if (pkg.content!=nil) {
        size += [pkg.content length];
    }
    uint32_t theInt = htonl((uint32_t)size);
    [data appendBytes:&theInt length:TOATAL_SIZE_FIELD_LENGTH];
    
    if (pkg.content != nil) {
        [data appendData:pkg.content];
    }
    
    return data;
}



@end
