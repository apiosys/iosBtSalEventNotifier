//
//  EventActionCollectionViewCell.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/29/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "EventActionCollectionViewCell.h"

@interface EventActionCollectionViewCell()
	@property (weak, nonatomic) IBOutlet UIView *buttonView;
	@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
	@property (weak, nonatomic) IBOutlet UILabel *startStopLabel;
	@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@end

@implementation EventActionCollectionViewCell

-(void)setEventAction:(EventAction *)eventAction
{
	_eventAction = eventAction;
	[self layoutEventAction:eventAction];
}

-(NSString*) startStopLabelText:(BOOL)isStarted
{
	return isStarted ? @"Stop" : @"Start";
}

-(void)layoutEventAction:(EventAction*) eventAction
{
	self.displayLabel.text = eventAction.displayLabel;
	self.startStopLabel.text = [self startStopLabelText:eventAction.isStarted];
	self.tagLabel.text = [NSString stringWithFormat:@"(%@)",eventAction.eventTag];
	[self configureButtonBackground:self.buttonView eventAction:eventAction];

}

-(void)configureButtonBackground:(UIView *) buttonView eventAction:(EventAction*) action
{
	buttonView.layer.cornerRadius = 15.0f;
	buttonView.layer.masksToBounds = TRUE;
	buttonView.layer.borderWidth = 3.0f;

	if (action.isStarted)
	{
		buttonView.layer.borderColor = [UIColor redColor].CGColor;
	}
	else
	{
		buttonView.layer.borderColor = [UIColor colorWithRed:67/255.0 green:172/255.0 blue:106/255.0 alpha:1].CGColor;
	}
}
- (IBAction)sendAction:(id)sender
{
	[self.eventAction sendAction];
	[self layoutEventAction:self.eventAction];
}

@end
