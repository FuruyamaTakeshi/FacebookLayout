//
//  ViewController.h
//  FacebookLayout
//
//  Created by 古山 健司 on 12/10/25.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, retain)UIView *topLayer;
@property (nonatomic) CGFloat topLayerPosition;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@end
