/*
//  RoadConditionsView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "RoadConditionsView.h"
#import "ConstantDefines.h"
#import "CPeripheralManager.h"

@interface RoadConditionsView()
	@property (weak, nonatomic) IBOutlet UISegmentedControl *roadMaintSegCtrl;
	@property (weak, nonatomic) IBOutlet UISegmentedControl *roadConditionSegCtrl;
	@property (weak, nonatomic) IBOutlet UISegmentedControl *weatherRoadEffectSegCtrl;

	-(IBAction)onRoadConditionChange:(UISegmentedControl *)sender;
@end

@implementation RoadConditionsView
{
	CGSize _intrinsicContentSize;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	//1. Load the nib to allow the nib to drive the frame
	if([[NSBundle mainBundle] loadNibNamed:@"RoadConditionsView" owner:self options:nil] == nil)
		return self;
	
	//2. Adjust the bounds. DON'T set the frame here. That will override the IB layout of where the frame gets placed.
	self.bounds = self.backingView.bounds;
	
	//NOTE: You can set the "intrinsicContextSize" within your view.
	//This will help eliminate some of the autolayout constraints and
	//get your view to load more cleanly
	_intrinsicContentSize = self.bounds.size;
	
	//3. Add as sub-view. Note to be sure to add this only AFTER the bounds are set.
	[self addSubview:self.backingView];
	
	self.layer.borderColor = [UIColor blackColor].CGColor;
	
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	//1. So that all the dimiensions and connections from the nib. ie: Load the interface
	if([[NSBundle mainBundle]loadNibNamed:@"RoadConditionsView" owner:self options:nil] == nil)
		return self;
	
	_intrinsicContentSize = self.bounds.size;
	
	//2. Must now add as a sub-view
	[self addSubview:self.backingView];
	
	
	self.layer.borderColor = [UIColor blackColor].CGColor;

	return self;
}

-(IBAction)onRoadConditionChange:(UISegmentedControl *)sender
{
	if(sender == self.roadConditionSegCtrl)
		[self onRoadPavementChange];
	else if(sender == self.roadMaintSegCtrl)
		[self onRoadmaintenanceChange];
	else if(sender == self.weatherRoadEffectSegCtrl)
		[self onRoadWeatherAffectChange];
}

-(void)onRoadPavementChange
{
	NSString *roadConditionMessage = [NSString stringWithFormat:@"%@%@%@%@",
												 [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines roadConditionTag], [ConstantDefines messageDelimiter]];

	switch (self.roadConditionSegCtrl.selectedSegmentIndex)
	{
		case 0:
			roadConditionMessage = [roadConditionMessage stringByAppendingString:[ConstantDefines pavedRoadTag]];
			break;
		case 1:
			roadConditionMessage = [roadConditionMessage stringByAppendingString:[ConstantDefines gravelRoadTag]];
			break;
		default:
			roadConditionMessage = [roadConditionMessage stringByAppendingString:@"UKN"];
			break;
	}

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:roadConditionMessage];
}

-(void)onRoadmaintenanceChange
{
	NSString *roadMaintenanceMessage = [NSString stringWithFormat:@"%@%@%@%@",
													[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter],[ConstantDefines roadMaintenanceTag], [ConstantDefines messageDelimiter]];

	switch (self.roadMaintSegCtrl.selectedSegmentIndex)
	{
		case 0:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:[ConstantDefines smoothRoadTag]];
			break;
		case 1:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:[ConstantDefines roughRoadTag]];
			break;
		case 2:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:[ConstantDefines bumbpyRoadTag]];
			break;
		default:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:@"UKN"];
			break;
	}
	
	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:roadMaintenanceMessage];
}

-(void)onRoadWeatherAffectChange
{
	NSString *roadWeatherConditionsMessage = [NSString stringWithFormat:@"%@%@%@%@",
															[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines weatherInfluenceTag], [ConstantDefines messageDelimiter]];

	switch (self.weatherRoadEffectSegCtrl.selectedSegmentIndex)
	{
		case 0:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines dryRoadTag]];
			break;
		case 1:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines wetRoadTag]];
			break;
		case 2:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines floodedRoadTag]];
			break;
		case 3:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines icyRoadTag]];
			break;
		default:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines snowyRoadTag]];//Reserved and not used right now.
			break;
	}

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:roadWeatherConditionsMessage];
}

@end
