//
//  HDictionaryCell.m
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HDictionaryCell.h"


@implementation HDictionaryCell

- (void)setCellOriginal:(NSString *)originalText translation:(NSString *)translationText andCellWidht:(CGFloat) cellWidth {
	CGFloat originalWidth = cellWidth - 30;
	CGFloat translationWidth = cellWidth - 40;
	
	
	CGSize originalConstrainedToSize = {originalWidth, 20000.0f};
	CGSize sizeOfOriginal = [originalText sizeWithFont:[UIFont systemFontOfSize:17.0f]
									 constrainedToSize:originalConstrainedToSize
										 lineBreakMode:UILineBreakModeWordWrap];
	
	CGSize translationConstrainedToSize = {translationWidth, 20000.0f};
	CGSize sizeOfTranslation = [translationText sizeWithFont:[UIFont systemFontOfSize:17.0f]
										   constrainedToSize:translationConstrainedToSize
											   lineBreakMode:UILineBreakModeWordWrap];
	
	CGRect cellFrame = CGRectMake(0, 0, cellWidth, sizeOfOriginal.height + sizeOfTranslation.height + 3);
	
	CGRect originalRect = CGRectMake(10, 0, originalWidth, sizeOfOriginal.height);
	CGRect translationRect = CGRectMake(20, sizeOfOriginal.height, translationWidth, sizeOfTranslation.height);
	
	[self setFrame:cellFrame];
	[_original setFrame:originalRect];
	[_translation setFrame:translationRect];
	
	_original.text = originalText;
	_translation.text = translationText;
}

//- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
//        // Initialization code
//    }
//    return self;
//}
//
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//
//- (void)dealloc {
//    [super dealloc];
//}


@end
