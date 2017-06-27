//
//  ThirdViewController.m
//  VCTransitionDemo
//
//  Created by 万旭东 on 17/6/27.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ThirdViewController";
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    CGFloat btnW = 200;
    CGFloat btnH = 50;
    CGFloat btnX = (self.view.frame.size.width - btnW) / 2;
    CGFloat btnY = 200;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
