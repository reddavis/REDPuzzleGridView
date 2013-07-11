//
//  WPRootViewController.m
//  Word Puzzle Grid
//
//  Created by Red Davis on 08/07/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "WPRootViewController.h"
#import "REDPuzzleGridTile.h"
#import "REDPuzzleGridView.h"


@interface WPRootViewController () <REDPuzzleGridViewDataSource, REDPuzzleGridViewDelegate>

@property (strong, nonatomic) REDPuzzleGridView *puzzleGridView;

@end


@implementation WPRootViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.puzzleGridView = [[REDPuzzleGridView alloc] initWithFrame:CGRectZero];
    self.puzzleGridView.dataSource = self;
    self.puzzleGridView.delegate = self;
    [self.view addSubview:self.puzzleGridView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{    
    CGFloat puzzleGridXCoor = floorf(self.view.frame.size.width/2.0-self.puzzleGridView.frame.size.width/2.0);
    self.puzzleGridView.frame = CGRectMake(puzzleGridXCoor, 50.0, self.puzzleGridView.frame.size.width, self.puzzleGridView.frame.size.height);
}

#pragma mark - WPPuzzleGridViewDataSource

- (NSInteger)numberOfColumnsInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView
{
    return 4;
}

- (NSInteger)numberOfRowsInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView
{
    return 4;
}

- (REDPuzzleGridTile *)puzzleGridView:(REDPuzzleGridView *)puzzleGridView tileForIndexPath:(NSIndexPath *)indexPath
{
    REDPuzzleGridTile *tile = [[REDPuzzleGridTile alloc] init];
    tile.textLabel.text = @"A";
    
    return tile;
}

- (CGSize)sizeOfTileInPuzzleGridView:(REDPuzzleGridView *)puzzleGridView
{
    return CGSizeMake(60.0, 60.0);
}

- (NSString *)puzzleGridView:(REDPuzzleGridView *)puzzleGridView titleForTileAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Hello";
}

#pragma mark - WPPuzzleGridViewDelegate

@end
