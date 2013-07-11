//
//  REDPuzzleGridTile.h
//  Word Puzzle Grid
//
//  Created by Red Davis on 10/07/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface REDPuzzleGridTile : UIView

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic, readonly) UILabel *textLabel;
@property (assign, nonatomic) BOOL selected;

@end
