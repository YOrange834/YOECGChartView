//
//  YOECGLineView.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "YOECGParamter.h"
#import "YOECGHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOECGLineView : UIView

@property (nonatomic) YOECGParamter *standard;

/// 输入数据的电压单位 默认 uV 微伏
@property (assign, nonatomic) YOECGChartViewVoltageUnit voltageUnit;


/// 正电压大格子个数 默认4格
@property (nonatomic) int positiveNum;

/// 负电压的大格子个数 默认3格
@property (nonatomic) int negativeNum;


-(void)drawStaticECGLine:(NSArray *)voltageArr;





@end

NS_ASSUME_NONNULL_END
