//
//  UITabBar+frame.h
//  write.out
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (frame)
-(CGRect)rectForItemWithIndex:(NSInteger)index;
-(CGRect)rectForItem:(UITabBarItem*)item;
-(CGPoint)midpointForItem:(UITabBarItem*)item;
-(CGRect)midpointRectForItem:(UITabBarItem*)item;
@end
