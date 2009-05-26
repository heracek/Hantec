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
	self.backgroundView = [[[CustomCellBackgroundView alloc] initWithFrame:self.frame] autorelease];
}

- (void)setCellOriginal:(NSString *)originalText translation:(NSString *)translationText cellWidht:(CGFloat)cellWidth andIsEven:(BOOL)isEven {
	CGFloat originalWidth = cellWidth - 30;
	CGFloat translationWidth = cellWidth - 40;
	
	CGSize originalConstrainedToSize = {originalWidth, 20000.0f};
	CGSize sizeOfOriginal = [originalText sizeWithFont:[UIFont boldSystemFontOfSize:17.0f]
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
		
	CustomCellBackgroundView *backgroundView = (CustomCellBackgroundView *)self.backgroundView;
	[backgroundView setNeedsDisplay];
}



- (void)dealloc {
    [super dealloc];
}

@end


@implementation CustomCellBackgroundView

static UIImage *customCellBackgroundImage = nil;

+ (void)initialize {
	if(self == [CustomCellBackgroundView class]) {
		customCellBackgroundImage = [UIImage imageNamed:@"cell-bg.png"];
	}
}

- (BOOL) isOpaque {
    return NO;
}

- (void)drawRect:(CGRect)r {
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	[customCellBackgroundImage drawInRect:r];
	
	CGContextSetGrayStrokeColor(c, 0.375, 1);
	CGContextMoveToPoint(c, r.origin.x, r.origin.y + r.size.height);
	CGContextAddLineToPoint(c, r.origin.x + r.size.width, r.origin.y + r.size.height);
	CGContextStrokePath(c);
}

@end
