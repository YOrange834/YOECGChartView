//
//  YOECGLineView.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "YOECGLineView.h"

@interface YOECGLineView()

@property (strong, nonatomic) CAShapeLayer *lineLayer;

// ------ 实时心电图需要的

///前一个点
@property (assign, nonatomic) CGPoint beforePoint;

///实时心电运动的路径
@property (strong, nonatomic) UIBezierPath *linePath;

///两条心电轨迹的时候需要用到，是否开始减少
@property (assign, nonatomic) BOOL isStartReduce;

///心电图贝塞尔路径
@property (strong, nonatomic) NSMutableArray <UIBezierPath *> *pathArr;

@end



@implementation YOECGLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.voltageUnit = YOECGChartViewVoltageUnitMicroVolt;
    }
    return self;
}


/// 画静态图
-(void)drawStaticECGLine:(NSArray *)voltageArr{
    if (voltageArr == 0) {
        return;
    }
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    /// 1mv的尺寸  一大格 0.5mV
    float oneVHeight = self.standard.onePointHeight; // pt/mV
    /// 中心点的高度 静息状态
    float centerY = self.positiveNum * self.standard.oneGridSize;
    
    float xWidth = self.standard.onePointWidth;
    
    /// 目的 将输入的电压转为 mV ()
    float voltageRate = 1000 / pow(1000, self.voltageUnit);
    
    if(self.voltageUnit == YOECGChartViewVoltageUnitMicroVolt){
        voltageRate = 1000 / pow(1000, self.standard.voltageUnit);
    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    {
        float y = [voltageArr.firstObject floatValue] / voltageRate * oneVHeight;
        [path moveToPoint:CGPointMake(0 , centerY - y)];
    }

    for (int i = 1; i < voltageArr.count; i++) {
        float y = [voltageArr[i] floatValue] / voltageRate * oneVHeight;
        CGPoint point = CGPointMake(i * xWidth , centerY - y);
        [path addLineToPoint:point];
    }
    
    CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
    chartLevelLine.lineCap      = kCALineCapRound;
    chartLevelLine.fillColor    = nil;
    chartLevelLine.lineWidth    = 1;
    chartLevelLine.strokeEnd    = 0.0;
    chartLevelLine.path = path.CGPath;
    chartLevelLine.lineJoin = kCALineJoinRound;

    chartLevelLine.strokeColor = [[UIColor redColor] CGColor] ;
          
    chartLevelLine.strokeEnd = 1.0;

    [self.layer addSublayer:chartLevelLine];
    _lineLayer = chartLevelLine;
    
}

/// 实时心电图
-(void)drawRealTimeECGTWoLine:(NSArray *)voltageArr{
    [self reloadConfig];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_beforePoint];
    
    
    /// 1mv的尺寸  一大格 0.5mV
    float oneVHeight = self.standard.onePointHeight; // pt/mV
    /// 中心点的高度 静息状态
    float centerY = self.positiveNum * self.standard.oneGridSize;
    
    float xWidth = self.standard.onePointWidth;
    
    /// 目的 将输入的电压转为 mV
    float voltageRate = 1000 / pow(1000, self.voltageUnit);
    

    if (_beforePoint.x + self.standard.oneGridSize * 2 > self.frame.size.width) { //大于两个点
        _isStartReduce = YES;

        for (int i = 0; i < voltageArr.count; i++) {
            if (_beforePoint.x >= self.frame.size.width){

                CGPoint point = CGPointMake(0, centerY - [voltageArr[i] floatValue] / voltageRate * oneVHeight);
                [path moveToPoint:point];
                _beforePoint = point;

            }else{
                CGPoint point = CGPointMake(_beforePoint.x + xWidth , centerY - [voltageArr[i] floatValue] / voltageRate * oneVHeight);
                [path addLineToPoint:point];
                _beforePoint = point;
            }

        }

    }else{
        for (int i = 1; i < voltageArr.count; i++) {
            CGPoint point = CGPointMake(_beforePoint.x + xWidth , centerY - [voltageArr[i] floatValue] / voltageRate * oneVHeight);
            [path addLineToPoint:point];
            _beforePoint = point;
        }
    }
    [self.pathArr addObject:path];


    if (_isStartReduce) {
        [self.pathArr removeObjectAtIndex:0];
    }

    UIBezierPath *linePath = [UIBezierPath bezierPath];
    for (int i = 0; i < self.pathArr.count; i++) {
        [linePath appendPath:self.pathArr[i]];
    }
    
    _lineLayer.path = linePath.CGPath;
}


-(void)drawRealTimeECGOneLine:(NSArray *)voltageArr{
    [self reloadConfig];
    
    /// 1mv的尺寸  一大格 0.5mV
    float oneVHeight = self.standard.onePointHeight; // pt/mV
    /// 中心点的高度 静息状态
    float centerY = self.positiveNum * self.standard.oneGridSize;
    
    float xWidth = self.standard.onePointWidth;
    
    /// 目的 将输入的电压转为 mV
    float voltageRate = 1000 / pow(1000, self.voltageUnit);
    
    for (int i = 0; i < voltageArr.count; i++) {
        if (_beforePoint.x >= self.frame.size.width) {
            _linePath = [UIBezierPath bezierPath];
            _beforePoint.x = 0;
            [_linePath moveToPoint:_beforePoint];
            _beforePoint = CGPointMake(xWidth ,  centerY - [voltageArr[i] floatValue] / voltageRate * oneVHeight);
            [_linePath addLineToPoint:_beforePoint];
        }else{
            CGPoint point = CGPointMake(_beforePoint.x + xWidth , centerY - [voltageArr[i] floatValue] / voltageRate * oneVHeight);
            [_linePath addLineToPoint:point];
            _beforePoint = point;
        }
        NSLog(@"%@",NSStringFromCGPoint(_beforePoint));
        
    }
    _lineLayer.path = _linePath.CGPath;
}



///刷新配置信息
-(void)reloadConfig{
    if (_lineLayer) {
        return;
    }
    
    _linePath = [UIBezierPath bezierPath];
    [_linePath moveToPoint:CGPointMake(0, self.positiveNum * self.standard.oneGridSize)];
    _beforePoint = CGPointMake(0, self.positiveNum * self.standard.oneGridSize);
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineCap       = kCALineCapButt;
    lineLayer.fillColor     = [[UIColor clearColor] CGColor];
    lineLayer.lineWidth     = 2;
    lineLayer.path          = _linePath.CGPath;
    lineLayer.lineJoin      = kCALineJoinRound; //拐点处理

    lineLayer.strokeColor = [[UIColor redColor] CGColor] ;
    lineLayer.strokeEnd = 1.0;

    [self.layer addSublayer:lineLayer];
    _lineLayer = lineLayer;
    
}




///清楚数据
-(void)clearData{
    [_lineLayer removeFromSuperlayer];
    /// 一条轨迹的
    _beforePoint = CGPointMake(0, self.frame.size.height / 2.0);
    if (_linePath) {
        _linePath = [UIBezierPath bezierPath];
        [_linePath moveToPoint:CGPointMake(0, self.frame.size.height / 2.0)];
        _lineLayer.path = _linePath.CGPath;
    }
    /// 两条轨迹的
    _isStartReduce = NO;
    [_pathArr removeAllObjects];
    
}


-(NSMutableArray<UIBezierPath *> *)pathArr{
    if (!_pathArr) {
        _pathArr = [NSMutableArray array];
    }
    return _pathArr;
}





@end
