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

@property (nonatomic) YOECGChartViewType drawECGType;

@property (nonatomic) NSArray *voltageArr;

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
    self.gridView.standard = self.standard;
    [self addSubview:self.gridView];
    
    self.ecgView = [[YOECGLineView alloc]initWithFrame:self.bounds];
    self.ecgView.standard = self.standard;
    [self addSubview:self.ecgView];
    
}


-(void)refreshSubViewFrame{
    /// 计算出总的列数
    int column = self.bounds.size.width / self.standard.oneGridSize;
    /// 网格的宽度
    float width = column * self.standard.oneGridSize;
    
    float ecgHeight = (self.negativeNum + self.positiveNum )  * self.standard.oneGridSize;
    
    if (self.bounds.size.height > ecgHeight) {
        self.ecgView.frame = CGRectMake(0, 0, width, ecgHeight);
    }else{
        self.ecgView.frame = CGRectMake(0, 0, width, self.bounds.size.height);
    }
    self.gridView.frame = CGRectMake(0, 0, width, self.bounds.size.height);
}


-(void)drawStaticECGLine:(NSArray *)voltageArr{
    if(![self.standard parameterIsRight]){
        NSAssert(NO, @"参数有问题");
    }
    _drawECGType = YOECGChartViewStatic;
    _voltageArr = voltageArr;
    
    [self refreshSubViewFrame];

    self.gridView.gridTotal = self.negativeNum + self.positiveNum;
    self.gridView.standard = self.standard;
    self.gridView.secodeLineHeight = 2 * self.standard.oneGridSize;
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
    if(![self.standard parameterIsRight]){
        NSAssert(NO, @"参数有问题");
    }
    [self refreshSubViewFrame];
    
    self.ecgView.positiveNum = self.positiveNum;
    self.ecgView.negativeNum = self.negativeNum;
    self.ecgView.standard = self.standard;
    
    if (twoLine) {
        _drawECGType = YOECGChartViewRealTimeTwoLine;
        [self.ecgView drawRealTimeECGTWoLine:voltageArr];
        return;
    }
    _drawECGType = YOECGChartViewRealTimeOneLine;
    [self.ecgView drawRealTimeECGOneLine:voltageArr];
}


-(void)reloadGridView{
    self.gridView.gridTotal = self.negativeNum + self.positiveNum;
    self.gridView.standard = self.standard;
    self.gridView.secodeLineHeight = 0;
    [self.gridView reloadGrid];
}


-(void)reload{
    [self.gridView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.ecgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (self.drawECGType == YOECGChartViewStatic) {
        [self drawStaticECGLine:self.voltageArr];
    }
}

@end
