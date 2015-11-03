/*
//  VehicleEnvironmentView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "VehicleEnvironmentView.h"
#import "ConstantDefines.h"
#import "CPeripheralManager.h"

@interface VehicleEnvironmentView()
	@property(nonatomic, weak) IBOutlet UITextField *txtbxNumPeople;

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

	[self configureToolbarOnTopOfKeyboard];

	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	//1. So that all the dimiensions and connections from the nib. ie: Load the interface
	NSArray *arrViewsLoaded = [[NSBundle mainBundle]loadNibNamed:@"VehicleEnvironmentView" owner:self options:nil];
	
	if(arrViewsLoaded == nil)
		NSLog(@"Your Vehicle Environment view may look bad");
		
	_intrinsicContentSize = self.bounds.size;
	
	//2. Must now add as a sub-view
	[self addSubview:self.backingView];
	
	self.layer.borderColor = [UIColor blackColor].CGColor;

	[self configureToolbarOnTopOfKeyboard];
	
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
	self.txtbxNumPeople.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad
{
	if(self.txtbxNumPeople.isFirstResponder == TRUE)
	{
		[self.txtbxNumPeople resignFirstResponder];
		
		NSString *numPeople = [NSString stringWithFormat:@"%@%@%@%@",
									  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines numberOfPeopleTag], [ConstantDefines messageDelimiter]];
	
		numPeople = [numPeople stringByAppendingString:self.txtbxNumPeople.text];
		
		[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:numPeople];
	}
}

-(IBAction)onRadioVolumeChange:(UISegmentedControl *)sender
{
	NSString *radioVolumeMessage = [NSString stringWithFormat:@"%@%@%@%@",
											  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines radioVolumeTag], [ConstantDefines messageDelimiter]];

	radioVolumeMessage = [radioVolumeMessage stringByAppendingString:[ConstantDefines radionVolume:(int)sender.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:radioVolumeMessage];
}

-(IBAction)onWindowPositionChanged:(UISegmentedControl *)sender
{
	NSString *windowPositionMessage = [NSString stringWithFormat:@"%@%@%@%@",
												  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines windowPositionTag], [ConstantDefines messageDelimiter]];
	
	windowPositionMessage = [windowPositionMessage stringByAppendingString:[ConstantDefines windowPostition:(int)sender.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:windowPositionMessage];
}

@end
