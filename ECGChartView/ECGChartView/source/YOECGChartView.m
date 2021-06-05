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


-(void)drawStaticECGLine:(NSArray *)voltageArr{
    self.gridView.gridTotal = self.negativeNum + self.positiveNum;
    self.gridView.standard = self.standard;
    self.gridView.secodeLineHeight = 2 *self.standard.oneGridSize;
    [self.gridView reloadGrid];
    
    self.ecgView.positiveNum = self.positiveNum;
    self.ecgView.negativeNum = self.negativeNum;
    self.ecgView.standard = self.standard;
    [self.ecgView drawStaticECGLine:voltageArr];
}


/// 实时心电图【双轨迹】
-(void)drawRealTimeECGLine:(NSArray *)voltageArr{
    [self drawRealTimeECGLine:voltageArr twoLine:YES];
}

/// 实时心电图【YES 双轨迹 ,NO 单轨迹】
-(void)drawRealTimeECGLine:(NSArray *)voltageArr twoLine:(BOOL)twoLine{

    self.ecgView.positiveNum = self.positiveNum;
    self.ecgView.negativeNum = self.negativeNum;
    self.ecgView.standard = self.standard;
    
    if (twoLine) {
        [self.ecgView drawRealTimeECGTWoLine:voltageArr];
        return;
    }
    
    [self.ecgView drawRealTimeECGOneLine:voltageArr];
    
}


-(void)reloadGridView{
    self.gridView.gridTotal = self.negativeNum + self.positiveNum;
    self.gridView.standard = self.standard;
    self.gridView.secodeLineHeight = 0;
    [self.gridView reloadGrid];
}


@end
