//
//  RealTimeViewController.m
//  ECGChartView
//
//  Created by Mac on 2021/6/5.
//

#import "RealTimeViewController.h"
#import "YOECGChartView.h"

@interface RealTimeViewController ()
@property (nonatomic) YOECGChartView *ecg ;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSArray *dataArr;
@property (nonatomic, assign) NSInteger number;

@property (strong, nonatomic) YOECGParamter *par;

@end

@implementation RealTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实时心电图";
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
    //当数据结构为数组时
    _dataArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    YOECGChartView *ecg = [[YOECGChartView alloc]initWithFrame:(CGRectMake(10, 88, [[UIScreen mainScreen] bounds].size.width, 400))];
    ecg.standard.sampleFrequency = 500;

    _par = ecg.standard;
    
    [ecg refreshSubViewFrame];
    
    _ecg = ecg;
    
    [self.view addSubview:ecg];
        
    [_ecg reloadGridView];
    
    [self configData];
}


///开始划线
-(void)configData{
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshMap) userInfo:nil repeats:YES];
    
}

/// 模拟硬件实时数据
-(void)refreshMap{
    
    int point = _par.sampleFrequency / 10; //0.1s的采样点数
    
    if (self.dataArr.count / point > _number) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < point; i++) {
            NSString *str = self.dataArr[_number * point + i];
            [arr addObject:str];
        }
        [_ecg drawRealTimeECGLine:arr];
        _number ++;
        
    }else{
        [_timer invalidate];
        _timer = nil;
    }
}



@end
