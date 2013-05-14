//
//  JournalView.h
//  MyJo
//
//  Created by Yassin Gamal on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"
#import "OpenAppViewController.h"

@interface JournalView : UIView <UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *coverImage;
@property (retain, nonatomic) IBOutlet UILabel *journalTitle;
@property (retain, nonatomic) IBOutlet UIImageView *lockec;
@property (retain, nonatomic)  Journal  *journal;


@property (retain, nonatomic)  OpenAppViewController*controller;
@property (retain, nonatomic) IBOutlet UIButton *deleteIcon;
@property (retain, nonatomic) IBOutlet UIImageView *border;
- (IBAction)ChooseJournal:(id)sender;

- (IBAction)longTap:(id)sender;
- (IBAction)deleteJournal:(id)sender;

@end

