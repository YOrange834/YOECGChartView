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
    NSArray * data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:data];

    for (int i = 0; i < dataArr.count; i++) {
        NSNumber *str = dataArr[i];
        dataArr[i] = @(-str.intValue);
    }
    _dataArr = dataArr;
    
    YOECGChartView *ecg = [[YOECGChartView alloc]initWithFrame:(CGRectMake(10, 88, [[UIScreen mainScreen] bounds].size.width - 20, 400))];
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
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(refreshMap) userInfo:nil repeats:YES];
    
}

/// 模拟硬件实时数据
-(void)refreshMap{
    
    int point = _par.sampleFrequency / (1 / 0.05); //0.05s的采样点数
    
    if (self.dataArr.count / point > _number) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < point; i++) {
            NSString *str = self.dataArr[_number * point + i];
            [arr addObject:str];
        }
        [_ecg drawRealTimeECGLine:arr twoLine:_isOnly];
        _number ++;
        
    }else{
        [_timer invalidate];
        _timer = nil;
    }
}



@end
