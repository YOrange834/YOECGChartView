//
//  YOECGLineView.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "YOECGLineView.h"

@interface YOECGLineView()

@property (strong, nonatomic) CAShapeLayer *lineLayer;

///前一个点
@property (assign, nonatomic) CGPoint beforePoint;

@end



@implementation YOECGLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)drawECGLine:(NSArray *)voltageArr{
    if (voltageArr == 0) {
        return;
    }
    
    /// 1mv的尺寸  一大格 0.5mV
    float oneVHeight = self.standard.onePointHeight; // pt/mV
    /// 中心点的高度 静息状态
    float centerY = self.positiveNum * self.standard.oneGridSize;
    
    float xWidth = self.standard.onePointWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    {
        float y = [voltageArr.firstObject intValue] / 1000.0 * oneVHeight;
        [path moveToPoint:CGPointMake(0 , centerY - y)];
    }

    for (int i = 1; i < voltageArr.count; i++) {
        float y = [voltageArr[i] intValue] / 1000.0 * oneVHeight;
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

///清楚数据
-(void)clearData{
    [_lineLayer removeFromSuperlayer];
}



//-(void)drawTwoLinwMap:(NSArray *)arr{
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:_beforePoint];
//    if (_beforePoint.x + self.standard.oneGridSize * 2 > self.frame.size.width) { //大于两个点
//        _isStartReduce = YES;
//
//        for (int i = 0; i < arr.count; i++) {
//            if (_beforePoint.x >= self.frame.size.width){
//
//                CGPoint point = CGPointMake(0, self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
//                [path moveToPoint:point];
//                _beforePoint = point;
//
//            }else{
//                CGPoint point = CGPointMake(_beforePoint.x + _pointX , self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
//                [path addLineToPoint:point];
//                _beforePoint = point;
//            }
//
//        }
//
//    }else{
//        for (int i = 1; i < arr.count; i++) {
//            CGPoint point = CGPointMake(_beforePoint.x + _pointX , self.frame.size.height / 2.0 - _pointY * [arr[i] intValue]);
//            [path addLineToPoint:point];
//            _beforePoint = point;
//        }
//    }
//    [self.pathArr addObject:path];
//
//
//    if (_isStartReduce) {
//        [self.pathArr removeObjectAtIndex:0];
//    }
//
//    UIBezierPath *linePath = [UIBezierPath bezierPath];
//    for (int i = 0; i < self.pathArr.count; i++) {
//        [linePath appendPath:self.pathArr[i]];
//    }
//    _lineLayer.path = linePath.CGPath;
//}
//


@end
