//
//  TicketsViewModel.h
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TicketsViewModel : NSObject

@property (nonatomic, assign) TicketType selectedTicketType;
@property (nonatomic, assign) bool sortTicketsAscending;

#pragma mark - Data

-(void)fetchTickets:(void (^)())success failure:(void (^)())failure;
-(NSArray*)tickets;

#pragma mark - Transportation Options

-(int)transportationCount;
-(UICollectionViewCell*)transportationCellForIndexPath:(NSIndexPath*)indexPath collectionView:(UICollectionView*)collectionView;
-(TicketsViewModel*)ticketsViewModelForIndexPath:(NSIndexPath*)indexPath;

#pragma mark - Tickets

-(NSUInteger)ticketCount;
-(UITableViewCell*)ticketCellForIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView;
-(void)willDisplayCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end
