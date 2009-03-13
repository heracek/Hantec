//
//  HDictionaryCell.m
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HDictionaryCell.h"


@implementation HDictionaryCell

- (void)setCellOriginal:(NSString *)originalText andTranslation:(NSString *)translationText {
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
