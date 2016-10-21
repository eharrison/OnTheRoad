//
//  TicketsViewModel.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "TicketsViewModel.h"
#import "TransportationCollectionViewCell.h"
#import "APIManager.h"
#import "OnTheRoad-swift.h"
#import "TicketOptionTableViewCell.h"
#import "NSDate+Custom.h"

@implementation TicketsViewModel

#pragma mark - Data

-(void)fetchTickets:(void (^)())success failure:(void (^)())failure{
    [APIManager fetchTicketsWithType:self.selectedTicketType success:^(NSArray* tickets){
        success();
    } failure:^{
        failure();
    }];
}

-(NSArray *)tickets{
    return [Ticket ticketsWithType:self.selectedTicketType];
}

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

-(NSUInteger)ticketCount{
    return self.tickets.count;
}

-(UITableViewCell*)ticketCellForIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView{
    TicketOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketOption" forIndexPath:indexPath];
    
    Ticket *ticket = [self.tickets objectAtIndex:indexPath.row];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f", ticket.priceInEuros.doubleValue];
    cell.departureLabel.text = [ticket.departureTime dateToStringWithFormat:@"HH:mm"];
    cell.arrivalLabel.text = [ticket.arrivalTime dateToStringWithFormat:@"HH:mm"];
    
    NSTimeInterval duration = [ticket.arrivalTime timeIntervalSinceDate:ticket.departureTime];
    cell.durationLabel.text = [NSDate timeFormatted:duration];
    
    cell.stopsLabel.text = NSLocalizedString(@"Direct", @"");
    if (ticket.numberOfStops.intValue == 1)
        cell.stopsLabel.text = NSLocalizedString(@"1 stop", @"");
    else if (ticket.numberOfStops.intValue > 1)
        cell.stopsLabel.text = [NSString stringWithFormat:@"%d %@", ticket.numberOfStops.intValue, NSLocalizedString(@"stops", @"")];
    
    return cell;
}

-(void)willDisplayCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    if ([cell isKindOfClass:[TicketOptionTableViewCell class]]){
        Ticket *ticket = [self.tickets objectAtIndex:indexPath.row];
        
        NSString *logo = [ticket.providerLogo stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
        [((TicketOptionTableViewCell*)cell).companyImageView setImage:logo thumbnailUrl:nil placeholder:nil completion:nil];
    }
}

@end
