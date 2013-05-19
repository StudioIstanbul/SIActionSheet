//
//  SIActionCell.m
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "SIActionCell.h"

@implementation SIActionCell
@synthesize textLabel, imageView, defaultImageViewRect, defaultTextLabelRect;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(CGRect)defaultTextLabelRect {
    CGRect currentFrame = self.frame;
    float resizeFactor = currentFrame.size.width / nibCellFrame.size.width;
    return CGRectMake(nibTextFrame.origin.x * resizeFactor, nibTextFrame.origin.y, nibTextFrame.size.width * resizeFactor, nibTextFrame.size.height);
}

-(CGRect)defaultImageViewRect {
    CGRect currentFrame = self.frame;
    float resizeFactor = currentFrame.size.width / nibCellFrame.size.width;
    return CGRectMake(nibImageFrame.origin.x, nibImageFrame.origin.y, nibImageFrame.size.width * resizeFactor, nibImageFrame.size.height);
}

-(void)awakeFromNib {
    nibCellFrame = self.frame;
    nibImageFrame = self.imageView.frame;
    nibTextFrame = self.textLabel.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc {
    [super dealloc];
}



@end
