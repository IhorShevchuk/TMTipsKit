//
//  TMTableViewController.m
//  TipsKit
//
//  Created by Admin on 1/27/15.
//  Copyright (c) 2015 Techmagic. All rights reserved.
//

#import "TMTableViewController.h"
#import "TMTipsKit.h"

@interface TMTableViewController ()

@end

@implementation TMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[TMTipsKit sharedInstance] initWithTipsNames:@[@"SimpleTip",@"SimpleTipWithArrows",@"TipsWithStyles"]];
}
-(void)viewDidAppear:(BOOL)animated
{
    //reset every time when controller is showing
    [[TMTipsKit sharedInstance]  resetTipsStatus];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    switch (indexPath.row) {
        case 0:
            [[TMTipsKit sharedInstance]  showTipWithName:@"SimpleTip"];
            break;
        case 1:
            [[TMTipsKit sharedInstance]  showTipWithName:@"SimpleTipWithArrows" forView:[segue.destinationViewController view]];
            break;
        case 2:
            //Example for tips with styles is in TMTipsWithStylesViewController.m
            break;
        default:
            break;
    }
}
@end