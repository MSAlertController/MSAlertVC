//
//  ViewController.m
//  MSAlertControllerDemo
//
//  Created by moses on 2017/5/5.
//  Copyright © 2017年 ANT. All rights reserved.
//

#import "ViewController.h"
#import "MSAlertController.h"

@interface ViewController ()

@property (nonatomic, strong, nullable) NSMutableArray *imageArr;
@property (nonatomic, strong, nullable) UIImageView *imageView;
@property (nonatomic, strong, nullable) NSArray *dataArray;
@property (nonatomic, strong, nullable) NSTimer *timer;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}
/** 为了能更好的体验MSAlertController的效果，我在微博保存了几张高清无码大图，在不增加Demo大小的前提下，我选择了网易博客😅把这几张图传到了博客，然后第一次打开demo的时候，会从网络获取到这几张图片，并缓存到沙盒里，这些代码和MSAlertController的使用并没有半毛钱的关系，可以选择直接忽略掉😆 */
- (void)saveImage:(void(^)())completion {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 266, 25);
    label.center = self.view.center;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"正在加载图片，图片较大，请稍等。。。";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.4];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 4;
    [self.view addSubview:label];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *urlArr = @[@"http://img0.ph.126.net/h4F4ErQLCPcI2-OtndZc6Q==/6632594987351227539.png",
                            @"http://img2.ph.126.net/4CDPPa9h_e-q4qaaisImIQ==/6632377284048891035.png",
                            @"http://img2.ph.126.net/JoQ_Du1J0cdnq7oV5qn8qg==/6632568599072158829.png",
                            @"http://img2.ph.126.net/1sYX-wGIapxlsHMeio-2rQ==/6632574096630290168.png",
                            @"http://img1.ph.126.net/XxoyGKbh09r3nvifRpuwdw==/6632423463537287248.png"];
        for (int i = 0; i < urlArr.count; i++) {
            NSURL *URL = [NSURL URLWithString:urlArr[i]];
            NSData *data = [NSData dataWithContentsOfURL:URL];
            UIImage *image = [UIImage imageWithData:data];
            [self.imageArr addObject:image];
            NSString *path = [NSString stringWithFormat:@"image%d.png", i];
            NSString *imagePath = [documentsPath stringByAppendingPathComponent:path];
            [fileManager createFileAtPath:imagePath contents:data attributes:nil];
        }
        completion();
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArr = [NSMutableArray array];
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *image4Path = [documentsPath stringByAppendingPathComponent:@"image4.png"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:image4Path]) {
        for (int i = 0; i < 5; i++) {
            NSString *path = [NSString stringWithFormat:@"image%d.png", i];
            NSString *imagePath = [documentsPath stringByAppendingPathComponent:path];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            [self.imageArr addObject:image];
        }
        [self initImageView];
    } else {
        [self saveImage:^{
            [self initImageView];
        }];
    }
}

- (void)initImageView {
    self.dataArray = @[@[@"发送给朋友", @"收藏", @"保存图片"] ,@[@"保存图片", @"转发微博", @"赞"]];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction)]];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = self.view.bounds;
    [self.view addSubview:self.imageView];
    self.imageView.image = self.imageArr[arc4random_uniform(5)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.imageView.image = self.imageArr[arc4random_uniform(5)];
    }];
}
#pragma mark - 此处为MSAlertController的使用方法
- (void)gestureAction {
    [self.timer setFireDate:[NSDate distantFuture]];
    NSInteger dex = arc4random_uniform(2);
    MSAlertController *alertVC = [MSAlertController alertControllerWithArray:self.dataArray[dex]];
    [alertVC addConfirmButtonAction:^(NSInteger index, BOOL cancle) {
        if (cancle) {
            NSLog(@"你点击了取消按钮");
            [self.timer setFireDate:[NSDate date]];
        } else {
            NSLog(@"你点击的是：%@", self.dataArray[dex][index]);
            if (index == 0) {
                [self unfollow];
            } else {
                [self.timer setFireDate:[NSDate date]];
            }
        }
    }];
    [self presentViewController:alertVC animated:NO completion:nil];
}

- (void)unfollow {
    MSAlertController *enterAlert = [MSAlertController alertControllerWithArray:@[@"不再关注"]];
    enterAlert.title = @"你确定不再关注邓紫棋了吗？你确定不再关注邓紫棋了吗？你确定不再关注邓紫棋了吗？重要的事情问三遍😁😁😁";
    [enterAlert setColor:[UIColor redColor] withIndex:0];
    [enterAlert addConfirmButtonAction:^(NSInteger index, BOOL cancle) {
        [self.timer setFireDate:[NSDate date]];
        if (cancle) {
            NSLog(@"你点击了取消按钮");
            return;
        }
        NSLog(@"果取关");
    }];
    [self presentViewController:enterAlert animated:NO completion:nil];
}

@end
