//
//  EventAction.h
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/29/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventAction : NSObject

	@property(readonly) NSString * displayLabel;
	@property(readonly)	BOOL isStarted;
	@property(readonly) NSString * eventTag;

	+(NSArray *) allEventActions;

	-(void) sendAction;

@end
