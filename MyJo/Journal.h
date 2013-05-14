//
//  Journal.h
//  MyJo
//
//  Created by Yassin Gamal on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Journal : NSObject <NSCoding>
{
    BOOL hasPassword;
}

@property(strong,atomic) NSString* title;
@property(strong,atomic) NSString* password;
@property(strong,atomic) UIImage *coverImage;
@property(strong,atomic) NSString* color;
@property(strong,atomic) NSString* background;
@property NSInteger index;



- (id)initWithTitle:(NSString *)title password:(NSString *) password color:(NSString *)color background:(NSString*) background cover:(UIImage *)image;


- (id)initWithTitle:(NSString *)title color:(NSString *)color background:(NSString*) background cover:(UIImage *)image;






@end
