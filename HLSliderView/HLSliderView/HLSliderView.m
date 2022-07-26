//
//  HLSliderView.m
//  HLSliderView
//
//  Created by JJB_iOS on 2022/7/25.
//

#define HLUIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "HLSliderView.h"

@interface HLSliderView()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@property (nonatomic, assign) CGFloat thumbImageViewY;
@end

@implementation HLSliderView

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self build];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self build];
    }
    return self;
}

#if TARGET_INTERFACE_BUILDER
- (void)prepareForInterfaceBuilder
{
    [self layoutIfNeeded];
}
#endif

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundView.frame = CGRectMake(self.sliderBarSpace, (CGRectGetHeight(self.frame) - self.sliderBarHeight) / 2.0f, CGRectGetWidth(self.frame) - self.sliderBarSpace * 2, self.sliderBarHeight);
    self.textLabel.frame = self.bounds;
    self.thumbImageView.frame = CGRectMake(0, (CGRectGetHeight(self.frame) - self.thumbSize.height) / 2.0f, self.thumbSize.width, self.thumbSize.height);
    self.loadingView.frame = CGRectMake((CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame)) / 2.0f, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
}

#pragma mark - Touch Method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != self.thumbImageView) {
        return;
    }
    CGPoint point = [touch locationInView:self];
    [self fillForeGroundViewWithPoint:point.x];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != self.thumbImageView) {
        return;
    }
    CGPoint point = [touch locationInView:self];
    [self fillForeGroundViewWithPoint:point.x];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != self.thumbImageView) {
        return;
    }
    
    CGPoint point = [touch locationInView:self];
    // 完成
    if (point.x >= self.bounds.size.width - self.thumbSize.width / 2.0f) {
        if (self.sliderEndBlock) {
            self.sliderEndBlock();
        }
        if (self.isNeedLoadingView) {
            self.loadingView.hidden = NO;
            self.textLabel.hidden = YES;
            [self.loadingView startAnimating];
        } else {
            [self setSliderState:HLSliderViewStateFinish];
        }
    }
    // 未完成
    else {
        if (self.isThumbBack) {
            [self setSliderState:HLSliderViewStateNormal animation:YES completion:nil];
        }
    }
}

#pragma mark - Private Method

- (void)build
{
    // default
    _normalText = @"向右滑动验证";
    _normalTextColor = HLUIColorFromHEX(0x333333);
    _normalTextFont = [UIFont systemFontOfSize:14];
    _finishText = @"验证通过";
    _finishTextColor = [UIColor whiteColor];
    _finishTextFont = [UIFont systemFontOfSize:14];
    _thumbImage = [HLSliderView budleImageWithName:@"thumb_image"];
    _finishThumbImage = [HLSliderView budleImageWithName:@"finish_thumb_image"];
    _thumbSize = CGSizeMake(44, 44);
    _minimumTrackColor = HLUIColorFromHEX(0x3980EB);
    _maximumTrackColor = HLUIColorFromHEX(0xF5F5F5);
    _sliderBarHeight = 40;
    _cornerRadius = 20;
    _isThumbBack = YES;
    _isNeedLoadingView = YES;
    _loadingViewColor = [UIColor whiteColor];
    _sliderBarSpace = 2.5f;
    
    // backgroundView
    _backgroundView = [UIView new];
    [self addSubview:_backgroundView];
    _backgroundView.layer.masksToBounds = YES;
    // foregroundView
    _foregroundView = [UIView new];
    [_backgroundView addSubview:_foregroundView];
    // textLabel
    _textLabel = [UILabel new];
    [self addSubview:_textLabel];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    // thumbImageView
    _thumbImageView = [UIImageView new];
    [self addSubview:_thumbImageView];
    _thumbImageView.userInteractionEnabled = YES;
    _thumbImageView.backgroundColor = [UIColor clearColor];
    // loadingView
    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:_loadingView];
    _loadingView.hidden = YES;
    
    [self setupStyle];
    [self fillForeGroundViewWithPoint:0];
}

- (void)setupStyle
{
    _backgroundView.layer.cornerRadius = _cornerRadius;
    _backgroundView.backgroundColor = _maximumTrackColor;
    _foregroundView.backgroundColor = _minimumTrackColor;
    _textLabel.text = _normalText;
    _textLabel.textColor = _normalTextColor;
    _textLabel.font = _normalTextFont;
    _thumbImageView.image = _thumbImage;
    [_thumbImageView sizeToFit];
    _loadingView.color = _loadingViewColor;
}

