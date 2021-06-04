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
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 88, [[UIScreen mainScreen] bounds].size.width, 400))];
    
    
    YOECGChartView *ecg = [[YOECGChartView alloc]initWithFrame:(CGRectMake(10, 88, [[UIScreen mainScreen] bounds].size.width, 400))];
    ecg.standard.sampleFrequency = 500;
    
    float width = dataArr.count * ecg.standard.onePointWidth;
    CGRect frame = ecg.frame;
    frame.size.width = width;
    ecg.frame = frame;
    
    scrollView.contentSize = CGSizeMake(width + 20, 400);
    scrollView.maximumZoomScale = 5;
    
    [ecg refreshSubViewFrame];
    
    ecg.gridView.isShowSecondText = YES;
    ecg.gridView.startSecond = 0;
    
//    ecg.oneGradeSize = 257 / 14.0 / 5
    
    [ecg reloadView];
    [ecg drawLine:dataArr];
    
    [scrollView addSubview:ecg];
    
    [self.view addSubview:scrollView];
    
//    self.view.backgroundColor = UIColor.greenColor;
    
}


@end
