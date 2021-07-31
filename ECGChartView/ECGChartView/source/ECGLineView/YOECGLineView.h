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

/// 输入数据的电压单位 默认 uV 微伏 【兼容以前的版本，慎用次字段，以后会去掉】
@property (assign, nonatomic) YOECGChartViewVoltageUnit voltageUnit DEPRECATED_MSG_ATTRIBUTE("use self.standard.voltageUnit");


/// 正电压大格子个数 默认4格
@property (nonatomic) int positiveNum;

/// 负电压的大格子个数 默认3格
@property (nonatomic) int negativeNum;


-(void)drawStaticECGLine:(NSArray *)voltageArr;


/// 实时心电图【双轨迹】
-(void)drawRealTimeECGTWoLine:(NSArray *)voltageArr;

/// 实时心电图 【单条轨迹】
-(void)drawRealTimeECGOneLine:(NSArray *)voltageArr;


-(void)clearData;

@end

NS_ASSUME_NONNULL_END
