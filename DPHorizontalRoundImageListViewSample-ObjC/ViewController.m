//
//  ViewController.m
//  DPHorizontalRoundImageListViewSample-ObjC
//
//  Created by DP on 2020/6/16.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <DPHorizontalRoundImageListView/DPHorizontalRoundImageListView.h>

@interface ViewController () <HorizontalRoundImageListViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imageItems = @[
        [[HorizontalRoundImageListViewItem alloc] initWithImage:[UIImage imageNamed:@"cat_01"]],
//        [[HorizontalRoundImageListViewItem alloc] initWithImage:[UIImage imageNamed:@"cat_02"]],
        [[HorizontalRoundImageListViewItem alloc] initWithWebImageURL:[NSURL URLWithString:@"http://image.woshipm.com/wp-files/2020/04/WDHJfSstJ1Pud8XG3H0b.jpg!/both/690x340"]],
        [[HorizontalRoundImageListViewItem alloc] initWithImage:[UIImage imageNamed:@"cat_03"]],
//        [[HorizontalRoundImageListViewItem alloc] initWithImage:[UIImage imageNamed:@"cat_04"]],
        [[HorizontalRoundImageListViewItem alloc] initWithWebImageURL:[NSURL URLWithString:@"http://image.woshipm.com/wp-files/2020/04/WDHJfSstJ1Pud8XG3H0b.jpg!/both/690x340"]],
    ];
    
    HorizontalRoundImageListView *listView = [[HorizontalRoundImageListView alloc] initWithFrame:CGRectZero imageItems:@[]];
    [self.view addSubview:listView];
    listView.translatesAutoresizingMaskIntoConstraints = NO;
    [[listView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20] setActive:YES];
    [[listView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:200] setActive:YES];
    
    listView.itemBorderWidth = 5;
    listView.itemBorderColor = UIColor.redColor;
    listView.spacing         = -10;
    listView.imageItems      = imageItems;
    
    listView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", self.view.subviews);
}

- (void)horizontalRoundImageListView:(HorizontalRoundImageListView *)listView didTapItemViewAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}

@end
