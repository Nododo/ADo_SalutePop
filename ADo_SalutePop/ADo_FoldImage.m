//
//  ADo_FoldImage.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/25.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "ADo_FoldImage.h"
#import "UIImage+Blur.h"
#import "POP.h"

typedef NS_ENUM(NSInteger, LayerSection) {
    LayerSectionTop,
    LayerSectionBottom
};



@interface ADo_FoldImage ()
@property (nonatomic,strong)UIImage *image;
@property(nonatomic) UIImageView *bottomView;
@property(nonatomic) UIImageView *backView;
@property(nonatomic) CAGradientLayer *bottomShadowLayer;
@property(nonatomic) CAGradientLayer *topShadowLayer;

@end

@implementation ADo_FoldImage

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        [self addTopView];
        [self addBottomView];
    }
    return self;
}



- (void)addTopView
{

    UIImage *image = [self imageForSection:LayerSectionTop withImage:self.image];
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,
                                                                 0.f,
                                                                 CGRectGetWidth(self.bounds),
                                                                 CGRectGetMidY(self.bounds))];
    topView.image = image;
    topView.contentMode = UIViewContentModeScaleAspectFill;
    topView.layer.mask = [self maskForSection:LayerSectionTop withRect:topView.bounds];
    
    self.topShadowLayer = [CAGradientLayer layer];
    self.topShadowLayer.frame = topView.bounds;
    self.topShadowLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
    self.topShadowLayer.opacity = 0;
    
    [topView.layer addSublayer:self.bottomShadowLayer];
    [self addSubview:topView];
}

- (void)addBottomView
{
    UIImage *image = [self imageForSection:LayerSectionBottom withImage:self.image];
    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,
                                                                    CGRectGetMidY(self.bounds),
                                                                    CGRectGetWidth(self.bounds),
                                                                    CGRectGetMidY(self.bounds))];;
    self.bottomView.image = image;
    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.bottomView.layer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.bottomView.layer.transform = [self transform3D];
    self.bottomView.layer.mask = [self maskForSection:LayerSectionBottom withRect:self.bottomView.bounds];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.contentMode = UIViewContentModeScaleAspectFill;
    

    
    self.bottomShadowLayer = [CAGradientLayer layer];
    self.bottomShadowLayer.frame = self.bottomView.bounds;
    self.bottomShadowLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    self.bottomShadowLayer.opacity = 0;
    
    [self.bottomView.layer addSublayer:self.bottomShadowLayer];
    [self addSubview:self.bottomView];
}

- (UIImage *)imageForSection:(LayerSection)section withImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height / 2.f);
    if (section == LayerSectionBottom) {
        rect.origin.y = image.size.height / 2.f;
    }
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *imagePart = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return imagePart;
}

- (CATransform3D)transform3D
{
//    CATransform3D transform = CATransform3DIdentity;
    CATransform3D transform = CATransform3DMakeRotation(-M_PI, 1, 0, 0);
//    transform.m34 = 2.5 / -2000;
    return transform;
}

- (CAShapeLayer *)maskForSection:(LayerSection)section withRect:(CGRect)rect
{
    CAShapeLayer *layerMask = [CAShapeLayer layer];
    UIRectCorner corners = (section == LayerSectionTop) ? 3 : 12;
    
    layerMask.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                           byRoundingCorners:corners
                                                 cornerRadii:CGSizeMake(5, 5)].CGPath;
    return layerMask;
}


- (void)autoFold
{
        POPBasicAnimation *foldAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        foldAnimation.fromValue = @(-M_PI);
        foldAnimation.toValue = @(- 2 * M_PI);
        foldAnimation.duration = 0.5f;
//    foldAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished)
//    {
//        self.bottomView.layer.transform = [self transform3D];
//    };
        [self.bottomView.layer pop_addAnimation:foldAnimation forKey:@"foldAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.bottomView.layer.transform = [self transform3D];
    });


}
@end
