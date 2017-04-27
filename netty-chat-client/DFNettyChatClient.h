//
//  DFNettyChatClient.h
//  netty-chat-client
//
//  Created by Allen Zhong on 15/3/18.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NettyCommonClient.h"

@interface DFNettyChatClient : NettyCommonClient



+(instancetype) sharedInstance;

@end
