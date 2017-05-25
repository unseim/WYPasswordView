//
//  WYPasswordView
//  WYKit
//  简书地址：http://www.jianshu.com/u/8f8143fbe7e4
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "ViewController.h"
#import "WYPasswordView.h"

/** 整个屏幕宽 */
#define KScreenWidth             [UIScreen mainScreen].bounds.size.width
/** 整个屏幕高 */
#define KScreenHeight            [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) WYPasswordView *passwordView;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation ViewController

static BOOL flag = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.payButton = ({
        UIButton *pay = [UIButton buttonWithType:UIButtonTypeCustom];
        pay.frame = CGRectMake(0, KScreenHeight-50, KScreenWidth, 50);
        [pay setTitle:@"支付" forState:UIControlStateNormal];
        [pay setBackgroundColor:[UIColor redColor]];
        [pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [pay addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pay];
        pay;
    });
    
    
}



- (void)payClick:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;
    
    self.passwordView = [[WYPasswordView alloc] init];
    self.passwordView.title = @"输入交易密码";
    self.passwordView.loadingText = @"提交中...";
    [self.passwordView showInView];
    
    self.passwordView.finish = ^(NSString *password) {
        [weakSelf.passwordView hideKeyboard];
        [weakSelf.passwordView startLoading];
        
        NSLog(@"Password  =  %@", password);
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            flag = !flag;
            
            if (flag) {
                NSLog(@"申购成功，跳转到成功页");
                
                [weakSelf.passwordView requestComplete:YES message:@"支付成功，做一些处理"];
                [weakSelf.passwordView stopLoading];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.passwordView hide];
                });
                
                
            } else {
                NSLog(@"申购失败，跳转到失败页");
                
                [weakSelf.passwordView requestComplete:NO message:@"支付失败，做一些处理"];
                [weakSelf.passwordView stopLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.passwordView hide];
                });
                
            }
            
        });
        
        
        
    };
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
