//
//  RTEGestureRecognizer.h
//  MyJo
//
//  Created by Yassin Gamal on 9/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef void (^TouchEventBlock)(NSSet * touches, UIEvent * event);

@interface RTEGestureRecognizer : UIGestureRecognizer {
    TouchEventBlock touchesBeganCallback;
    TouchEventBlock touchesEndedCallback;
}
@property(copy) TouchEventBlock touchesBeganCallback;
@property(copy) TouchEventBlock touchesEndedCallback;
@end
