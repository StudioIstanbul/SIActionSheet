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
@property (nonatomic, retain) UIPopoverController* popCtrl;
@property (nonatomic, retain) UIView* blackout;
-(IBAction)close:(id)sender;
@end

@implementation SIActionSheet
@synthesize elements, tableview, titleLabel;
@synthesize cancelBlock, completeBlock, parentview, cancelButton, scroll;
@synthesize popCtrl, blackout;
@synthesize contentSize;

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
    if (cancelBlock) {
        cancelBlock();
    }
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

-(CGSize)contentSize {
    CGRect myFrame;
    if (self.parentview) {
        myFrame = self.parentview.frame;
    } else {
        myFrame = CGRectMake(0, 0, 320, 480);
    }
    float height = myFrame.size.height;
    if ((self.elements.count * 70) + 10 + 56 + 54 + 30 < myFrame.size.height) {
        height = (self.elements.count * 70) + 10 + 56 + 54 + 30;
    }
    return CGSizeMake(myFrame.size.width, height);
}

-(void)showinView:(UIView *)view {
    if (!self.parentview) {
        self.parentview = view;
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        CGRect myFrame = [view convertRect:view.frame fromView:nil];
        CGRect parentFrame = myFrame;
        myFrame.size = self.contentSize;
        if (!self.popCtrl) self.view.frame = CGRectMake(0, parentFrame.size.height, myFrame.size.width, myFrame.size.height);
        [view addSubview:self.view];
        [self retain];
        double dur = 0.5;
        if (self.popCtrl) dur = 0;
        [UIView animateWithDuration:dur animations:^{self.view.frame = CGRectMake(0, parentFrame.size.height - myFrame.size.height, myFrame.size.width, myFrame.size.height);}];
    } else {
        NSLog(@"can't show twice!");
    }
}

-(void)showWithCoordinates:(CGPoint)point {
    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
    self.blackout = [[[UIView alloc] initWithFrame:rootVC.view.bounds] autorelease];
    blackout.backgroundColor = [UIColor blackColor];
    blackout.alpha = 0;
    [rootVC.view addSubview:blackout];
    [rootVC.view bringSubviewToFront:blackout];
    [UIView animateWithDuration:0.5 animations:^{blackout.alpha = 0.8;}];
    UIViewController* basicView = [[UIViewController alloc] init];
    basicView.modalInPopover = YES;
    basicView.contentSizeForViewInPopover = self.contentSize;
    basicView.view.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    popCtrl = [[UIPopoverController alloc] initWithContentViewController:basicView];
    CGRect myFrame = CGRectMake(point.x, point.y, 1, 1);
    [self showinView:basicView.view];
    [popCtrl presentPopoverFromRect:myFrame inView:rootVC.view permittedArrowDirections:UIPopoverArrowDirectionDown | UIPopoverArrowDirectionUp animated:YES];
}

-(void)closeAnimated {
    CGRect myFrame = [parentview convertRect:parentview.frame fromView:nil];
    double dur = 0.5;
    if (!self.popCtrl) [UIView animateWithDuration:dur animations:^{self.view.frame = CGRectMake(0, myFrame.size.height, myFrame.size.width, myFrame.size.height);} completion:^(BOOL finish) {self.parentview = nil; [self.view removeFromSuperview]; [self release];}]; else {
        [UIView animateWithDuration:0.5 animations:^{self.blackout.alpha = 0;} completion:^(BOOL finished){[blackout removeFromSuperview]; self.blackout = nil;}];
        [self.popCtrl dismissPopoverAnimated:YES];
        self.popCtrl = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

-(void)show {
    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self showinView:[rootVC view]];
    } else {
        [self showWithCoordinates:CGPointMake(100, 100)];
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
    if (((SIActionElement*)[self.elements objectAtIndex:indexPath.row]).action)     ((SIActionElement*)[self.elements objectAtIndex:indexPath.row]).action();
    if (completeBlock) self.completeBlock(indexPath.row);
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
    if (cell.imageView.image == nil) {
        cell.textLabel.frame = CGRectMake(cell.imageView.frame.origin.x, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width + cell.textLabel.frame.origin.x - cell.imageView.frame.origin.x, cell.textLabel.frame.size.height);
    }
    if (cell.textLabel.text == nil) {
        cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, cell.textLabel.frame.size.width + cell.textLabel.frame.origin.x - cell.imageView.frame.origin.x, cell.imageView.frame.size.height);
    }
}

@end
