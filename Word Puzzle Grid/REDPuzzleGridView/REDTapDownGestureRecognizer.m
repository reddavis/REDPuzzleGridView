//
//  REDTapDownGestureRecognizer.m
//  Word Puzzle Grid
//
//  Created by Red Davis on 11/07/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "REDTapDownGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@implementation REDTapDownGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.state == UIGestureRecognizerStatePossible)
        self.state = UIGestureRecognizerStateRecognized;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateFailed;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateFailed;
}

@end
