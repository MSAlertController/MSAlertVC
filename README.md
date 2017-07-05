# MSAlertController

#### 一个高仿微博和微信的底部弹窗

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/MSAlertController/MSAlertVC/master/LICENSE)&nbsp;
[![CocoaPods](https://img.shields.io/cocoapods/v/MSAlertVC.svg?style=flat)](http://cocoapods.org/pods/MSAlertVC)&nbsp;
[![CocoaPods](https://img.shields.io/cocoapods/p/MSAlertVC.svg?style=flat)](http://cocoadocs.org/docsets/MSAlertVC)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

## 效果展示

MSAlertController                                           微信                                                       微博<br/>
<img src="https://raw.githubusercontent.com/MSAlertController/MSImages/master/MSAlertVC/0ms.PNG" width="250"><img src="https://raw.githubusercontent.com/MSAlertController/MSImages/master/MSAlertVC/0wx.PNG" width="250"><img src="https://raw.githubusercontent.com/MSAlertController/MSImages/master/MSAlertVC/0wb.PNG" width="250"><br/>
[更多效果展示图](https://github.com/MSAlertController/MSImages/tree/master/MSAlertVC)

## 系统要求

该项目最低支持`iOS 8.0`和`Xcode 7.0`。

## 安装

**注：为了支持CocoaPods安装，但是`MSAlertController`已被人抢占，不得已只能将CocoaPods库中的名字改为`MSAlertVC`，因此在安装完`MSAlertVC`后，引入头文件应该为`MSAlertController.h`，而非`MSAlertVC.h`**
### CocoaPods
1. 在 Podfile 中添加 `pod 'MSAlertVC'`；
2. 执行 `pod install` 或 `pod update`；
3. 导入头文件：`#import <MSAlertController.h>`。

### 手动安装
1. 下载 `MSAlertVC` 项目；
2. 将 `MSAlertController` 文件夹直接拖入项目中；
3. 导入头文件：`#import "MSAlertController.h"`。

## 使用方法

#### 1.初始化MSAlertController
```
+ (_Nonnull instancetype)alertControllerWithArray:(nonnull NSArray <NSString *> *)confirmArray;
```
#### 2.自定义属性
```
title
rowHeight
```
#### 3.自定义方法
```
// 设置第index行的按钮的颜色（可选实现的方法）
- (void)setColor:(nonnull UIColor *)color withIndex:(NSInteger)index;
// 设置第index行的按钮的字体（可选实现的方法）
- (void)setFont:(nonnull UIFont *)font withIndex:(NSInteger)index;
// 设置取消按钮的文字内容和颜色字体（可选实现的方法）
- (void)setCancleButtonTitle:(nonnull NSString *)title font:(nonnull UIFont *)font color:(nonnull UIColor *)color;
```
#### 4.点击事件
```
- (void)addConfirmButtonAction:(nullable MSButtonBlock)block;
```

## 使用示例

#### 示例1
```
NSArray *arr = @[@"保存图片", @"转发微博", @"赞"];
MSAlertController *alertVC = [MSAlertController alertControllerWithArray:arr];
[alertVC addConfirmButtonAction:^(NSInteger index, BOOL cancle) {
    if (cancle) {
        NSLog(@"你点击了取消按钮");
        return;
    } 
    NSLog(@"你点击的是：%@", arr[index]);
}];
[self presentViewController:alertVC animated:NO completion:nil];
```
#### 示例2
```
MSAlertController *unfollowAlertVC = [MSAlertController alertControllerWithArray:@[@"不再关注"]];
unfollowAlertVC.title = @"你确定不再关注MS了吗？";
[unfollowAlertVC setColor:[UIColor redColor] withIndex:0];
[unfollowAlertVC addConfirmButtonAction:^(NSInteger index, BOOL cancle) {
    if (cancle) {
        NSLog(@"你点击了取消按钮");
        return;
    }
    NSLog(@"果取关");
}];
[self presentViewController:unfollowAlertVC animated:NO completion:nil];
```

## 许可证

MSAlertController 使用 MIT 许可证，详情见 LICENSE 文件。
