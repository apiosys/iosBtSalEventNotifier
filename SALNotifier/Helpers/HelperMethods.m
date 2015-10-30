/*
//  HelperMethods.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 1/23/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "HelperMethods.h"
#import "ConstantDefines.h"

@implementation HelperMethods


+(double)celciusToFahrenheit:(double)dCelcius
{
	//Degrees Fahrenheit (°F) is equal to the Degrees Celsius (°C) * 9/5 plus 32:
	return (dCelcius * 9.0) / 5.0 + 32;
}

+(double)fahrenheitToCelcius:(double)dFahrenheit
{
	//Degrees Celsius (°C) is equal to the Degrees Fahrenheit (°F) minus 32, times 5/9:
	return (dFahrenheit - 32.0) * (5.0/9.0);
}

+(BOOL)stringToDouble:(NSString *)strVal derivedDoubleValue:(double *)dVal
{
	BOOL bStat = TRUE;
	
	double dCalcVal = 0.0;
	
	if( (strVal == nil) || (strVal.length <= 0) )
		return FALSE;
	
	@try
	{
		strVal = [strVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		strVal = [strVal stringByReplacingOccurrencesOfString:@" " withString:@""];
		
		NSScanner* scan = [NSScanner scannerWithString:strVal];
		
		bStat &= ([scan scanDouble:&dCalcVal] && [scan isAtEnd]);
		bStat &= (dCalcVal > 0.0);
	}//End try
	@catch(NSException *exception)
	{
		dCalcVal = 0.0;
		bStat = FALSE;
		NSLog(@"Exception in \"stringToInt\" - %@", exception.debugDescription);
	}//End catch
	
	*dVal = dCalcVal;
	
	return bStat;
}//End

@end
