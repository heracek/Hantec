//
//  HDictionaryCell.h
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HDictionaryCell : UITableViewCell {
	UILabel *_original;
	UILabel *_translation;
}

@property (nonatomic, retain) IBOutlet UILabel *original;
@property (nonatomic, retain) IBOutlet UILabel *translation;

@end
