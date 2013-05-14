//
//  Validator.h
//  MyJo
//
//  Created by Yassin Gamal on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Validator : NSObject


- (BOOL) isBlankTitle: (NSString *) title;
- (BOOL) isLongTitle: (NSString *) title;

- (BOOL) isProperPassword: (NSString *) password;

@end
