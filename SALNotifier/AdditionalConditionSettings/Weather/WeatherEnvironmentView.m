/*
//  WeatherEnvironmentView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "WeatherEnvironmentView.h"
#import "HelperMethods.h"

@interface WeatherEnvironmentView()
	@property(nonatomic, readonly) double dTemperature;
@end

@implementation WeatherEnvironmentView
{
	CGSize _intrinsicContentSize;
}

@synthesize dTemperature = _dTemperature;

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
	
	
	self.layer.borderColor = [UIColor blackColor].CGColor;

	return self;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	if([HelperMethods stringToDouble:textField.text derivedDoubleValue:&_dTemperature] == FALSE)
	{
		_dTemperature = 50.0;
		textField.text = [NSString stringWithFormat:@"%.1lf", self.dTemperature];
		NSLog(@"Error converting the text to a double");
	}
	
	return TRUE;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField;// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called


@end
