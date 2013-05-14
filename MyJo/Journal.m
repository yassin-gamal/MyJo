//
//  Journal.m
//  MyJo
//
//  Created by Yassin Gamal on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Journal.h"

@implementation Journal
@synthesize title;
@synthesize coverImage;
@synthesize color;
@synthesize background;
@synthesize password;
@synthesize index = _index;


- (id)initWithTitle:(NSString *)title1 password:(NSString *) password1 color:(NSString *)color1 background:(NSString*) background1 cover:(UIImage *)image1
{
    self = [super init];
    if(self){
        self.title = title1;
        self.color = color1;
        self.background = background1;
        self.coverImage = image1;
        self.password = password1;
        hasPassword = YES;
        return self;
    }
    return nil;
}



- (id)initWithTitle:(NSString *)title1 color:(NSString *)color1 background:(NSString*) background1 cover:(UIImage *)image1
{
    self = [super init];
    if(self){
        self.title = title1;
        self.color = color1;
        self.background = background1;
        self.coverImage = image1;
        hasPassword= NO;
        return self;
    }
    return nil;
}




- (id)initWithCoder:(NSCoder *)aDecoder
{
	[super init];
	
	// decode properties with their names as keys
	self.title = [aDecoder decodeObjectForKey:@"title"];
	self.password = [aDecoder decodeObjectForKey:@"password"];
	self.coverImage = [aDecoder decodeObjectForKey:@"image"];
    self.color = [aDecoder decodeObjectForKey:@"color"];
    self.background = [aDecoder decodeObjectForKey:@"background"];
    self.index = [aDecoder decodeIntForKey:@"index"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	// encode properties with property name keys
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject:coverImage forKey:@"image"];
    [aCoder encodeObject:color forKey:@"color"];
    [aCoder encodeObject:background forKey:@"background"];
    [aCoder encodeInt: self.index forKey:@"index"];
}


@end
