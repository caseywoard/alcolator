//
//  ViewController.m
//  Alcolator
//
//  Created by Casey Ward on 3/2/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;


@end


@implementation ViewController



 - (void)loadView { // Allocate and initialize the all-encompassing view
     self.view = [[UIView alloc] init]; // Allocate and initialize each of our views
     
     UITextField *textField = [[UITextField alloc] init];
     UISlider *slider = [[UISlider alloc] init];
     UILabel *label = [[UILabel alloc] init];
     UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init]; // Add each view and the gesture recognizer as the view's subviews
     UILabel *beersLabel = [[UILabel alloc] init];
     
     [self.view addSubview:textField];
     [self.view addSubview:slider];
     [self.view addSubview:label];
     [self.view addSubview:button];
     [self.view addGestureRecognizer:tap]; // Assign the views and gesture recognizer to our properties
     [self.view addSubview:beersLabel];
     
     self.beerPercentTextField = textField;
     self.beerCountSlider = slider;
     self.resultLabel = label;
     self.calculateButton = button;
     self.hideKeyboardTapGestureRecognizer = tap;
     self.numberOfBeersLabel = beersLabel;
 }

- (void)viewDidLoad { // original one
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = NSLocalizedString(@"Wine", @"wine");
    
    self.view.backgroundColor = [UIColor colorWithRed:111/255.0f green:180/255.0f blue:194/255.0f alpha:1.0f];
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    //CW: added barder around BeerPercentLabel
    [self.beerPercentTextField setBorderStyle:UITextBorderStyleLine];
    
    
    //CW: Set the placeholder text for numberOfBeersLabel
     self.numberOfBeersLabel.text = NSLocalizedString(@"1 beer", @"number of beers placeholder text");
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    
    //Add color to button
    self.calculateButton.backgroundColor = [UIColor colorWithRed:81/255.0f green:202/255.0f blue:243/255.0f alpha:1.0f];
    
    self.calculateButton.tintColor = [UIColor whiteColor];
    
    
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);//instead of setting to fixed 320
    //CGFloat viewHeight = CGRectGetHeight(self.view.bounds); //my attempt
    
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.numberOfBeersLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfNumberOfBeersLabel = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfNumberOfBeersLabel + padding, itemWidth, itemHeight * 4);//1
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
        //[self.resultLabel.frame]-20-[self.calculateButton.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}
- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];//<--whats this resign* method?
    
    //updating the numberOfBeers label based on slider value
    int numberOfBeersValueFromSlider = self.beerCountSlider.value;
    
    if (numberOfBeersValueFromSlider > 1) {
        self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%i beers", numberOfBeersValueFromSlider];
    } else {
        self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%i beer", numberOfBeersValueFromSlider];
    }
    
    //updating the view title based on the slider's value
    
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
   
    // set title for navbar based on alcohol formula outlined above
    NSString *resultTextForNavBar = [NSString stringWithFormat:NSLocalizedString(@"Wine (%.1f glasses)", nil),  numberOfWineGlassesForEquivalentAlcoholAmount];
    
    self.navigationItem.title = resultTextForNavBar;
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}
- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
