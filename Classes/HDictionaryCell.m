//
//  HDictionaryCell.m
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HDictionaryCell.h"


@implementation HDictionaryCell
// self.backgroundView = [[CustomCellBackgroundView alloc] initWithFrame:self.frame];

- (void)awakeFromNib {
	NSLog(@"awakeFromNib");
	
	self.backgroundView = [[[CustomCellBackgroundView alloc] initWithFrame:self.frame] autorelease];
}

- (void)setCellOriginal:(NSString *)originalText translation:(NSString *)translationText cellWidht:(CGFloat)cellWidth andIsEven:(BOOL)isEven {
	CGFloat originalWidth = cellWidth - 30;
	CGFloat translationWidth = cellWidth - 40;
	
	CGSize originalConstrainedToSize = {originalWidth, 20000.0f};
	CGSize sizeOfOriginal = [originalText sizeWithFont:[UIFont systemFontOfSize:17.0f]
									 constrainedToSize:originalConstrainedToSize];
	
	CGSize translationConstrainedToSize = {translationWidth, 20000.0f};
	CGSize sizeOfTranslation = [translationText sizeWithFont:[UIFont systemFontOfSize:17.0f]
										   constrainedToSize:translationConstrainedToSize];
	
	CGRect originalRect = CGRectMake(10, 0, originalWidth, sizeOfOriginal.height);
	CGRect translationRect = CGRectMake(20, sizeOfOriginal.height, translationWidth, sizeOfTranslation.height);
	
	_original.frame = originalRect;
	_translation.frame = translationRect;
	_original.text = originalText;
	_translation.text = translationText;
	
	NSLog(@"contentView: %f", self.contentView.frame.size.width);
	
	UIColor *color;
	if (isEven) {
		color = [UIColor colorWithRed:0xEE / 256.
								green:0xF3 / 256.
								 blue:0xFD / 256.
								alpha:1.0];
	} else {
		color = [UIColor whiteColor];
	}
	
	CustomCellBackgroundView *backgroundView = (CustomCellBackgroundView *)self.backgroundView;
	[backgroundView setFillColor: color];
	[backgroundView setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}

@end


@implementation CustomCellBackgroundView

@synthesize fillColor = _fillColor;

- (BOOL) isOpaque {
    return NO;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(c, [_fillColor CGColor]);
	CGContextFillRect(c, rect);
}

- (void)dealloc {
    [_fillColor release];
    [super dealloc];
}

@end
