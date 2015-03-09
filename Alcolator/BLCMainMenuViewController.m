//
//  BLCMainMenuViewController.m
//  Alcolator
//
//  Created by Casey Ward on 3/8/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "BLCMainMenuViewController.h"
#import "ViewController.h"
#import "BLCWhiskeyViewController2.h"

@interface BLCMainMenuViewController ()


@property (nonatomic, strong) UIButton *wineButton;
@property (nonatomic, strong) UIButton *whiskeyButton;

@end

@implementation BLCMainMenuViewController

- (void) loadView {
    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine") forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey") forState:UIControlStateNormal];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc] init];
    
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.91f alpha:1];
    
    UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
    
    [self.wineButton.titleLabel setFont:bigFont];
    [self.whiskeyButton.titleLabel setFont:bigFont];
    
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect wineButtonFrame, whiskeyButtonFrame;
    CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge);
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
}

- (void) winePressed:(UIButton *) sender { ViewController *wineVC = [[ViewController alloc] init]; [self.navigationController pushViewController:wineVC animated:YES]; }

- (void) whiskeyPressed:(UIButton *) sender { BLCWhiskeyViewController2 *whiskeyVC = [[BLCWhiskeyViewController2 alloc] init]; [self.navigationController pushViewController:whiskeyVC animated:YES]; }
//


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
