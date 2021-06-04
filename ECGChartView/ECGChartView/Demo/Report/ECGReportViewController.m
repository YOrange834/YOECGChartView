//
//  ECGReportViewController.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "ECGReportViewController.h"
#import "YOECGChartView.h"

@interface ECGReportViewController ()

@end

@implementation ECGReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
    //当数据结构为数组时
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    YOECGChartView *ecg = [[YOECGChartView alloc]initWithFrame:(CGRectMake(0, 88, [[UIScreen mainScreen] bounds].size.width, 400))];
//    ecg.oneGradeSize = 257 / 14.0 / 5;
    
    [ecg reloadView];
    [ecg drawLine:dataArr];
    
    [self.view addSubview:ecg];
    
    self.view.backgroundColor = UIColor.greenColor;
    
}


@end
