//
//  ViewController.m
//  ScrollRefreshDataDemo
//
//  Created by Kai Shi on 2018/11/7.
//  Copyright © 2018 Kai Shi. All rights reserved.
//

#import "ViewController.h"
#import "DLActivityRefreshView/DLActivityRefreshView.h"

@interface ViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (strong, nonatomic)DLActivityRefreshView *dlActivityRefreshView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dlActivityRefreshView = [[DLActivityRefreshView alloc] initWithFrame:CGRectMake(40, 20, 20, 20) scrollView:self.myTableView refreshingBlock:^{
        
    }endRefreshingBlock:^{

    }];
    [self.centerView addSubview:self.dlActivityRefreshView];
    self.myTableView.delegate = self;
    [self performSelector:@selector(stop) withObject:nil afterDelay:10];
}

- (void)stop{
    [self.dlActivityRefreshView stopAnimating];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
