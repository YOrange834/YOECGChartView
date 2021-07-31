//
//  ECGParamter.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import <Foundation/Foundation.h>
#import "YOECGHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOECGParamter : NSObject

/// 走纸速速 默认25mm/s (0.025s) 【不建议修改】
@property (nonatomic) int speed;

/// 采样频率 默认 250HZ  【不建议修改】
@property (nonatomic) int sampleFrequency;

/// 纸张规格 10 mm/mV (一小格 0.1mV)  【不建议修改】
@property (nonatomic) int voltageSpecifications;

/// 一大格的尺寸(正方形尺寸一样)
@property (nonatomic) float oneGridSize;

/// 输入数据的电压单位 默认 uV 微伏
@property (assign, nonatomic) YOECGChartViewVoltageUnit voltageUnit;

/// 每秒的格子数
@property (nonatomic,readonly) float secodePerWidth;

/// 两个点之间的间隔(通过采样频率和每个格子的尺寸计算得来)
@property (nonatomic, readonly) float onePointWidth;

/// 两个点之间的间隔高度(通过纸张规格和每个格子的尺寸计算得来)
@property (nonatomic, readonly) float onePointHeight;

/// 判断参数是否正确
-(BOOL)parameterIsRight;


@end

NS_ASSUME_NONNULL_END
