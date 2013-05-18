//
//  SICancelButton.m
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "SICancelButton.h"

@implementation SICancelButton
@synthesize highlighted, pressed;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 0.284 green: 0.284 blue: 0.284 alpha: 1];
    UIColor* strokeColor = [UIColor colorWithRed: 0.167 green: 0.167 blue: 0.167 alpha: 1];
    UIColor* gradientColor = [UIColor colorWithRed: 0.829 green: 0.829 blue: 0.829 alpha: 1];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0.469 green: 0.469 blue: 0.469 alpha: 1];
    UIColor* shadowColor2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* strokeColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors;
    if (self.pressed == NO) {
        gradientColors = [NSArray arrayWithObjects:
                          (id)gradientColor.CGColor,
                          (id)gradientColor2.CGColor,
                          (id)fillColor.CGColor, nil];
    } else {
        UIColor* gradientTintCol1 = [UIColor colorWithRed:0.829 green:0.829 blue:1 alpha:1];
        UIColor* gradientTintCol2 = [UIColor colorWithRed: 0.469 green: 0.469 blue: 1 alpha: 1];
        UIColor* gradientTintCol3 = [UIColor colorWithRed: 0.284 green: 0.284 blue: 1 alpha: 1];
        gradientColors = [NSArray arrayWithObjects:
                          (id)gradientTintCol1.CGColor,
                          (id)gradientTintCol2.CGColor,
                          (id)gradientTintCol3.CGColor, nil];
    }
    CGFloat gradientLocations[] = {0, 0.44, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    UIColor* shadow = shadowColor2;
    CGSize shadowOffset = CGSizeMake(0.1, 4.1);
    CGFloat shadowBlurRadius = 4;
    UIColor* shadow2 = strokeColor2;
    CGSize shadow2Offset = CGSizeMake(0.1, -1.1);
    CGFloat shadow2BlurRadius = 0.5;
    
    //// Frames
    CGRect frame = self.bounds;
    
    
    //// Abstracted Attributes
    NSString* cancelButtonContent = NSLocalizedString(@"Cancel", @"action sheet cancel button");
    
    
    //// Rounded Rectangle Drawing
    CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 7, CGRectGetHeight(frame) - 8);
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 11];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
                                CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
                                0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    [strokeColor setStroke];
    roundedRectanglePath.lineWidth = 5;
    [roundedRectanglePath stroke];
    
    
    //// CancelButton Drawing
    CGRect cancelButtonRect = CGRectMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 23) * 0.50000 + 0.5), CGRectGetWidth(frame) - 7, 23);
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
    [shadowColor2 setFill];
    [cancelButtonContent drawInRect: cancelButtonRect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 17] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    CGContextRestoreGState(context);
    
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.pressed = YES;
    [self setNeedsDisplay];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.pressed = NO;
    [self setNeedsDisplay];
    [super touchesEnded:touches withEvent:event];
}

-(void)setHighlighted:(BOOL)highlighted {
    [self setNeedsDisplay];
}


@end
