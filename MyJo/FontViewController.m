//
//  FontViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FontViewController.h"
#import "QuartzCore/CALayer.h"

@interface FontViewController ()
-(UIColor*)colorWithHexString:(NSString*)hex;  

@end

@implementation FontViewController
@synthesize fontPicker;
@synthesize black;
@synthesize lightBlack;
@synthesize darkGrey;
@synthesize grey;
@synthesize red;
@synthesize yellow;
@synthesize green;
@synthesize blue;
@synthesize voilet;
@synthesize orange;
@synthesize purple;
@synthesize brown;
@synthesize lastColor;

@synthesize bold;
@synthesize regular;
@synthesize italic;
@synthesize fontName;
@synthesize fontsize;
@synthesize fontColor;
@synthesize isBold;
@synthesize isItalic;
@synthesize delegate;
@synthesize isAll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    firstColPicker = [[NSArray alloc] initWithObjects:@"Amaranth",@"Arimo",@"Blokletters-Potlood",@"Cabinsketch",@"Chantelli-Antiqua",@"Dancing script ot",@"Desyrel",@"East Market",@"Inconsolata",@"Jr Hand",@"Latin Modern Roman",@"Lilly",@"Mountains of Christmas",@"Open Sans",@"Pacifico",@"SF Cartoonist hand",@"SF Slapstick Comic",@"sofia",@"TeX Gyre Cursor",@"Wagnasty",nil];
    secondColPicker = [[NSArray alloc] initWithObjects:@"14",@"16",@"18",@"20",@"22",@"24",@"26",@"28",@"30",@"36",@"42",nil];
    [fontPicker setDelegate:self];
    [fontPicker setDataSource:self];
    [fontPicker selectRow:13 inComponent:0 animated:NO];
    [fontPicker selectRow:1 inComponent:1 animated:NO];
    //    [fontPicker setShowsSelectionIndicator:NO];
    
    
    
    [black setBackgroundColor:[self colorWithHexString:@"000000"]];
    [lightBlack setBackgroundColor:[self colorWithHexString:@"333333"]];
    [darkGrey setBackgroundColor:[self colorWithHexString:@"666666"]];
    [grey setBackgroundColor:[self colorWithHexString:@"999999"]];
    
    [red setBackgroundColor:[self colorWithHexString:@"e3051b"]];
    [yellow setBackgroundColor:[self colorWithHexString:@"fcee21"]];
    [green setBackgroundColor:[self colorWithHexString:@"179f38"]];
    [blue setBackgroundColor:[self colorWithHexString:@"09a5db"]];
    
    [voilet setBackgroundColor:[self colorWithHexString:@"ed1e79"]];
    [orange setBackgroundColor:[self colorWithHexString:@"f9710d"]];
    [purple setBackgroundColor:[self colorWithHexString:@"662d91"]];
    [brown setBackgroundColor:[self colorWithHexString:@"8c6239"]];
    
    
    [black.layer setBorderWidth:3.0];
    [black.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = black;
    
    
    [bold setImage:[UIImage imageNamed:@"boldinactiveiphone"] forState:UIControlStateDisabled];
    [bold setImage:[UIImage imageNamed:@"boldtapiphone"] forState:UIControlStateSelected];
    
    [regular setImage:[UIImage imageNamed:@"regulartapiphone"] forState:UIControlStateSelected];
    
    [italic setImage:[UIImage imageNamed:@"italicinactiveiphone"] forState:UIControlStateDisabled];
    [italic setImage:[UIImage imageNamed:@"italictapiphone"] forState:UIControlStateSelected];
    
    
    fontName = @"Open Sans";
    self.fontsize = 16;
    fontColor = @"#000000";
    isBold = NO;
    isItalic = NO;
}

- (void)viewDidUnload
{
    [self setFontPicker:nil];
    [self setBlack:nil];
    [self setLightBlack:nil];
    [self setDarkGrey:nil];
    [self setGrey:nil];
    [self setRed:nil];
    [self setYellow:nil];
    [self setGreen:nil];
    [self setBlue:nil];
    [self setVoilet:nil];
    [self setOrange:nil];
    [self setPurple:nil];
    
    [self setBold:nil];
    [self setRegular:nil];
    [self setItalic:nil];
    [self setBrown:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [fontPicker release];
    [black release];
    [lightBlack release];
    [darkGrey release];
    [grey release];
    [red release];
    [yellow release];
    [green release];
    [blue release];
    [voilet release];
    [orange release];
    [purple release];
    
    [bold release];
    [regular release];
    [italic release];
    [brown release];
    [super dealloc];
}


#pragma mark Picker View Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0 )
        return [firstColPicker count];
    else return [secondColPicker count];
    
}

