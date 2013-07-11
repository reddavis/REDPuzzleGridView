//
//  REDPuzzleGridView.m
//  Word Puzzle Grid
//
//  Created by Red Davis on 08/07/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "REDPuzzleGridView.h"
#import "REDPuzzleGridTile.h"
#import "REDTapDownGestureRecognizer.h"


@interface REDPuzzleGridView () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSArray *tileRows;
@property (assign, nonatomic) CGSize tileSize;
@property (strong, nonatomic) NSMutableOrderedSet *selectedTiles;

- (BOOL)puzzleGridTile:(REDPuzzleGridTile *)tile isNextToTile:(REDPuzzleGridTile *)otherTile;

- (void)panGestureEngadged:(UIGestureRecognizer *)gesture;
- (void)tapGestureEngadged:(UIGestureRecognizer *)gesture;
- (void)tapDownGestureEngadged:(UIGestureRecognizer *)gesture;

@end


@implementation REDPuzzleGridView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.selectedTiles = [NSMutableOrderedSet orderedSet];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureEngadged:)];
        panGesture.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panGesture];
    }
    
    return self;
}

#pragma mark - View Setup

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSInteger numberOfColumns = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfColumnsInPuzzleGridView:)])
        numberOfColumns = [self.dataSource numberOfColumnsInPuzzleGridView:self];
    
    NSInteger numberOfRows = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInPuzzleGridView:)])
        numberOfRows = [self.dataSource numberOfRowsInPuzzleGridView:self];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sizeOfTileInPuzzleGridView:)])
        self.tileSize = [self.dataSource sizeOfTileInPuzzleGridView:self];
    
    if (!numberOfColumns || !numberOfRows || CGSizeEqualToSize(self.tileSize, CGSizeZero))
        return;
        
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Create tiles
    NSMutableArray *tileRows = [NSMutableArray array];
    for (NSUInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++)
    {
        NSMutableArray *row = [NSMutableArray array];
        for (NSUInteger columnIndex = 0; columnIndex < numberOfColumns; columnIndex++)
        {
            REDPuzzleGridTile *tile = nil;
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(puzzleGridView:tileForIndexPath:)])
            {
                NSIndexPath *tileIndexPath = [NSIndexPath indexPathForRow:rowIndex inSection:columnIndex];
                tile = [self.dataSource puzzleGridView:self tileForIndexPath:tileIndexPath];
                tile.indexPath = tileIndexPath;
            }
            
            NSAssert(tile && [tile isMemberOfClass:[REDPuzzleGridTile class]], @"WPPuzzleGridViewDataSource must return a WPPuzzleGridTile subclass");
            
            REDTapDownGestureRecognizer *tapDownGesture = [[REDTapDownGestureRecognizer alloc] initWithTarget:self action:@selector(tapDownGestureEngadged:)];
            tapDownGesture.delegate = self;
            [tile addGestureRecognizer:tapDownGesture];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEngadged:)];
            tapGesture.delegate = self;
            [tile addGestureRecognizer:tapGesture];
            
            [self addSubview:tile];
            [row addObject:tile];
        }
        
        [tileRows addObject:row];
    }
    
    self.tileRows = [NSArray arrayWithArray:tileRows];
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    static CGFloat const kPaddingBetweenCells = 10.0;
    
    CGPoint tilePosition = CGPointZero;
    for (NSArray *row in self.tileRows)
    {
        UIView *lastTile = [row lastObject];
        for (UILabel *tile in row)
        {
            tile.frame = CGRectMake(tilePosition.x, tilePosition.y, self.tileSize.width, self.tileSize.height);
            
            if (tile == lastTile)
                tilePosition.x += tile.frame.size.width;
            else
                tilePosition.x += tile.frame.size.width + kPaddingBetweenCells;
        }
        
        NSArray *lastRow = [self.tileRows lastObject];
        if (row == lastRow)
        {
            tilePosition.y += self.tileSize.height;
       }
        else
        {
            tilePosition.y += self.tileSize.height + kPaddingBetweenCells;
            tilePosition.x = 0.0;
        }
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, tilePosition.x, tilePosition.y);
}

#pragma mark -

- (BOOL)puzzleGridTile:(REDPuzzleGridTile *)tile isNextToTile:(REDPuzzleGridTile *)otherTile
{
    NSIndexPath *tileIndexPath = tile.indexPath;
    NSIndexPath *otherTileIndexPath = otherTile.indexPath;
    
    NSInteger rowDifference = fabs(tileIndexPath.row - otherTileIndexPath.row);
    NSInteger columnDifference = fabs(tileIndexPath.section - otherTileIndexPath.section);
    
    return (rowDifference < 2 && columnDifference < 2);
}

#pragma mark - Gestures

- (void)panGestureEngadged:(UIGestureRecognizer *)gesture
{
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gesture;
    if (panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translatedPoint = [panGesture locationInView:self];
        REDPuzzleGridTile *tile = (REDPuzzleGridTile *)[self hitTest:translatedPoint withEvent:nil];
        
        if ([tile isMemberOfClass:[REDPuzzleGridTile class]])
        {
            REDPuzzleGridTile *lastTile = [self.selectedTiles lastObject];
            if ([self puzzleGridTile:lastTile isNextToTile:tile])
            {
                tile.selected = YES;
                [self.selectedTiles addObject:tile];
            }
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(puzzleGridView:didSelectTiles:)]) {
            [self.delegate puzzleGridView:self didSelectTiles:self.selectedTiles.array];
        }
        
        for (REDPuzzleGridTile *selectedTile in self.selectedTiles)
            selectedTile.selected = NO;
        
        [self.selectedTiles removeAllObjects];
    }
}

- (void)tapGestureEngadged:(UIGestureRecognizer *)gesture
{
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;
    if (tapGesture.state == UIGestureRecognizerStateEnded)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(puzzleGridView:didSelectTiles:)]) {
            [self.delegate puzzleGridView:self didSelectTiles:self.selectedTiles.array];
        }
        
        for (REDPuzzleGridTile *selectedTile in self.selectedTiles)
            selectedTile.selected = NO;
        
        [self.selectedTiles removeAllObjects];
    }
}

- (void)tapDownGestureEngadged:(UIGestureRecognizer *)gesture
{
    REDTapDownGestureRecognizer *tapDownGesture = (REDTapDownGestureRecognizer *)gesture;
    if (tapDownGesture.state == UIGestureRecognizerStateRecognized)
    {
        REDPuzzleGridTile *tile = (REDPuzzleGridTile *)tapDownGesture.view;
        tile.selected = YES;
        [self.selectedTiles addObject:tile];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
