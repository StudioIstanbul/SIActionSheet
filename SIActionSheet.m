//
//  SIActionSheet.m
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "SIActionSheet.h"
#import "SIActionCell.h"

@interface SIActionSheet () {
    
}
@property (nonatomic, retain) NSMutableArray* elements;
@property (nonatomic, retain) IBOutlet UITableView* tableview;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* cancelButton;
@property (nonatomic, retain) IBOutlet UIView* scroll;
@property (nonatomic, retain) NSString* titleText;
@property (nonatomic, copy) void (^cancelBlock)(void);
@property (nonatomic, copy) void (^completeBlock)(int);
@property (nonatomic, retain) UIView* parentview;
-(IBAction)close:(id)sender;
@end

@implementation SIActionSheet
@synthesize elements, tableview, titleLabel;
@synthesize cancelBlock, completeBlock, parentview, cancelButton, scroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        elements = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = self.titleText;
    [tableview registerNib:[UINib nibWithNibName:@"SIActionCell" bundle:nil] forCellReuseIdentifier:@"SIActionCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)close:(id)sender {
    cancelBlock();
    [self closeAnimated];
}

-(void)dealloc {
    //NSLog(@"dealloc action sheet");
    self.elements = nil;
    [completeBlock release];
    [cancelBlock release];
    self.titleText = nil;
    [super dealloc];
}

+(SIActionSheet*)actionSheetWithTitle:(NSString *)title andObjects:(NSArray *)objects completition:(void (^)(int))completeBlock cancel:(void (^)(void))cancelBlock {
    SIActionSheet* mySheet = [[[SIActionSheet alloc] initWithNibName:@"SIActionSheet" bundle:nil] autorelease];
    mySheet.titleText = title;
    mySheet.elements = [NSMutableArray arrayWithArray:objects];
    mySheet.completeBlock = completeBlock;
    mySheet.cancelBlock = cancelBlock;
    return mySheet;
}

-(SIActionElement*)actionAtIndex:(NSInteger)pos {
    if (pos > self.elements.count) return [self.elements objectAtIndex:pos]; else return nil;
}

-(void)showinView:(UIView *)view {
    if (!self.parentview) {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        CGRect myFrame = [view convertRect:view.frame fromView:nil];
        self.view.frame = CGRectMake(0, myFrame.size.height, myFrame.size.width, myFrame.size.height);
        [view addSubview:self.view];
        self.parentview = view;
        [self retain];
        [UIView animateWithDuration:0.5 animations:^{self.view.frame = CGRectMake(0, 0, myFrame.size.width, myFrame.size.height);}];
    } else {
        NSLog(@"can't show twice!");
    }
}

-(void)closeAnimated {
    CGRect myFrame = [parentview convertRect:parentview.frame fromView:nil];
    [UIView animateWithDuration:0.5 animations:^{self.view.frame = CGRectMake(0, myFrame.size.height, myFrame.size.width, myFrame.size.height);} completion:^(BOOL finish) {self.parentview = nil; [self.view removeFromSuperview]; [self release];}];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)show {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        id rootVC = [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
        [self showinView:[rootVC view]];
    } else {
        
    }
}

-(void)orientChange {
    NSLog(@"orient change");
    [self.cancelButton setNeedsDisplay];
    [self.scroll setNeedsDisplay];
    [self.view setNeedsDisplay];
}

#pragma mark tableview delegate

-(int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected %i", indexPath.row);
    ((SIActionElement*)[self.elements objectAtIndex:indexPath.row]).action();
    self.completeBlock(indexPath.row);
    [self closeAnimated];
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.elements.count;
}

-(UITableViewCell*)tableView:(UITableView *)xtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SIActionCell* cell = [xtableView dequeueReusableCellWithIdentifier:@"SIActionCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(SIActionCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = ((SIActionElement*)[self.elements objectAtIndex:indexPath.row]).title;
    cell.imageView.image = ((SIActionElement*)[self.elements objectAtIndex:indexPath.row]).image;
}

@end
