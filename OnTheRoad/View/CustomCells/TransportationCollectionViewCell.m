//
//  TransportationCollectionViewCell.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "TransportationCollectionViewCell.h"
#import "UIView+Animation.h"
#import "NSDate+Custom.h"
#import "OnTheRoad-swift.h"

@implementation TransportationCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)configWithTicketsViewModel:(TicketsViewModel*)ticketsViewModel{
    self.ticketsViewModel = ticketsViewModel;
    [self.tableView reloadData];
    
    //if no results, fetch from url
    if (self.ticketsViewModel.tickets.count == 0){
        [self startLoadingAnimation];
        [self.ticketsViewModel fetchTickets:^{
            [self stopLoadingAnimation];
            [self.tableView reloadData];
        } failure:^{
            [self stopLoadingAnimation];
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"failed_fetch_offers", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil] show];
        }];
    }
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ticketsViewModel.ticketCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.ticketsViewModel ticketCellForIndexPath:indexPath tableView:tableView];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.ticketsViewModel willDisplayCell:cell atIndexPath:indexPath];
    [cell.contentView animatePopUp];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath].contentView animateTouchDownWithCompletion:^{
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"offer_details_not_implemented", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil] show];
    }];
}

@end
