//
//  YOECGBackGroundGridView.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "YOECGBackGroundGridView.h"

@interface YOECGBackGroundGridView()

///大网格视图
@property (strong, nonatomic) CAShapeLayer *bigGridLayer;

///小网格视图
@property (strong, nonatomic) CAShapeLayer *smallGridLayer;

@end

@implementation YOECGBackGroundGridView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configDefaultPar];
    }
    return self;
}

/// 配置一些默认参数
-(void)configDefaultPar{
    self.bigGridColor = [UIColor colorWithRed:0x99 / 255.0 green:0x99 / 255.0 blue:0x99 / 255.0 alpha:1];
    self.smallGridColor = [UIColor colorWithRed:0xEE / 255.0 green:0xEE / 255.0 blue:0xEE / 255.0 alpha:1.0];
    self.secodeLineHeight = 0;
    self.startSecond = 0;
    self.textArr = [NSMutableArray array];
    self.textPar = [[YOTimeTextParmaramter alloc]init];
}


///刷新网格视图
-(void)reloadGrid{
    if (_smallGridLayer) {
        [_smallGridLayer removeFromSuperlayer];
    }
    if (_bigGridLayer) {
        [_bigGridLayer removeFromSuperlayer];
    }
    for (CATextLayer *lab in self.textArr) {
        [lab removeFromSuperlayer];
    }
    [self.textArr removeAllObjects];
    
    UIBezierPath *smallline = [UIBezierPath bezierPath];
    UIBezierPath *bigline = [UIBezierPath bezierPath];

    /// 计算出总的列数
    int column = roundf(self.bounds.size.width / self.standard.oneGridSize);
    
    ///网格的高度
    float height = self.gridTotal * self.standard.oneGridSize;
    /// 网格的宽度
    float width = column * self.standard.oneGridSize;
    /// 一个小格子的储存
    float size = self.standard.oneGridSize / 5;
    
    /// 默认左对齐
    float startX = 0;
    switch (self.showAligment) {
        case YOECGChartViewAlignmentCenter:
            startX = (self.bounds.size.width - width) / 2.0;
            break;
        case YOECGChartViewAlignmentRight:
            startX = self.bounds.size.width - width;
            break;
        default:
            break;
    }
    
    for (int i = 0; i <= self.gridTotal * 5; i++) { // 横线
        UIBezierPath *nowPath = i % 5 == 0 ? bigline : smallline;
        [nowPath moveToPoint:CGPointMake(startX, size * i)];
        [nowPath addLineToPoint:CGPointMake(startX + width ,size * i)];
    }
    
    for (int i = 0; i <= column * 5; i++) {  // 竖线
        if (i % self.standard.speed == 0) {
            [bigline moveToPoint:CGPointMake(startX + size * i , 0)];
            [bigline addLineToPoint:CGPointMake(startX + size * i, height + self.secodeLineHeight)];
            if (self.isShowSecondText &&  i < column * 5) {
                CATextLayer *lab = [CATextLayer layer];
                lab.frame = CGRectMake(startX + size * i, height + (self.secodeLineHeight - 12) / 2, startX + size * self.standard.speed , self.secodeLineHeight);
                lab.string = [NSString stringWithFormat:@"%ds",self.startSecond + i / self.standard.speed];
                [self configSecondLayerText:lab];
            }
        }else{
            UIBezierPath *nowPath = i % 5 == 0 ? bigline : smallline;
            [nowPath moveToPoint:CGPointMake(startX + size * i , 0)];
            [nowPath addLineToPoint:CGPointMake(startX + size * i, height)];
        }
    }

    [smallline setLineWidth:0.0];
    [smallline setLineCapStyle:kCGLineCapSquare];
    
    [bigline setLineWidth:0.0];
    [bigline setLineCapStyle:kCGLineCapSquare];
    
    {
        CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
        chartLevelLine.lineCap      = kCALineCapButt;
        chartLevelLine.fillColor    = [UIColor redColor].CGColor; //[self.smallGridColor CGColor];
        chartLevelLine.lineWidth    = 0.5;
        chartLevelLine.strokeEnd    = 0.0;
        chartLevelLine.path = smallline.CGPath;
        chartLevelLine.strokeEnd = 1.0;
        chartLevelLine.strokeColor = [self.smallGridColor CGColor];
        _smallGridLayer = chartLevelLine;
    }
    {
        CAShapeLayer *chartLevelLine = [CAShapeLayer layer];
        chartLevelLine.lineCap      = kCALineCapButt;
        chartLevelLine.fillColor    = [self.bigGridColor CGColor];
        chartLevelLine.lineWidth    = 0.5;
        chartLevelLine.strokeEnd    = 0.0;
        chartLevelLine.path = bigline.CGPath;
        chartLevelLine.strokeEnd = 1.0;
        chartLevelLine.strokeColor = [self.bigGridColor CGColor];
        _bigGridLayer = chartLevelLine;
    }
    [self.layer addSublayer:_smallGridLayer];
    [self.layer addSublayer:_bigGridLayer];
}


-(void)configSecondLayerText:(CATextLayer *)label{
    label.wrapped = self.textPar.isWrapped;
    label.foregroundColor = self.textPar.textColor.CGColor;
    label.font = (__bridge CFTypeRef _Nullable)self.textPar.fontName;
    label.fontSize = self.textPar.fontSize;
    label.contentsScale = [UIScreen mainScreen].scale;
    if (self.textPar.backgroundColor) label.backgroundColor = self.textPar.backgroundColor.CGColor;
    [self.layer addSublayer:label];
    [self.textArr addObject:label];
}



@end
