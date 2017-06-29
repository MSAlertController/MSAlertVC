//
//  MSAlertController.h
//  SheetText
//
//  Created by moses on 2017/4/26.
//  Copyright © 2017年 ANT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MSButtonBlock)(NSInteger index, BOOL cancle);

@interface MSAlertController : UIViewController

/* 此处借用了系统的title属性作为MSAlertController的提醒标题 *///（只用到了这两个属性）
/* 重置按钮的高度 */ // 默认为5.5inch:55、 4.7inch:53、 4.0inch:50
@property (nonatomic, assign) CGFloat rowHeight;

/**
 构造方法（必须实现的方法）
 
 @param confirmArray <#confirmArray description#>
 
 @return <#return value description#>
 */
+ (_Nonnull instancetype)alertControllerWithArray:(nonnull NSArray <NSString *> *)confirmArray;
/**
 执行点击事件的block（必须实现的方法）
 
 @param block <#block description#>
 */
- (void)addConfirmButtonAction:(nullable MSButtonBlock)block;
/**
 设置第index行的按钮的颜色（可选实现的方法）
 
 @param color 默认：[UIColor colorWithWhite:0.2 alpha:1.0]
 @param index <#index description#>
 */
- (void)setColor:(nonnull UIColor *)color withIndex:(NSInteger)index;
/**
 设置第index行的按钮的字体（可选实现的方法）
 
 @param font  默认：17
 @param index <#index description#>
 */
- (void)setFont:(nonnull UIFont *)font withIndex:(NSInteger)index;
/**
 重置取消按钮的文字内容和颜色字体（可选实现的方法）
 
 @param title 默认：取消
 @param font  默认：17
 @param color 默认：[UIColor colorWithWhite:0.2 alpha:1.0]
 */
- (void)setCancleButtonTitle:(nonnull NSString *)title font:(nonnull UIFont *)font color:(nonnull UIColor *)color;

@end
