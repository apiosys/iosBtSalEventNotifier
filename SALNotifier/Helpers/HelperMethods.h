/*
//  HelperMethods.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 1/23/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import <Foundation/Foundation.h>

#import "Defs.h"

@interface HelperMethods : NSObject

+(double)celciusToFahrenheit:(double)dCelcius;
+(double)fahrenheitToCelcius:(double)dFahrenheit;

+(BOOL)stringToDouble:(NSString *)strVal derivedDoubleValue:(double *)dVal;
+(NSString *)notificationEnumToString:(NOTIFICATION_EVENTS)eNotificationEvent;

@end
