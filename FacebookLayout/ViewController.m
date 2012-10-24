//
//  ViewController.m
//  FacebookLayout
//
//  Created by 古山 健司 on 12/10/25.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize topLayer = _topLayer;
@synthesize topLayerPosition = _topLayerPosition;
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // BaseLayer(tableView)
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    table.frame = CGRectMake(0, 44, 260, 480-44);
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.tableView = table;
    [table release];
    
    // Navigationバーを生成して、BaseLayerに追加
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    naviBar.tintColor = [UIColor grayColor];
    UINavigationItem *naviItem = [[UINavigationItem alloc] initWithTitle:@"Menu"];
    [naviBar pushNavigationItem:naviItem animated:NO];
    [self.view addSubview:naviBar];
    
    // topLayer
    UIViewController *rootViewController = [[UIViewController alloc] init];
    rootViewController.title = @"Main";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [rootViewController release];
    
    navigationController.view.frame = self.view.frame;
    [navigationController setNavigationBarHidden:NO animated:NO];
    
    // ナビゲーションバーは、navigationControllerではなく、rootViewControllerのものになっている。
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(buttonAction)];
    rootViewController.navigationItem.leftBarButtonItem = button;
    
    UIView *topView = navigationController.view;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    self.topLayer = topView;
    [topView release];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    [pan release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Layer animation
- (void)animateLayerToPoint:(CGFloat)x
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect frame = self.topLayer.frame;
                         frame.origin.x = x;
                         self.topLayer.frame = frame;
                     }
                     completion:^(BOOL finished){self.topLayerPosition = self.topLayer.frame.origin.x;}];
}
#pragma mark -
/**
 *
 */
- (void)panAction:(UIPanGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateChanged ) {
        // ドラッグで移動した距離を取得する
        CGPoint p = [sender translationInView:self.view];
        CGRect frame = self.topLayer.frame;
        frame.origin.x = self.topLayer.frame.origin.x + p.x;
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        self.topLayer.frame = frame;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.topLayer.frame.origin.x <=160) {
            [self animateLayerToPoint:0];
        }
        else {
            [self animateLayerToPoint:260];
        }
    }
    
    // ドラッグで移動した距離を初期化する
    [sender setTranslation:CGPointZero inView:self.view];
}

- (void) buttonAction
{
    if (self.topLayer.frame.origin.x > 160) {
        [self animateLayerToPoint:0];
    }
    else {
        [self animateLayerToPoint:260];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Cell:%d", indexPath.row];
    return cell;
}

@end
