//
//  TMTipsWithStylesViewController.m
//  TipsKit
//
//  Created by Admin on 1/28/15.
//  Copyright (c) 2015 Techmagic. All rights reserved.
//

#import "TMTipsWithStylesViewController.h"
#import "TMTipsKit.h"
#import <QuartzCore/QuartzCore.h>
@interface TMTipsWithStylesViewController ()
{
    __weak IBOutlet UIButton *roundButton;
    __weak IBOutlet UILabel *customLabel;
}

@end

@implementation TMTipsWithStylesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //init ui
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
    icon.image = [UIImage imageNamed:@"flagIcon"];
    [roundButton addSubview:icon];
    
    //round corenrs of button
    roundButton.layer.cornerRadius = roundButton.frame.size.width / 2.0;
    roundButton.clipsToBounds = YES;
    
    //Label
    customLabel.text = @"This text is setted from view controller!";
}
-(void)viewWillAppear:(BOOL)animated
{
    //Create a styles
    NSArray *viewStyles;
    viewStyles = @[[[TMViewStyle alloc]initWithViewTag:1 style:TMViewStyleTypeText andValue:customLabel.text],
                   [[TMViewStyle alloc]initWithViewTag:3 style:TMViewStyleTypeCornerRadius andValue:[NSNumber numberWithFloat:roundButton.frame.size.width / 2.0]],
                   [[TMViewStyle alloc]initWithViewTag:3 style:TMViewStyleTypeBackgroundColor andValue:roundButton.backgroundColor]
                   ];
    //show tip's view
    [[TMTipsKit sharedInstance]  showTipWithName:@"TipsWithStyles" forView:[self view] showOnlyOnce:YES andApplyToSubViewsStyles:viewStyles];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end