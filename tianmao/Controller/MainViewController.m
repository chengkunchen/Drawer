//
//  MainViewController.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "MainViewController.h"
#import "ShopTypeCell.h"
#import "FolderView.h"
#import "ShopType.h"

static NSString *cellId = @"myCell";

@interface MainViewController ()

@property (nonatomic, strong) NSArray *dataList;
@end

@implementation MainViewController

/**
 *  在UITableViewController中，如果要实例化视图，直接实例化self.tableView即可。
 *  如果要使用默认的平板表格UITableViewStylrPlain，可以不用重写loadView方法。
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置标题
    self.title = @"商品列表";    
    // 设置导航栏背景
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];
    // 设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIBarStyleBlackOpaque;
    
    [self initDataList];
    
    //给tableView注册ShopTypeCell类
    [self.tableView registerClass:[ShopTypeCell class] forCellReuseIdentifier:cellId];
}

#pragma mark - 实例化视图
-(void)loadView{
    self.tableView = [[FolderView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
}

#pragma mark - 初始化数据
-(void)initDataList{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        ShopType *st = [ShopType shopTypeWithDict:dict];
        [arrayM addObject:st];
    }
    _dataList = arrayM;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    ShopType *st = self.dataList[indexPath.row];

    cell.textLabel.text = st.name;
    cell.imageView.image = st.image;
    cell.detailTextLabel.text = st.detail;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FolderView *folder = (FolderView *)tableView;
    
    ShopType *shopType = self.dataList[indexPath.row];
    [folder operateFolderAtIndexPath:indexPath shopList:shopType.subShops];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
