//
//  REDPuzzleGridTile.m
//  Word Puzzle Grid
//
//  Created by Red Davis on 10/07/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "REDPuzzleGridTile.h"


@interface REDPuzzleGridTile ()

@property (strong, nonatomic) UILabel *textLabel;

@end


@implementation REDPuzzleGridTile

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.selected = NO;
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont boldSystemFontOfSize:16];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
    }
    
    return self;
}

#pragma mark - View Setup

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    self.textLabel.frame = bounds;
}

#pragma mark -

- (void)setSelected:(BOOL)selected
{
    if (selected)
        self.backgroundColor = [UIColor blueColor];
    else
        self.backgroundColor = [UIColor yellowColor];
}

@end
