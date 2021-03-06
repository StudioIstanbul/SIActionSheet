//
//  SIActionSheet.h
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIActionElement.h"

@interface SIActionSheet : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (readonly) CGSize contentSize;
@property (nonatomic, retain) SIActionSheet* followUpSheet;
@property (readonly) BOOL canceled;

+(SIActionSheet*)actionSheetWithTitle:(NSString*)title andObjects:(NSArray*)objects completition:(void (^)(int numberPressed))completeBlock cancel:(void (^)(void))cancelBlock;
-(SIActionElement*)actionAtIndex:(NSInteger)pos;
-(void)showinView:(UIView*)view;
-(void)show;
-(void)showWithCoordinates:(CGPoint)point;
-(void)showFromTabBarItem:(UITabBarItem*)item inTabBar:(UITabBar*)tabBar;
@end
