//
//  REDPuzzleGridView.h
//  Word Puzzle Grid
//
//  Created by Red Davis on 08/07/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>


@class REDPuzzleGridTile;
@protocol REDPuzzleGridViewDataSource;
@protocol REDPuzzleGridViewDelegate;


@interface REDPuzzleGridView : UIView

@property (weak, nonatomic) id <REDPuzzleGridViewDataSource> dataSource;
@property (weak, nonatomic) id <REDPuzzleGridViewDelegate> delegate;

@end


@protocol REDPuzzleGridViewDataSource <NSObject>
- (NSInteger)numberOfRowsInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView;
- (NSInteger)numberOfColumnsInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView;
- (REDPuzzleGridTile *)puzzleGridView:(REDPuzzleGridView *)puzzleGridView tileForIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeOfTileInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView;
@end

@protocol REDPuzzleGridViewDelegate <NSObject>
@optional
- (void)puzzleGridView:(REDPuzzleGridView *)puzzleGridView didSelectTiles:(NSArray *)selectedCells;
@end
