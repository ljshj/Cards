//
//  CYMyBillTableViewController.h
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyBillTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,retain)NSMutableDictionary *dataDic;
@property(nonatomic,retain)NSMutableArray *dataArray;

@end
