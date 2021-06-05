//
//  YOECGChartView.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "YOECGChartView.h"


@interface YOECGChartView()

/// 走纸速速 默认25mm/s (0.025s)
@property (nonatomic) int speed;

/// 纸张规格 10 mV/mm (一小格 10mV)
@property (nonatomic) int voltageSpecifications;

@end


@implementation YOECGChartView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configPar];
    }
    return self;
}


-(void)configPar{
    self.standard = [YOECGParamter new];
    
    self.negativeNum = 4;
    self.positiveNum = 4;
        
    self.gridView = [[YOECGBackGroundGridView alloc]initWithFrame:self.bounds];
    [self addSubview:self.gridView];
    self.ecgView = [[YOECGLineView alloc]initWithFrame:self.bounds];
    
    self.ecgView.standard = self.standard;
    self.ecgView.standard.oneGridSize = self.standard.oneGridSize;
    [self addSubview:self.ecgView];
    
}


-(void)refreshSubViewFrame{
    self.gridView.frame = self.bounds;
    self.ecgView.frame = self.bounds;
}

-(void)reloadView{
    self.gridView.gridTotal = self.negativeNum + self.positiveNum;
    self.gridView.standard = self.standard;
    self.gridView.secodeLineHeight = 2 *self.standard.oneGridSize;
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
