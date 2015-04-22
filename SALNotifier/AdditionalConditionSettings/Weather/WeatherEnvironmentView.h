/*
//  WeatherEnvironmentView.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/6/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface WeatherEnvironmentView : UIView<UITextFieldDelegate>
	@property(nonatomic, weak) IBOutlet UIView *backingView;

	@property(nonatomic, weak) IBOutlet UITextField *txtbxTemperature;
@end
