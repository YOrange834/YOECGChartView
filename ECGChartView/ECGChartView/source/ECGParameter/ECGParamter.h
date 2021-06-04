//
//  ECGParamter.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ECGParamter : NSObject

/// 走纸速速 默认25mm/s (0.025s)
@property (nonatomic,readonly) int speed;

/// 采样频率 默认 250HZ
@property (nonatomic) int sampleFrequency;

/// 纸张规格 10 mV/mm (一小格 10mV)
@property (nonatomic,readonly) int voltageSpecifications;


/// 一大格的尺寸(正方形尺寸一样)
@property (nonatomic) float oneGridSize;


@end

NS_ASSUME_NONNULL_END
