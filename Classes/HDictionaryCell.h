//
//  HDictionaryCell.h
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HDictionaryCell : UITableViewCell {
	IBOutlet UILabel *_original;
	IBOutlet UILabel *_translation;
}

- (void)setCellOriginal:(NSString *)originalText translation:(NSString *)translationText andCellWidht:(CGFloat) cellWidth;

@end
