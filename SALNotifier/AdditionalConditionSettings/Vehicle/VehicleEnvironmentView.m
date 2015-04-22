/*
//  VehicleEnvironmentView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "VehicleEnvironmentView.h"

@interface VehicleEnvironmentView()
	@property(nonatomic, weak) IBOutlet UITextField *txtbxNumPeople;
	@property(nonatomic, weak) IBOutlet UIStepper *stepperNumPeople;


	-(IBAction)onNumberPeopleChanged:(UIStepper *)sender;
	-(IBAction)onRadioVolumeChange:(UISegmentedControl *)sender;
	-(IBAction)onWindowPositionChanged:(UISegmentedControl *)sender;
@end

@implementation VehicleEnvironmentView
{
	CGSize _intrinsicContentSize;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	//1. Load the nib to allow the nib to drive the frame
	NSArray *arrViewsLoaded = [[NSBundle mainBundle] loadNibNamed:@"VehicleEnvironmentView" owner:self options:nil];
	
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
	NSArray *arrViewsLoaded = [[NSBundle mainBundle]loadNibNamed:@"VehicleEnvironmentView" owner:self options:nil];
	
	if(arrViewsLoaded == nil)
		NSLog(@"Your Vehicle Environment view may look bad");
	
	//--TEST
	//self.layer.borderColor = [UIColor blackColor].CGColor;
	//self.layer.borderWidth = 2.0;
	//--END TEST
	
	_intrinsicContentSize = self.bounds.size;
	
	//2. Must now add as a sub-view
	[self addSubview:self.backingView];
	
	self.layer.borderColor = [UIColor blackColor].CGColor;

	
	return self;
}

-(IBAction)onNumberPeopleChanged:(UIStepper *)sender
{
	self.txtbxNumPeople.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

-(IBAction)onRadioVolumeChange:(UISegmentedControl *)sender
{
	
}

-(IBAction)onWindowPositionChanged:(UISegmentedControl *)sender
{
	
}

@end
