#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

typedef NS_ENUM(NSUInteger, CONNECTION_STATUS){
    RUNNING,CLOSED,CONNECTING,CLOSING,
};

#define HEARTBEAT_TIMEOUT_INTERVAL 60
#define HEARTBEAT_SEND_INTERVAL 5


@interface NettyCommonClient : NSObject <GCDAsyncSocketDelegate>

@property (nonatomic,assign) BOOL hasMarkedRead;
@property (nonatomic,assign) NSUInteger lastActiveTime;

@property (nonatomic,assign) NSInteger reConnectTimes;

@property (nonatomic,assign) CONNECTION_STATUS status;
@property (nonatomic,strong) GCDAsyncSocket *socket;

@property (nonatomic,strong) NSTimer *autoRestartTimer;
@property (nonatomic,strong) NSTimer *autoSendHeartbeatTimer;
@property (nonatomic,strong) NSTimer *heartbeatTimeoutCheckTimer;


-(void) start;
-(void) terminate;

-(void) write:(NSData *) data;

-(void) write:(NSData *) data tag:(NSUInteger) tag;


@end
