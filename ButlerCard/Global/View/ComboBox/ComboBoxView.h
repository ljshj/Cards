//
//  ComboBoxView.h
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ComboBoxView : UIView

@property (strong, nonatomic) NSArray *comboBoxDatasource;
@property (assign, nonatomic) NSUInteger selectedItemIndex;

@end
