
#import <Foundation/Foundation.h>


@interface DataPackage : NSObject

@property (nonatomic,assign) NSInteger size;
@property (nonatomic,strong) NSData *content;

+(DataPackage *) simpleMsgPackage;

+(NSData *) encode:(DataPackage *) pkg;

- (instancetype)initWithContent:(NSData *)content;
@end
