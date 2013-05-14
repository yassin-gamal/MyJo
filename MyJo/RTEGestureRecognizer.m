//
//  RTEGestureRecognizer.m
//  MyJo
//
//  Created by Yassin Gamal on 9/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTEGestureRecognizer.h"

@implementation RTEGestureRecognizer
@synthesize touchesBeganCallback;
@synthesize touchesEndedCallback;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchesBeganCallback)
        touchesBeganCallback(touches, event);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchesEndedCallback)
        touchesEndedCallback(touches, event); 
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer {
    if ([[preventingGestureRecognizer description] rangeOfString:@"UIScrollViewPanGestureRecognizer"].location != NSNotFound)
        return NO;
    return YES;
}

@end
