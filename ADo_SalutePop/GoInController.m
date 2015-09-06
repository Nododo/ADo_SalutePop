//
//  GoInController.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/24.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "GoInController.h"
#import "ADo_LoopFoldView.h"

@interface GoInController ()

@end

@implementation GoInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ADo_LoopFoldView *ado = [[ADo_LoopFoldView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:ado];
    UIImage *one =[UIImage imageNamed:@"luffy.jpg"];
    UIImage *two =[UIImage imageNamed:@"boat.jpg"];
    UIImage *three = [UIImage imageNamed:@"life"];
    ado.foldImages = [NSMutableArray arrayWithObjects:one,two,three, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissssssss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc
{
    
}
@end
