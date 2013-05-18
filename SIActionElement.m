//
//  SIActionElement.m
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "SIActionElement.h"

@implementation SIActionElement

@synthesize image = _image, title = _title, action = _action;

-(void)dealloc {
    self.title = nil;
    self.image = nil;
    [_action release];
    [super dealloc];
}

+(SIActionElement*)actionWithTitle:(NSString *)title image:(UIImage *)image andAction:(void (^)(void))action {
    SIActionElement* elem = [[[SIActionElement alloc] init] autorelease];
    elem.title = title;
    elem.image = image;
    elem.action = action;
    return elem;
}

@end
