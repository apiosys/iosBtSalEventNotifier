//
//  EventCollectionViewController.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/28/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "EventCollectionViewController.h"
#import "EventAction.h"
#import "EventActionCollectionViewCell.h"

@interface EventCollectionViewController()
	@property(readonly) NSArray * eventActions;

	-(EventAction*)actionForIndexPath:(NSIndexPath*)path;
@end

@implementation EventCollectionViewController

-(void)viewDidLoad
{
	_eventActions = [EventAction allEventActions];
}

-(EventAction *)actionForIndexPath:(NSIndexPath *)path
{
	return self.eventActions[path.row];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.eventActions.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	EventActionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventActionCell" forIndexPath:indexPath];
	cell.eventAction = [self actionForIndexPath:indexPath];
	return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
	CGFloat width = collectionView.frame.size.width/2;
	if (width < 180)
	{
		width = collectionView.frame.size.width;
	}
	return (CGSize){.width = width, .height = 140.0};
}


@end
