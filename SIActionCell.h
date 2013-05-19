//
//  SIActionCell.h
//  SIActionSheetDemo
//
//  Created by Programmierer on 18/5/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIActionCell : UITableViewCell {
    CGRect nibCellFrame;
    CGRect nibTextFrame;
    CGRect nibImageFrame;
}

@property (nonatomic, retain) IBOutlet UILabel* textLabel;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, assign) CGRect defaultTextLabelRect;
@property (nonatomic, assign) CGRect defaultImageViewRect;

@end
