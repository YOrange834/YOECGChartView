//
//  ViewController.m
//  ECGChartView
//
//  Created by HOrange on 2021/6/3.
//

#import "ViewController.h"
#import "ECGReportViewController.h"
#import "RealTimeViewController.h"
#import "ECGChartView-Swift.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController{
    NSArray *_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HealthChartView";
    _arr = @[@"心电图报告",@"实时心电图-单条轨迹",@"实时心电图-双轨迹"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 60;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 40))];
    UILabel *lab = [[UILabel alloc]initWithFrame:header.bounds];
    if (section == 0) {
        lab.text = @"OC";
    }else{
        lab.text = @"Swift";
    }
    [header addSubview:lab];
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = _arr[indexPath.row];
    //    _arr = @[@"心电图报告",@"实时心电图-单条轨迹",@"实时心电图-双轨迹"];

    if (indexPath.section == 0) {
        if ([title isEqualToString:@"心电图报告"]) {
            [self.navigationController pushViewController:[ECGReportViewController new] animated:YES];
            return;
        }
        if ([title isEqualToString:@"实时心电图-单条轨迹"]) {
            RealTimeViewController *real = [RealTimeViewController new];
            real.isOnly = NO;
            [self.navigationController pushViewController:real animated:YES];
            return;
        }
        
        if ([title isEqualToString:@"实时心电图-双轨迹"]) {
            RealTimeViewController *real = [RealTimeViewController new];
            real.isOnly = YES;
            [self.navigationController pushViewController:real animated:YES];
            return;
        }
        return;
    }
    
    
    if ([title isEqualToString:@"心电图报告"]) {
        [self.navigationController pushViewController:[ECGReportViewController new] animated:YES];
        return;
    }
    if ([title isEqualToString:@"实时心电图-单条轨迹"]) {
        SRealTimeViewController *real = [SRealTimeViewController new];
        real.isOnly = NO;
//        real.isOnly = NO;
        [self.navigationController pushViewController:real animated:YES];
        return;
    }
    
    if ([title isEqualToString:@"实时心电图-双轨迹"]) {
        SRealTimeViewController *real = [SRealTimeViewController new];
        real.isOnly = YES;
        [self.navigationController pushViewController:real animated:YES];
        return;
    }
    
}

@end
