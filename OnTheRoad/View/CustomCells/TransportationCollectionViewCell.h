//
//  TransportationCollectionViewCell.h
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketsViewModel.h"

@interface TransportationCollectionViewCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TicketsViewModel *ticketsViewModel;

-(void)configWithTicketsViewModel:(TicketsViewModel*)ticketsViewModel;

@end
