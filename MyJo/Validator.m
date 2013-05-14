//
//  Validator.m
//  MyJo
//
//  Created by Yassin Gamal on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Validator.h"

@implementation Validator



- (BOOL) isBlankTitle: (NSString *) title{
    if([title length ]== 0)
        return YES;
    return NO;
}

- (BOOL) isLongTitle: (NSString *) title{
    if([title length]>18)
        return YES;
    return NO;
}

- (BOOL) isProperPassword: (NSString *) password
{
    if([password length] < 5|| [password length] > 12)
        return NO;

        return YES;
}



@end
