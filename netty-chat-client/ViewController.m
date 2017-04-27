#import "ViewController.h"
#import "DFNettyChatClient.h"
#import "DataPackage.h"


@interface ViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *input;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)dealloc
{
    
    NSLog(@"controller dealloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kkk" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"STATUS" object:nil];
}


- (void)viewDidLoad {
    
    
    
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 50)];
    [self.view addSubview:_label];
    _label.backgroundColor =[UIColor redColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kkk:) name:@"kkk" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChange:) name:@"STATUS" object:nil];
    
    
    _input =[[UITextField alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 50)];
    _input.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:_input];
    
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, 80, 40)];
    [_button setTitle:@"send" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor =[UIColor darkGrayColor];
    [self.view addSubview:_button];
    
    
    
}

-(void) send:(id)sender
{
    NSString *msg = _input.text;
    if (msg == nil) {
        msg = @"hello";
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:msg forKey:@"msg"];
    
    NSData *content = [[self dataTOjsonString:dic] dataUsingEncoding:NSUTF8StringEncoding];
    
    DataPackage *msgPkg = [DataPackage simpleMsgPackage];
    msgPkg.content = content;
//    NSLog(@"sizeof msg = %ld", content.length);

    [[DFNettyChatClient sharedInstance] write:[DataPackage encode:msgPkg]];
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



-(void) kkk:(NSNotification*) notification
{
    _label.text = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
}


-(void) statusChange:(NSNotification*) notification
{
    NSInteger status = [[[notification userInfo] objectForKey:@"status"] integerValue];
    
    switch (status) {
            
        case CLOSED:
            self.title = @"";
            break;
        case CONNECTING:
            self.title = @"Connecting...";
            break;
        case CLOSING:
            self.title = @"Closing...";
            break;
        case RUNNING:
            self.title = @"Running";
            break;
        default:
            break;
    }
    
}

-(void) kkk11:(NSNotification*) notification
{
    _label.text = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

-(void) update
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kkk11" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
