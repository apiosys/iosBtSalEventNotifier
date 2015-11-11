//
//  CRemoteDataCollectionService.h
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/2/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "DataCaptureCommand.h"

@interface CRemoteDataCollectionService : NSObject

	@property (nonatomic, readonly) CBMutableCharacteristic * commandCharacteristic;
	@property (nonatomic, readonly) CBMutableCharacteristic * dataCollectorIdentifierCharacteristic;
	@property (nonatomic, readonly) CBMutableCharacteristic * dataCollectorCollectionStatusCharacteristic;

	-(CBMutableService*)service;

-(void)enableDataCapture:(DATA_CAPTURE_COMMAND)startCapture on:(NSArray*)remoteDataCollector usingPeripheralManager:(CBPeripheralManager*) manager;

@end
