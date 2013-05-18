//
//  SIViewController.m
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "SIViewController.h"
#import "SIActionSheet.h"

@interface SIViewController ()

@end

@implementation SIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)openSheet:(id)sender {
    NSArray* actions = [NSArray arrayWithObjects:[SIActionElement actionWithTitle:@"Action 1" image:[UIImage imageNamed:@"studio-istanbul"] andAction:^{NSLog(@"action 1");}], nil];
    SIActionSheet* actionSheet = [SIActionSheet actionSheetWithTitle:@"test sheet" andObjects:actions completition:^(int num){NSLog(@"complete with num %i", num);} cancel:^{NSLog(@"canceled");}];
    //[actionSheet showinView:self.view];
    [actionSheet show];
}

@end
