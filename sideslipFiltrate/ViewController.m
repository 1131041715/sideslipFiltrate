//
//  ViewController.m
//  sideslipFiltrate
//
//  Created by 大碗豆 on 17/8/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"
#import "collectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadBtn];
}


- (void)loadBtn{
    
    UIButton *btn = [UIButton new];
    
//    [btn setImage:[UIImage imageNamed:@"rp"] forState:UIControlStateNormal];
//    [btn setTitle:@"筛选" forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor purpleColor];
//    btn.imageView.e
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 100/2, 0, 0);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -100 , 0, 0);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    lab.text = @"筛选";
    [btn addSubview:lab];
    
    UIImageView *iamge = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    iamge.image = [UIImage imageNamed:@"rp"];
    
    [btn addSubview:iamge];
    
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];
}

- (void)btnAction{
    
//    collectionView *colleView = [[collectionView alloc] init];
//    
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:colleView];
    
    
    NSArray *arr = @[@[@"全部", @"123", @"234", @"345", @"456", @"567", @"678", @"789"], @[@"全部", @"一二三", @"二三四", @"三四五", @"四五六", @"五六七", @"六七八"], @[@"全部", @"0-100元", @"101-500元", @"501-1000元", @"1001-2000元", @"2001-5000元", @"5000元以上"], @[@"全国", @"北京", @"上海", @"郑州", @"石家庄", @"天津", @"深圳"]];
    
    collectionView *collV = [[collectionView alloc] initWithTitles:@[@"123", @"一二三", @"价格", @"地区"] items:arr];
    [[UIApplication sharedApplication].keyWindow addSubview:collV];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