+ (UIImage *)budleImageWithName:(NSString *)imageName
{
    if ([UIScreen mainScreen].scale == 3) {
        imageName = [NSString stringWithFormat:@"%@@3x", imageName];
    } else {
        imageName = [NSString stringWithFormat:@"%@@2x", imageName];
    }
    
    NSString *bundleName = @"HLSliderView";
    // 静态库 url 的获取
    NSURL *url = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    if (!url) {
        // 动态库 url 的获取
        url = [[NSBundle bundleForClass:[self class]] URLForResource:bundleName withExtension:@"bundle"];
    }
    NSBundle *bundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

- (void)fillForeGroundViewWithPoint:(CGFloat)pointX
{
    CGFloat thunmbW = self.thumbSize.width;
    CGFloat thunmbH = self.thumbSize.height;
    CGFloat thunmbY = (CGRectGetHeight(self.frame) - self.thumbSize.height) / 2.0f;
    
    if (pointX < 0) { pointX = 0; }
    if (pointX > self.bounds.size.width) { pointX = self.bounds.size.width; }

    self.foregroundView.frame = CGRectMake(0, 0, pointX, self.sliderBarHeight);

    if (pointX <= 0) {
        self.thumbImageView.frame = CGRectMake(0, thunmbY, thunmbW, thunmbH);
    } else if (pointX > self.bounds.size.width) {
        self.thumbImageView.frame = CGRectMake(self.frame.size.width - thunmbW, thunmbY, thunmbW, thunmbH);
    }else{
        CGFloat x = pointX - thunmbW / 2.0f;
        if (x < 0) {
            x = 0;
        }
        if (x > self.bounds.size.width - thunmbW) {
            x = self.bounds.size.width - thunmbW;
        }
        self.thumbImageView.frame = CGRectMake(x, thunmbY, thunmbW, thunmbH);
    }
    
}

#pragma mark - Public Mehtod

- (void)setSliderState:(HLSliderViewState)state
{
    [self setSliderState:state animation:NO completion:nil];
}

- (void)setSliderState:(HLSliderViewState)state
             animation:(BOOL)animation
            completion:(void (^)(BOOL))completion
{
    CGFloat value = state == HLSliderViewStateNormal ? 0 : 1;
    CGFloat pointX = value * self.bounds.size.width;
    if (animation) {
        [UIView animateWithDuration:0.25f animations:^{
            [self fillForeGroundViewWithPoint:pointX];
        } completion:^(BOOL finished) {
            if (completion) { completion(finished); }
        }];
    } else {
        [self fillForeGroundViewWithPoint:pointX];
    }
    
    if (state == HLSliderViewStateNormal) {
        self.userInteractionEnabled = YES;
        self.thumbImageView.image = self.thumbImage;
        self.textLabel.text = self.normalText;
        self.textLabel.font = self.normalTextFont;
        self.textLabel.textColor = self.normalTextColor;
    } else {
        self.userInteractionEnabled = NO;
        self.thumbImageView.image = self.finishThumbImage;
        self.textLabel.text = self.finishText;
        self.textLabel.font = self.finishTextFont;
        self.textLabel.textColor = self.finishTextColor;
    }
    
    self.textLabel.hidden = NO;
    [self.loadingView stopAnimating];
    self.loadingView.hidden = YES;
}

#pragma mark - Setter

/*
 /// 滑杆左右间隙，默认2.5f
 @property (nonatomic, assign) IBInspectable CGFloat sliderBarSpace UI_APPEARANCE_SELECTOR;
 */

- (void)setNormalText:(NSString *)normalText {
    if (![_normalText isEqualToString:normalText]) {
        _normalText = normalText;
        [self setupStyle];
    }
}

- (void)setNormalTextColor:(UIColor *)normalTextColor {
    _normalTextColor = normalTextColor;
    [self setupStyle];
}

- (void)setNormalTextFont:(UIFont *)normalTextFont {
    _normalTextFont = normalTextFont;
    [self setupStyle];
}

- (void)setFinishText:(NSString *)finishText {
    if (![_finishText isEqualToString:finishText]) {
        _finishText = finishText;
        [self setupStyle];
    }
}

- (void)setFinishTextColor:(UIColor *)finishTextColor {
    _finishTextColor = finishTextColor;
    [self setupStyle];
}

- (void)setFinishTextFont:(UIFont *)finishTextFont {
    _finishTextFont = finishTextFont;
    [self setupStyle];
}

- (void)setThumbImage:(UIImage *)thumbImage {
    _thumbImage = thumbImage;
    [self setupStyle];
}

- (void)setFinishThumbImage:(UIImage *)finishThumbImage {
    _finishThumbImage = finishThumbImage;
    [self setupStyle];
}

- (void)setThumbSize:(CGSize)thumbSize {
    _thumbSize = thumbSize;
    [self setupStyle];
}

- (void)setMinimumTrackColor:(UIColor *)minimumTrackColor {
    _minimumTrackColor = minimumTrackColor;
    [self setupStyle];
}

- (void)setMaximumTrackColor:(UIColor *)maximumTrackColor {
    _maximumTrackColor = maximumTrackColor;
    [self setupStyle];
}

- (void)setSliderBarHeight:(CGFloat)sliderBarHeight {
    if (_sliderBarHeight != sliderBarHeight) {
        _sliderBarHeight = sliderBarHeight;
        [self setupStyle];
    }
}

- (void)setLoadingViewColor:(UIColor *)loadingViewColor {
    _loadingViewColor = loadingViewColor;
    [self setupStyle];
}

- (void)setSliderBarSpace:(CGFloat)sliderBarSpace {
    if (_sliderBarSpace != sliderBarSpace) {
        [self layoutIfNeeded];
    }
}

@end
