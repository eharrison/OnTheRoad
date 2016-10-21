//
//  TransportationCollectionViewCell.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "TransportationCollectionViewCell.h"
#import "UIView+Animation.h"

@implementation TransportationCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)configWithTicketsViewModel:(TicketsViewModel*)ticketsViewModel{
    self.ticketsViewModel = ticketsViewModel;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ticketsViewModel.ticketCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.ticketsViewModel ticketCellForIndexPath:indexPath tableView:tableView];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell.contentView animatePopUp];
}

@end
