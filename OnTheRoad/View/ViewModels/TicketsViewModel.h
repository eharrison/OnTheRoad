//
//  TicketsViewModel.h
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    TrainTicket,
    BusTicket,
    FlightTicket
}TicketType;

@interface TicketsViewModel : NSObject

@property (nonatomic, assign) TicketType selectedTicketType;

#pragma mark - Transportation Options

-(int)transportationCount;
-(UICollectionViewCell*)transportationCellForIndexPath:(NSIndexPath*)indexPath collectionView:(UICollectionView*)collectionView;
-(TicketsViewModel*)ticketsViewModelForIndexPath:(NSIndexPath*)indexPath;

#pragma mark - Tickets

-(int)ticketCount;
-(UITableViewCell*)ticketCellForIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView;

@end
