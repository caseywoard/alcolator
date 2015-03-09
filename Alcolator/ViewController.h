//
//  ViewController.h
//  Alcolator
//
//  Created by Casey Ward on 3/2/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *numberOfBeersLabel;


- (void)buttonPressed:(UIButton *)sender;

@end

