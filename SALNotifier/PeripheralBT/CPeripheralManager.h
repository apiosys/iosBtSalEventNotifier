/*
//  CPeripheralManager.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

@protocol RemoteDataCollectionDelegate <NSObject>

	@optional
	-(void) centralDidSubscribeForRemoteDataCollection:(CBCentral*)central ;
	-(void) centralDidUnsubscribeForRemoteDataCollection:(CBCentral*)central ;

@end

@interface CPeripheralManager : NSObject<CBPeripheralManagerDelegate>

+(CPeripheralManager *)thePeripheralManager;

-(void)advertiseTheServices;
-(void)stopAdvertisingTheServices;

-(void)sendEventNotificationMessage:(NSString *)messageNotificationVal;

-(void) startDataCapture;
-(void) stopDataCapture;

-(NSArray*) allRemoteDataCollectionDelegates;
-(void) addRemoteDataCollectionDelegate:(id<RemoteDataCollectionDelegate>) delegate;
-(void) removeRemoteDataCollectionDelegate:(id<RemoteDataCollectionDelegate>) delegate;
-(void) removeAllRemoteDataCollectionDelegates;

@end
