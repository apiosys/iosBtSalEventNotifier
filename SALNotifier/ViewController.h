/*
//  ViewController.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>
	@property(nonatomic, weak) IBOutlet UIView *eventViewParentView;
	@property(nonatomic, weak) IBOutlet UIPageControl *pageIndicator;
	@property(nonatomic, weak) IBOutlet UIScrollView *conditionViewsParentScrollView;
@end

