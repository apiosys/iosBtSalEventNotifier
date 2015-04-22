/*
//  RoadConditionsView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "RoadConditionsView.h"

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

@end
