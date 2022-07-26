//
//  ViewController.m
//  HLSliderView
//
//  Created by JJB_iOS on 2022/7/25.
//

#import "ViewController.h"
#import "HLSliderView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HLSliderView *sliderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

#pragma mark - Private Method

- (void)setupSubviews
{
    // 模拟需服务端验证逻辑
    __weak typeof(self) weakSelf = self;
    self.sliderView.sliderEndBlock = ^(){
        NSLog(@"拖到最后啦～～");
        
        // TODO 到服务端验证
        // [weakSelf checkApi];
        
        // 模拟服务端验证成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.sliderView setSliderState:HLSliderViewStateFinish];
        });
    };
    
    // 模拟滑动成功，再让服务端验证
    HLSliderView *sliderView2 = [[HLSliderView alloc] initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 40, 44)];
    sliderView2.minimumTrackColor = [UIColor systemPinkColor];
    sliderView2.isNeedLoadingView = NO;
    sliderView2.sliderEndBlock = ^(){
        NSLog(@"拖到最后啦～～");
        // TODO 到服务端验证
    };
    [self.view addSubview:sliderView2];
}

#pragma mark - Response Event

- (IBAction)resetAction:(UIButton *)sender {
    [self.sliderView setSliderState:HLSliderViewStateNormal animation:YES completion:nil];
}

@end
