//
//  JournalPadView.h
//  MyJo
//
//  Created by Yassin Gamal on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"
#import "OpenAppViewController.h"


@interface JournalPadView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *coverImage;
@property (retain, nonatomic) IBOutlet UILabel *journalTitle;
@property (retain, nonatomic) IBOutlet UIImageView *locked;
@property (retain, nonatomic)  Journal  *journal;

@property (retain, nonatomic) OpenAppViewController *controller;
- (IBAction)deleteJournal:(id)sender;

@property (retain, nonatomic) IBOutlet UIImageView *border;
@property (retain, nonatomic) IBOutlet UIButton *deleteIcon;

- (IBAction)chooseJournal:(id)sender;
- (IBAction)longTap:(id)sender;


@end
