//
//  ConditionsViewController.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/28/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "ConditionsViewController.h"
#import "RoadConditionsView.h"
#import "VehicleEnvironmentView.h"
#import "WeatherEnvironmentView.h"

@interface ConditionsViewController ()
	@property(nonatomic ,strong) RoadConditionsView *roadConditionsView;
	@property(nonatomic ,strong) VehicleEnvironmentView *vehicleEnvironmentView;
	@property(nonatomic ,strong) WeatherEnvironmentView *weatherEnvironmentView;

@end

@implementation ConditionsViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.conditionViewsParentScrollView.layer.borderWidth = 1.0;
	self.conditionViewsParentScrollView.layer.borderColor = [UIColor blackColor].CGColor;
	[self layoutConditionViews];
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

-(void)layoutConditionViews
{
	[self layoutConditionView:nil viewToAdd:self.roadConditionsView];
	[self layoutConditionView:self.roadConditionsView viewToAdd:self.weatherEnvironmentView];
	[self layoutConditionView:self.weatherEnvironmentView viewToAdd:self.vehicleEnvironmentView];
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//Called when scroll view grinds to a halt
{
	//Due to some strangness with 6-plus devices not pinning constraints to the edge
	int ScrollViewOffset = scrollView.contentOffset.x - (((int)scrollView.contentOffset.x) % 100);
	int ScreenWidth = [UIScreen mainScreen].bounds.size.width - ((int)([UIScreen mainScreen].bounds.size.width) % 100);

	int offset = ScrollViewOffset / ScreenWidth;

	self.pageIndicator.currentPage = offset;
}

@end
