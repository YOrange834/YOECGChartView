//
//  YOECGChartView.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "YOECGChartView.h"
#import "YOECGLineView.h"
#import "YOECGBackGroundGridView.h"

@interface YOECGChartView()

/// 走纸速速 默认25mm/s (0.025s)
@property (nonatomic) int speed;

/// 纸张规格 10 mV/mm (一小格 10mV)
@property (nonatomic) int voltageSpecifications;

@property (strong, nonatomic) YOECGBackGroundGridView *gridView;

@property (strong, nonatomic) YOECGLineView *ecgView;


@end


@implementation YOECGChartView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configPar];
    }
    return self;
}


-(void)configPar{
    
    
    self.negativeNum = 13;
    self.positiveNum = 14;
    
    self.gridView = [[YOECGBackGroundGridView alloc]initWithFrame:self.bounds];
    [self addSubview:self.gridView];
    self.ecgView = [[YOECGLineView alloc]initWithFrame:self.bounds];
    
    self.ecgView.standard = self.standard;
    self.ecgView.standard.oneGridSize = self.standard.oneGridSize;
    [self addSubview:self.ecgView];
    
}



-(void)reloadView{
    self.gridView.gridTotal = self.negativeNum + self.positiveNum;
    self.gridView.oneGradeSize = self.standard.oneGridSize;
    [self.gridView reloadGrid];
}


-(void)drawLine:(NSArray *)voltageArr{
    self.ecgView.positiveNum = self.positiveNum;
    self.ecgView.negativeNum = self.negativeNum;
    self.ecgView.standard.oneGridSize = self.standard.oneGridSize;
    [self.ecgView drawECGLine:voltageArr];
}


-(void)showECGReport{
    
}


@end
