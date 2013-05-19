//
//  UITabBar+frame.m
//  write.out
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "UITabBar+frame.h"

@implementation UITabBar (frame)
-(CGRect)rectForItemWithIndex:(NSInteger)index {
    NSMutableArray* frames = [[NSMutableArray alloc] init];
    for (id elem in self.subviews) {
        if ([elem isKindOfClass:[UIControl class]]) {
            [frames addObject:[NSValue valueWithCGRect:[elem frame]]];
        }
    }
    [frames sortUsingComparator:^NSComparisonResult(NSValue* a, NSValue* b) {
        CGRect rect1 = [a CGRectValue];
        CGRect rect2 = [b CGRectValue];
        if (rect1.origin.x < rect2.origin.x) return NSOrderedAscending;
        if (rect1.origin.x > rect2.origin.x) return NSOrderedDescending;
        return NSOrderedSame;
    }];
    CGRect retRect = [[frames objectAtIndex:index] CGRectValue];
    [frames release];
    return retRect;
}

-(CGRect)rectForItem:(UITabBarItem *)item {
    NSUInteger index = [self.items indexOfObject:item];
    return [self rectForItemWithIndex:index];
}

-(CGPoint)midpointForItem:(UITabBarItem *)item {
    CGRect rect = [self rectForItem:item];
    CGPoint point = CGPointMake(rect.origin.x + (rect.size.width /2), rect.origin.y);
    return point;
}

-(CGRect)midpointRectForItem:(UITabBarItem *)item {
    CGPoint point = [self midpointForItem:item];
    CGRect rect = CGRectMake(point.x, point.y, 1, 1);
    return rect;
}
@end
