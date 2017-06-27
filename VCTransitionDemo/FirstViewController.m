//
//  FirstViewController.m
//  VCTransitionDemo
//
//  Created by 万旭东 on 17/6/27.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "FirstViewController.h"
#import "WXDViewControllerTansition.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) WXDNavigationControllerDelegate *transitionDelagate;

@property (nonatomic, strong) NSMutableArray *btnTitles;

@end

@implementation FirstViewController

- (NSMutableArray *)btnTitles
{
    if (!_btnTitles) {
        _btnTitles = [NSMutableArray arrayWithArray:@[@"Scale",@"Cube",@"BottomLeft",@"HorizontalFlod",@"VerticalFlod",@"CurveEaseOut",@"FadeFold"]];
    }
    return _btnTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Push/Pop";
    self.view.backgroundColor = [UIColor redColor];
    
    CGFloat btnW = 200;
    CGFloat btnH = 40;
    CGFloat btnX = (self.view.frame.size.width - btnW) / 2;
    for (int i = 0; i < self.btnTitles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        CGFloat btnY = 100 + i * (btnH + 10);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.tag = 10 + i;
        [btn setTitle:self.btnTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    self.transitionDelagate = [WXDNavigationControllerDelegate new];
    self.navigationController.delegate = self.transitionDelagate;
}

#pragma mark btnClick
- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 10:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeScale;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        case 11:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeCube;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        case 12:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeBottomLeft;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        case 13:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeHorizontalFold;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        case 14:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeVerticalFold;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        case 15:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeCurveEaseOut;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        case 16:
        {
            self.transitionDelagate.transitionType = WXDTransitionTypeFadeFold;
            [self.navigationController pushViewController:[SecondViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
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
