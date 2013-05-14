//
//  CustomPopoverBackgroundView.h
//  MyJo
//
//  Created by Yassin Gamal on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPopoverBackgroundView : UIPopoverBackgroundView {
    UIImage* image;
    UIImageView *_borderImageView;
    UIImageView *_arrowView;
    CGFloat _arrowOffset;
    UIPopoverArrowDirection _arrowDirection;
}

@end