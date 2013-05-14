//
//  ColorsViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ColorsViewControllerDelegate;

@interface ColorsViewController : UITableViewController
{
    NSIndexPath * previousIndexPath;
    
}

@property (strong,nonatomic) NSIndexPath *previousIndexPath;
@property (strong, nonatomic) id <ColorsViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UITableViewCell *white;
@property (retain, nonatomic) IBOutlet UIImageView *whiteImage;
@property (retain, nonatomic) IBOutlet UIImageView *cremeImage;
@property (retain, nonatomic) IBOutlet UIImageView *greyImage;
@property (retain, nonatomic) IBOutlet UIImageView *yellowImage;



- (IBAction)saveColor:(id)sender;
- (IBAction)cancelColor:(id)sender;
- (void) selectCell:(UITableViewCell *) color;
- (void) deselectCell:(UITableViewCell *) color;

@end


@protocol ColorsViewControllerDelegate <NSObject>
- (void)colorsViewControllerDidCancel:(ColorsViewController *)controller;
- (void)colorsViewControllerDidFinish:(ColorsViewController *)controller color:(NSString *)color;
@end

