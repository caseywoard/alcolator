//
//  BLCWhiskeyViewController2.h
//  Alcolator
//
//  Created by Casey Ward on 3/8/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "ViewController.h"

@interface BLCWhiskeyViewController2 : ViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;

- (void)buttonPressed:(UIButton *)sender;

@end
