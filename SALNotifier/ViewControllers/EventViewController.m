//
//  EventViewController.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/28/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "EventViewController.h"
#import "StartStopEventsView.h"

@interface EventViewController ()
	@property(nonatomic, strong) StartStopEventsView *startStopEventsView;
@end

@implementation EventViewController

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

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self layoutEventRecordingViews];
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
																			toItem:self.eventViewParentView
																		 attribute:NSLayoutAttributeBottom
																		multiplier:1.0 constant:0.0]];
}


@end
