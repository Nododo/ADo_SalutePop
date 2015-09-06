//
//  AppDelegate.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/21.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "AppDelegate.h"
#import "POP.h"


//调试专用随机色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

//屏幕宽度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface AppDelegate ()
@property (nonatomic,weak)UIView *backView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
//    UIView *backView = [[UIView alloc] initWithFrame:self.window.bounds];
//    backView.backgroundColor = [UIColor whiteColor];
//    [self.window addSubview:backView];
//    [self.window bringSubviewToFront:backView];
//    self.backView = backView;
//    [self doSomeAnimations];
    return YES;
}

- (void)doSomeAnimations
{
    /**
     kPOPLayerOpacity
     */
    float imageW = kScreenWidth / 4;
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *luffy = [[UIImageView alloc] init];
        luffy.image = [UIImage imageNamed:@"luffy.jpg"];
        luffy.frame = CGRectMake(i * imageW, 100, imageW, imageW);
        [self.backView addSubview:luffy];
        luffy.alpha = 0;
        [self performSelector:@selector(actionAndSleep:) withObject:luffy afterDelay:i * 0.5];
    }
    

   
}


- (void)actionAndSleep:(UIImageView *)luffy
{
    POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.fromValue = 0;
    alpha.toValue = @1;
    alpha.duration = 0.5;
   alpha.completionBlock = ^(POPAnimation *anim, BOOL finished)
    {
        if (luffy == self.backView.subviews[3]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.backView removeFromSuperview];
            });
        }
    };
    [luffy pop_addAnimation:alpha forKey:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
