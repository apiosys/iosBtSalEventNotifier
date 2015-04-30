/*
//  ViewController.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "ViewController.h"
#import "CPeripheralManager.h"

#import "RoadConditionsView.h"
#import "StartStopEventsView.h"
#import "VehicleEnvironmentView.h"
#import "WeatherEnvironmentView.h"

static NSString * const STOP_ADVERTISING_TEXT = @"Stop Advertising";
static NSString * const START_ADVERTISING_TEXT = @"Start Advertising";

@interface ViewController ()
	@property(nonatomic, weak) IBOutlet UIButton *btnStartStopAdvertising;

	@property(nonatomic ,strong) CPeripheralManager *periphMgr;

	@property(nonatomic ,strong) RoadConditionsView *roadConditionsView;
	@property(nonatomic, strong) StartStopEventsView *startStopEventsView;
	@property(nonatomic ,strong) VehicleEnvironmentView *vehicleEnvironmentView;
	@property(nonatomic ,strong) WeatherEnvironmentView *weatherEnvironmentView;

	-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop;//TRUE = Start  FALSE = Stop

	-(IBAction)onAdvertise:(UIButton *)sender;
@end

@implementation ViewController

@synthesize periphMgr = _periphMgr;

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.conditionViewsParentScrollView.layer.borderWidth = 1.0;
	self.conditionViewsParentScrollView.layer.borderColor = [UIColor blackColor].CGColor;

	[self layoutConditionViews];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self layoutEventRecordingViews];
}

-(RoadConditionsView *)roadConditionsView
{
	if(_roadConditionsView == nil)
	{
		_roadConditionsView = [[RoadConditionsView alloc]init];
		_roadConditionsView.translatesAutoresizingMaskIntoConstraints = FALSE;
		[self.conditionViewsParentScrollView addSubview:_roadConditionsView];
	}
	
	return _roadConditionsView;
}

-(StartStopEventsView *)startStopEventsView
{
	if(_startStopEventsView == nil)
	{
		_startStopEventsView = [[StartStopEventsView alloc]init];
		_startStopEventsView.translatesAutoresizingMaskIntoConstraints = FALSE;
		[self.eventViewParentView addSubview:_startStopEventsView];
		[_startStopEventsView configureButtonFrames:nil];
	}

	return _startStopEventsView;
}

-(VehicleEnvironmentView *)vehicleEnvironmentView
{
	if(_vehicleEnvironmentView == nil)
	{
		_vehicleEnvironmentView = [[VehicleEnvironmentView alloc]init];
		_vehicleEnvironmentView.translatesAutoresizingMaskIntoConstraints = FALSE;
		[self.conditionViewsParentScrollView addSubview:_vehicleEnvironmentView];
	}
	
	return _vehicleEnvironmentView;
}

-(WeatherEnvironmentView *)weatherEnvironmentView
{
	if(_weatherEnvironmentView == nil)
	{
		_weatherEnvironmentView = [[WeatherEnvironmentView alloc]init];
		_weatherEnvironmentView.translatesAutoresizingMaskIntoConstraints = FALSE;
		[self.conditionViewsParentScrollView addSubview:_weatherEnvironmentView];
	}

	return _weatherEnvironmentView;
}

-(IBAction)onAdvertise:(UIButton *)sender
{
	if([sender.currentTitle compare:START_ADVERTISING_TEXT] == NSOrderedSame)//Starting advertising
	{
		[[CPeripheralManager thePeripheralManager] advertiseTheServices];
		[sender setTitle:STOP_ADVERTISING_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:sender isStart:TRUE];
	}
	else if([sender.currentTitle compare:STOP_ADVERTISING_TEXT] == NSOrderedSame)
	{
		[[CPeripheralManager thePeripheralManager] stopAdvertisingTheServices];
		[sender setTitle:START_ADVERTISING_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:sender isStart:FALSE];
	}
}

-(void)layoutConditionViews
{
	[self layoutConditionView:nil viewToAdd:self.roadConditionsView];
	[self layoutConditionView:self.roadConditionsView viewToAdd:self.weatherEnvironmentView];
	[self layoutConditionView:self.weatherEnvironmentView viewToAdd:self.vehicleEnvironmentView];
}

-(void)layoutEventRecordingViews
{
	[self.eventViewParentView addConstraint:[NSLayoutConstraint constraintWithItem:self.startStopEventsView
																								attribute:NSLayoutAttributeTop
																								relatedBy:NSLayoutRelationEqual
																									toItem:self.eventViewParentView
																								attribute:NSLayoutAttributeTop
																							  multiplier:1.0
																								 constant:0.0]];
	
	[self.eventViewParentView addConstraint:[NSLayoutConstraint constraintWithItem:self.startStopEventsView
																								attribute:NSLayoutAttributeLeading
																								relatedBy:NSLayoutRelationEqual
																									toItem:self.eventViewParentView
																								attribute:NSLayoutAttributeLeading
																							  multiplier:1.0 constant:0.0]];
	
	[self.eventViewParentView addConstraint:[NSLayoutConstraint constraintWithItem:self.startStopEventsView
																								attribute:NSLayoutAttributeTrailing
																								relatedBy:NSLayoutRelationEqual
																									toItem:self.eventViewParentView
																								attribute:NSLayoutAttributeTrailing
																							  multiplier:1.0 constant:0.0]];

	[self.eventViewParentView addConstraint:[NSLayoutConstraint constraintWithItem:self.startStopEventsView
																								attribute:NSLayoutAttributeBottom
																								relatedBy:NSLayoutRelationEqual
																									toItem:self.btnStartStopAdvertising
																								attribute:NSLayoutAttributeTop
																							  multiplier:1.0 constant:-8.0]];
}

-(void)layoutConditionView:(UIView *)leadingView viewToAdd:(UIView *)viewAddingIn
{
	UIView *theLeadingView = leadingView;

	if(theLeadingView == nil)
	{
		theLeadingView = self.conditionViewsParentScrollView;

		[self.conditionViewsParentScrollView addConstraint:[NSLayoutConstraint constraintWithItem:viewAddingIn
																												  attribute:NSLayoutAttributeLeading
																												  relatedBy:NSLayoutRelationEqual
																													  toItem:self.conditionViewsParentScrollView
																												  attribute:NSLayoutAttributeLeading
																												 multiplier:1.0
																													constant:0.0]];
	}
	else
	{
		[self.conditionViewsParentScrollView addConstraint:[NSLayoutConstraint constraintWithItem:viewAddingIn
																												  attribute:NSLayoutAttributeLeading
																												  relatedBy:NSLayoutRelationEqual
																													  toItem:theLeadingView
																												  attribute:NSLayoutAttributeTrailing
																												 multiplier:1.0
																													constant:0.0]];
	}

	[self.conditionViewsParentScrollView addConstraint:[NSLayoutConstraint constraintWithItem:viewAddingIn
																											  attribute:NSLayoutAttributeTop
																											  relatedBy:NSLayoutRelationEqual
																												  toItem:self.conditionViewsParentScrollView
																											  attribute:NSLayoutAttributeTop
																											 multiplier:1.0 constant:0.0]];

	[self.conditionViewsParentScrollView addConstraint: [NSLayoutConstraint constraintWithItem:viewAddingIn
																												attribute:NSLayoutAttributeWidth
																												relatedBy:NSLayoutRelationEqual
																													toItem:self.conditionViewsParentScrollView
																												attribute:NSLayoutAttributeWidth
																											  multiplier:1.0
																												 constant:0.0]]; //]self.conditionViewsParentScrollView.bounds.size.width]];

	[self.conditionViewsParentScrollView addConstraint: [NSLayoutConstraint constraintWithItem:viewAddingIn
																												attribute:NSLayoutAttributeHeight
																												relatedBy:NSLayoutRelationEqual
																													toItem:self.conditionViewsParentScrollView
																												attribute:NSLayoutAttributeHeight
																											  multiplier:1.0
																												 constant:0.0]];

	if(viewAddingIn == self.vehicleEnvironmentView)
	{
		[self.conditionViewsParentScrollView addConstraint: [NSLayoutConstraint constraintWithItem:viewAddingIn
																													attribute:NSLayoutAttributeTrailing
																													relatedBy:NSLayoutRelationEqual
																														toItem:self.conditionViewsParentScrollView
																													attribute:NSLayoutAttributeTrailing
																												  multiplier:1.0
																													 constant:0.0]];
	}
}

-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop
{
	btn.layer.cornerRadius = 10.0f;
	btn.layer.masksToBounds = TRUE;

	if(bIsStartOrStop == TRUE)//If you're starting
		btn.layer.borderColor = [[UIColor redColor]CGColor];
	else
		btn.layer.borderColor = [[UIColor colorWithRed:206.0 / 255.0 green:206.0 / 255.0 blue:206.0 / 255.0 alpha:1.0]CGColor];

	btn.layer.borderWidth = 5.0f;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//Called when scroll view grinds to a halt
{
	int offset = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;

	self.pageIndicator.currentPage = offset;
}

@end
