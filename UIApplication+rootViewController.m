//
//  UIApplication+rootViewController.m
//  write.out
//
//  Created by Andreas Zöllner on 19.05.13.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "UIApplication+rootViewController.h"

@implementation UIApplication (rootViewController)
+(UIViewController*)rootViewController {
    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
    return rootVC;
}
@end
