//
//  TicketsViewController.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "TicketsViewController.h"
#import "TicketsViewModel.h"
#import "UIView+Animation.h"

@interface TicketsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    BOOL animating;
    CGPoint startDragOffset;
}

@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) TicketsViewModel *ticketsViewModel;
@property (weak, nonatomic) IBOutlet UIButton *trainButton;
@property (weak, nonatomic) IBOutlet UIButton *busButton;
@property (weak, nonatomic) IBOutlet UIButton *flightButton;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation TicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ticketsViewModel = [[TicketsViewModel alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareForAnimation];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animateIn];
}

#pragma mark - Animations

-(void)prepareForAnimation{
    self.contentView.hidden = true;
}

-(void)animateIn{
    self.contentView.hidden = false;
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.view.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.view.frame.size.height-self.contentView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
        self.contentView.transform = CGAffineTransformMakeScale(1.04, 1.04);
    } completion:^(BOOL finished) {
        if(finished){
            [UIView animateWithDuration:0.1 animations:^{
                self.contentView.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }
    }];
}

#pragma mark - Events

- (IBAction)trainButtonPressed:(id)sender {
    [sender animateTouchDownWithCompletion:nil];
    [self updateTicketType:TrainTicket shouldScroll:true];
}

- (IBAction)busButtonPressed:(id)sender {
    [sender animateTouchDownWithCompletion:nil];
    [self updateTicketType:BusTicket shouldScroll:true];
}

- (IBAction)flightButtonPressed:(id)sender {
    [sender animateTouchDownWithCompletion:nil];
    [self updateTicketType:FlightTicket shouldScroll:true];
}

- (void)updateTicketType:(TicketType)type shouldScroll:(BOOL)shouldScroll{
    if(animating)
        return;
    animating = true;
    
    self.ticketsViewModel.selectedTicketType = type;
    
    if(shouldScroll)
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.ticketsViewModel.selectedTicketType inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
    self.trainButton.selected = false;
    self.busButton.selected = false;
    self.flightButton.selected = false;
    
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = true;
    
    [UIView animateWithDuration:0.2f animations:^{
        switch (self.ticketsViewModel.selectedTicketType) {
            case TrainTicket:
                self.trainButton.selected = true;
                self.indicatorView.center = CGPointMake(self.trainButton.center.x, self.indicatorView.center.y);
                break;
            case BusTicket:
                self.busButton.selected = true;
                self.indicatorView.center = CGPointMake(self.busButton.center.x, self.indicatorView.center.y);
                break;
            case FlightTicket:
                self.flightButton.selected = true;
                self.indicatorView.center = CGPointMake(self.flightButton.center.x, self.indicatorView.center.y);
                break;
        }
    }completion:^(BOOL finished) {
        animating = false;
    }];
}

#pragma mark - CollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _ticketsViewModel.transportationCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_ticketsViewModel transportationCellForIndexPath:indexPath collectionView:collectionView];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    startDragOffset = scrollView.contentOffset;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float moved = (self.collectionView.contentOffset.x / self.collectionView.frame.size.width);
    int currentPage = startDragOffset.x > scrollView.contentOffset.x ? floor(moved) : ceil(moved);
    
    [self updateTicketType:currentPage shouldScroll:false];
}

@end

