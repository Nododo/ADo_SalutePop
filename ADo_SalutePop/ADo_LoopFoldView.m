//
//  ADo_LoopFoldView.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/26.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "ADo_LoopFoldView.h"
#import "ADo_FoldImage.h"
static int count = 0;
@interface ADo_LoopFoldView()
@property (nonatomic,strong)ADo_FoldImage *currentImage;
@end

@implementation ADo_LoopFoldView

- (void)setFoldImages:(NSMutableArray *)foldImages
{
    
    _foldImages = foldImages;
    for (int i = 0; i < _foldImages.count ; i ++) {
        ADo_FoldImage *image = [[ADo_FoldImage alloc] initWithFrame:self.bounds image:_foldImages[i]];
        image.hidden = YES;
        [self addSubview:image];
    }
    self.backgroundColor = [UIColor cyanColor];
    [self doAnimations];
}

- (void)doAnimations
{

    ADo_FoldImage *image = self.subviews[count % 3];
    image.hidden = NO;
//    [self bringSubviewToFront:image];
    [image autoFold];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        image.hidden = YES;
        count ++;
        [self doAnimations];
       
    });

}

@end