#pragma mark -
#pragma mark Picker View Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0 )
        return [firstColPicker objectAtIndex:row];
    else return [secondColPicker objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //    [fontPicker setShowsSelectionIndicator:YES];
    
    if(component == 0)
    {
        fontName = [firstColPicker objectAtIndex:row];
        switch (row) {
            case 0:
                [bold setEnabled:YES];
                [italic setEnabled:YES];
                break;
            case 1:
                [bold setEnabled:YES];
                [italic setEnabled:YES];
                break;
            case 2:  //blockletters
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 3: 
                [bold setEnabled:YES];
                [italic setEnabled:NO];
                break;
            case 4:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 5:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 6:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 7:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 8:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 9:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 10:
                [bold setEnabled:YES];
                [italic setEnabled:YES];
                break;
            case 11:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 12:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 13:
                [bold setEnabled:YES];
                [italic setEnabled:YES];
                break;
            case 14:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 15:
                [bold setEnabled:YES];
                [italic setEnabled:YES];
                break;
            case 16:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 17:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
            case 18:
                [bold setEnabled:YES];
                [italic setEnabled:YES];
                break;
            case 19:
                [bold setEnabled:NO];
                [italic setEnabled:NO];
                break;
                
                
            default:
                break;
        }
        
    }else if(component == 1)
    {
        self.fontsize = [[secondColPicker objectAtIndex:row] intValue];
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component){
        case 0: 
            return 250.0f;
        case 1: 
            return 40.0f;
    }
    return 0;
}
-  (IBAction)black:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [black.layer setBorderWidth:3.0];
    [black.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = black;
    fontColor = @"#000000";
}

- (IBAction)lightBlack:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [lightBlack.layer setBorderWidth:3.0];
    [lightBlack.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = lightBlack;
    fontColor = @"#333333";
}

- (IBAction)darkGrey:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [darkGrey.layer setBorderWidth:3.0];
    [darkGrey.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = darkGrey;
    fontColor = @"#666666";
}

- (IBAction)grey:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [grey.layer setBorderWidth:3.0];
    [grey.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = grey;
    fontColor = @"#999999";
    
}

- (IBAction)red:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [red.layer setBorderWidth:3.0];
    [red.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = red;
    fontColor = @"#e3051b";
}

- (IBAction)yellow:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [yellow.layer setBorderWidth:3.0];
    [yellow.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = yellow;
    fontColor = @"#fcee21";
    
}

- (IBAction)green:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [green.layer setBorderWidth:3.0];
    [green.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = green;
    fontColor = @"#179f38";
}

- (IBAction)blue:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [blue.layer setBorderWidth:3.0];
    [blue.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = blue;
    fontColor = @"#09a5db";
}

- (IBAction)voilet:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [voilet.layer setBorderWidth:3.0];
    [voilet.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = voilet;
    fontColor = @"#ed1e79";
}

- (IBAction)orange:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [orange.layer setBorderWidth:3.0];
    [orange.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = orange;
    fontColor = @"#f9710d";
}

- (IBAction)purple:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [purple.layer setBorderWidth:3.0];
    [purple.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = purple;
    fontColor = @"#662d91";
}

- (IBAction)brown:(id)sender {
    [lastColor.layer setBorderWidth:0];
    [brown.layer setBorderWidth:3.0];
    [brown.layer setBorderColor:[[UIColor grayColor] CGColor]];
    lastColor = brown;
    fontColor = @"#8c6239";
}

- (IBAction)bold:(id)sender {
    [bold setSelected:YES];
    [regular setSelected:NO];
    //    [italic setSelected:NO];
    isBold = YES;
    
}

- (IBAction)regular:(id)sender {
    [bold setSelected:NO];
    [regular setSelected:YES];
    [italic setSelected:NO];
    isBold = NO;
    isItalic = NO;
    
}

- (IBAction)italic:(id)sender {
    //    [bold setSelected:NO];
    [regular setSelected:NO];
    [italic setSelected:YES];
    isItalic = YES;
}


-(UIColor*)colorWithHexString:(NSString*)hex  
{  
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
    
    // String should be 6 or 8 characters  
    if ([cString length] < 6) return [UIColor grayColor];  
    
    // strip 0X if it appears  
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];  
    
    if ([cString length] != 6) return  [UIColor grayColor];  
    
    // Separate into r, g, b substrings  
    NSRange range;  
    range.location = 0;  
    range.length = 2;  
    NSString *rString = [cString substringWithRange:range];  
    
    range.location = 2;  
    NSString *gString = [cString substringWithRange:range];  
    
    range.location = 4;  
    NSString *bString = [cString substringWithRange:range];  
    
    // Scan values  
    unsigned int r, g, b;  
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];  
    
    return [UIColor colorWithRed:((float) r / 255.0f)  
                           green:((float) g / 255.0f)  
                            blue:((float) b / 255.0f)  
                           alpha:1.0f];  
} 






-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [delegate fontViewControllerDidFinish:self fontName:fontName fontSize:fontsize fontColor:fontColor isBold:isBold isItalic:isItalic];
        [super viewWillDisappear:animated];
        
        
    }
    
}



@end
