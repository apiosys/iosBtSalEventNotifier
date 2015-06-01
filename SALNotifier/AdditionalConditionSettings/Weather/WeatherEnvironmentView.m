/*
//  WeatherEnvironmentView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "WeatherEnvironmentView.h"
#import "ConstantDefines.h"
#import "HelperMethods.h"
#import "CPeripheralManager.h"

@interface WeatherEnvironmentView()
	@property (weak, nonatomic) IBOutlet UITextField *temperatureTextfield;
	@property (weak, nonatomic) IBOutlet UISwitch *degreesSelectionSwitch;
	@property (weak, nonatomic) IBOutlet UISegmentedControl *cloudCoverageSegCtrl;
	@property (weak, nonatomic) IBOutlet UISegmentedControl *precipitationSegCtrl;
	@property (weak, nonatomic) IBOutlet UISegmentedControl *precipitationVolumeSegCtrl;

	-(IBAction)onDegreeUnitsChange:(UISwitch *)sender;
	-(IBAction)onConditionSelectionChange:(UISegmentedControl *)sender;
@end

@implementation WeatherEnvironmentView
{
	CGSize _intrinsicContentSize;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	//1. Load the nib to allow the nib to drive the frame
	NSArray *arrViewsLoaded = [[NSBundle mainBundle] loadNibNamed:@"WeatherEnvironmentView" owner:self options:nil];
	
	if(arrViewsLoaded == nil)
		NSLog(@"Your beacon pickerview may look bad");
	
	//2. Adjust the bounds. DON'T set the frame here. That will override the IB layout of where the frame gets placed.
	self.bounds = self.backingView.bounds;
	_intrinsicContentSize = self.bounds.size;
	
	//3. Add as sub-view. Note to be sure to add this only AFTER the bounds are set.
	[self addSubview:self.backingView];
	
	//NOTE: You can set the "intrinsicContextSize" within your view.
	//This will help eliminate some of the autolayout constraints and
	//get your view to load more cleanly
	
	[self configureToolbarOnTopOfKeyboard];

	self.layer.borderColor = [UIColor blackColor].CGColor;
	
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	//1. So that all the dimiensions and connections from the nib. ie: Load the interface
	NSArray *arrViewsLoaded = [[NSBundle mainBundle]loadNibNamed:@"WeatherEnvironmentView" owner:self options:nil];
	
	if(arrViewsLoaded == nil)
		NSLog(@"Your beacon pickerview may look bad");
	
	_intrinsicContentSize = self.bounds.size;
	
	//2. Must now add as a sub-view
	[self addSubview:self.backingView];
	
	[self configureToolbarOnTopOfKeyboard];
	
	self.layer.borderColor = [UIColor blackColor].CGColor;

	return self;
}

-(void)configureToolbarOnTopOfKeyboard
{
	UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
	numberToolbar.barStyle = UIBarStyleDefault;

	numberToolbar.items = [NSArray arrayWithObjects:
								  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
								  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
								  [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
								  nil];

	[numberToolbar sizeToFit];
	self.temperatureTextfield.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad
{
	if(self.temperatureTextfield.isFirstResponder == TRUE)
	{
		[self.temperatureTextfield resignFirstResponder];
		
		NSString *degreesMessage = [NSString stringWithFormat:@"%@%@", [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter]];
		degreesMessage = [degreesMessage stringByAppendingString:[ConstantDefines degreesUnitsTag:self.degreesSelectionSwitch.on]];

		[[CPeripheralManager thePeripheralManager] updateServiceValueWithMessage:degreesMessage];
	}
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return TRUE;
}

-(IBAction)onDegreeUnitsChange:(UISwitch *)sender
{
	double dTemperature = 0.0;
	if([HelperMethods stringToDouble:self.temperatureTextfield.text derivedDoubleValue:&dTemperature] == false)
	{
		self.temperatureTextfield.text = @"0.0";
		return;
	}
	
	if(sender.on == FALSE)//False is Celcius
		dTemperature = [HelperMethods fahrenheitToCelcius:dTemperature];
	else
		dTemperature = [HelperMethods celciusToFahrenheit:dTemperature];

	self.temperatureTextfield.text = [NSString stringWithFormat:@"%.1lf", dTemperature];
	
	NSString *degreesMessage = [NSString stringWithFormat:@"%@%@", [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter]];
	degreesMessage = [degreesMessage stringByAppendingString:[ConstantDefines degreesUnitsTag:sender.on]];
	
	[[CPeripheralManager thePeripheralManager] updateServiceValueWithMessage:degreesMessage];
}

-(IBAction)onConditionSelectionChange:(UISegmentedControl *)sender
{
	if(sender == self.cloudCoverageSegCtrl)
		[self onCloudCoverageChange];
	else if(sender == self.precipitationSegCtrl)
		[self onPrecipitationChange];
	else if(sender == self.precipitationVolumeSegCtrl)
		[self onPrecipitationVoumeChange];
}

-(void)onPrecipitationChange
{
	NSString *precipitationMessage = [NSString stringWithFormat:@"%@%@", [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter]];
	
	precipitationMessage = [precipitationMessage stringByAppendingString:[ConstantDefines precipitationTag:(int)self.precipitationSegCtrl.selectedSegmentIndex]];
	
	[[CPeripheralManager thePeripheralManager] updateServiceValueWithMessage:precipitationMessage];
}

-(void)onPrecipitationVoumeChange
{
	NSString *precipitationVolumeMessage = [NSString stringWithFormat:@"%@%@", [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter]];

	precipitationVolumeMessage = [precipitationVolumeMessage stringByAppendingString:[ConstantDefines precipitationVolumeTag:(int)self.precipitationVolumeSegCtrl.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] updateServiceValueWithMessage:precipitationVolumeMessage];
}

-(void)onCloudCoverageChange
{
	NSString *cloudCoverageMessage = [NSString stringWithFormat:@"%@%@", [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter]];

	cloudCoverageMessage = [cloudCoverageMessage stringByAppendingString:[ConstantDefines cloudCoverageTag:(int)self.cloudCoverageSegCtrl.selectedSegmentIndex]];
	
	[[CPeripheralManager thePeripheralManager] updateServiceValueWithMessage:cloudCoverageMessage];
}

@end
