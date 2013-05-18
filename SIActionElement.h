//
//  SIActionElement.h
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIActionElement : NSObject
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, copy) void (^action)(void);

+(SIActionElement*)actionWithTitle:(NSString*)title image:(UIImage*)image andAction:(void (^)(void))action;

@end
