//
//  FontViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontViewControllerDelegate;
@interface FontViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{
     NSArray *firstColPicker;
     NSArray *secondColPicker;
    
    
}

@property (retain, nonatomic) IBOutlet UIPickerView *fontPicker;
@property (retain, nonatomic) IBOutlet UIButton *black;
@property (retain, nonatomic) IBOutlet UIButton *lightBlack;
@property (retain, nonatomic) IBOutlet UIButton *darkGrey;
@property (retain, nonatomic) IBOutlet UIButton *grey;
@property (retain, nonatomic) IBOutlet UIButton *red;
@property (retain, nonatomic) IBOutlet UIButton *yellow;
@property (retain, nonatomic) IBOutlet UIButton *green;
@property (retain, nonatomic) IBOutlet UIButton *blue;

@property (retain, nonatomic) IBOutlet UIButton *voilet;
@property (retain, nonatomic) IBOutlet UIButton *orange;
@property (retain, nonatomic) IBOutlet UIButton *purple;

@property (retain, nonatomic) IBOutlet UIButton *brown;


@property (retain, nonatomic) IBOutlet UIButton *lastColor;

@property (retain, nonatomic) IBOutlet UIButton *bold;

@property (retain, nonatomic) IBOutlet UIButton *regular;
@property (retain, nonatomic) IBOutlet UIButton *italic;

@property (retain, nonatomic) NSString* fontName;
@property (retain, nonatomic) NSString* fontColor;
@property  BOOL isBold;
@property  BOOL isItalic;
@property NSInteger fontsize;
@property BOOL isAll;
@property (strong, nonatomic) id <FontViewControllerDelegate> delegate;





- (IBAction)black:(id)sender;
- (IBAction)lightBlack:(id)sender;
- (IBAction)darkGrey:(id)sender;

- (IBAction)grey:(id)sender;
- (IBAction)red:(id)sender;
- (IBAction)yellow:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)blue:(id)sender;
- (IBAction)voilet:(id)sender;
- (IBAction)orange:(id)sender;
- (IBAction)purple:(id)sender;
- (IBAction)brown:(id)sender;
- (IBAction)bold:(id)sender;
- (IBAction)regular:(id)sender;
- (IBAction)italic:(id)sender;



@end


@protocol FontViewControllerDelegate <NSObject>
- (void)fontViewControllerDidFinish:(FontViewController *)controller fontName:(NSString *)fontName fontSize:(NSInteger) fontSize fontColor:(NSString*) fontColor  isBold:(BOOL) isBold isItalic:(BOOL) isitalic;
@end
