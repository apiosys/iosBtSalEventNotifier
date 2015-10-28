//
//  ConditionsViewController.h
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/28/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionsViewController : UIViewController<UIScrollViewDelegate>

	@property(nonatomic, weak) IBOutlet UIPageControl *pageIndicator;
	@property(nonatomic, weak) IBOutlet UIScrollView *conditionViewsParentScrollView;

@end
