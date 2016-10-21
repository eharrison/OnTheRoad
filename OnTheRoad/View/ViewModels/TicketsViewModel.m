//
//  TicketsViewModel.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "TicketsViewModel.h"
#import "TransportationCollectionViewCell.h"

@implementation TicketsViewModel

#pragma mark - Transportation Options

-(int)transportationCount{
    return 3;
}

-(UICollectionViewCell*)transportationCellForIndexPath:(NSIndexPath*)indexPath collectionView:(UICollectionView*)collectionView{
    TransportationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"transportation" forIndexPath:indexPath];
    
    [cell configWithTicketsViewModel:[self ticketsViewModelForIndexPath:indexPath]];
    
    return cell;
}

-(TicketsViewModel*)ticketsViewModelForIndexPath:(NSIndexPath*)indexPath{
    TicketsViewModel *ticketsViewModel = [[TicketsViewModel alloc] init];
    ticketsViewModel.selectedTicketType = (TicketType)indexPath.row;
    return ticketsViewModel;
}

#pragma mark - Tickets

-(int)ticketCount{
    return 10;
}

-(UITableViewCell*)ticketCellForIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketOption" forIndexPath:indexPath];
    
    return cell;
}

@end
