//
//  HLSliderView.h
//  HLSliderView
//
//  Created by JJB_iOS on 2022/7/25.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HLSliderViewState) {
    HLSliderViewStateNormal = 0,
    HLSliderViewStateFinish
};

IB_DESIGNABLE

@interface HLSliderView : UIView

/// 默认文字，默认“向右滑动验证”
@property (nonatomic, copy) IBInspectable NSString *normalText UI_APPEARANCE_SELECTOR;
/// 默认文字颜色，默认0x33333
@property (nonatomic, strong) IBInspectable UIColor *normalTextColor UI_APPEARANCE_SELECTOR;
/// 默认文字字体，默认[UIFont systemFontOfSize:14]
@property (nonatomic, strong) IBInspectable UIFont *normalTextFont UI_APPEARANCE_SELECTOR;
/// 完成文字，默认“验证通过”
@property (nonatomic, copy) IBInspectable NSString *finishText UI_APPEARANCE_SELECTOR;
/// 完成文字颜色，默认[UIColor whiteColor]
@property (nonatomic, strong) IBInspectable UIColor *finishTextColor UI_APPEARANCE_SELECTOR;
/// 完成文字字体，默认[UIFont systemFontOfSize:14]
@property (nonatomic, strong) IBInspectable UIFont *finishTextFont UI_APPEARANCE_SELECTOR;
/// 滑块图片
@property (nonatomic, strong) IBInspectable UIImage *thumbImage UI_APPEARANCE_SELECTOR;
/// 完成滑块图片
@property (nonatomic, strong) IBInspectable UIImage *finishThumbImage UI_APPEARANCE_SELECTOR;
/// 滑块大小，默认CGSizeMake(44, 44)
@property (nonatomic, assign) IBInspectable CGSize thumbSize UI_APPEARANCE_SELECTOR;
/// 滑块左边颜色，默认0x3980EB
@property (nonatomic, strong) IBInspectable UIColor *minimumTrackColor UI_APPEARANCE_SELECTOR;
/// 滑块右边颜色，默认0xF5F5F5
@property (nonatomic, strong) IBInspectable UIColor *maximumTrackColor UI_APPEARANCE_SELECTOR;
/// 滑杆高度，默认40
@property (nonatomic, assign) IBInspectable CGFloat sliderBarHeight UI_APPEARANCE_SELECTOR;
/// 滑杆圆角半径，默认20
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
/// 拖动后是否返回，默认YES
@property (nonatomic, assign) IBInspectable BOOL isThumbBack UI_APPEARANCE_SELECTOR;
/// 是否需要加载中菊花，默认YES
@property (nonatomic, assign) IBInspectable BOOL isNeedLoadingView UI_APPEARANCE_SELECTOR;
/// 菊花颜色，默认[UIColor whiteColor]
@property (nonatomic, strong) IBInspectable UIColor *loadingViewColor UI_APPEARANCE_SELECTOR;
/// 滑杆左右间隙，默认2.5f
@property (nonatomic, assign) IBInspectable CGFloat sliderBarSpace UI_APPEARANCE_SELECTOR;
/// 滑动结束回调，这里记得weakSelf避免循环引用
@property (nonatomic, copy) void(^sliderEndBlock)(void);

/**
 * 设置slider的值
 * @param state HLSliderViewState
 */
- (void)setSliderState:(HLSliderViewState)state;


/**
 * 设置slider的值
 * @param state HLSliderViewState
 * @param animation 是否需要动画
 * @param completion 动画完成回调
 */
- (void)setSliderState:(HLSliderViewState)state
             animation:(BOOL)animation
            completion:(void (^)(BOOL))completion;

@end
