//
//  YOECGHeader.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#ifndef YOECGHeader_h
#define YOECGHeader_h


#endif /* YOECGHeader_h */



typedef NS_ENUM(NSInteger, YOECGChartViewAlignment) {
    YOECGChartViewAlignmentLeft, // default
    YOECGChartViewAlignmentCenter,
    YOECGChartViewAlignmentRight,
};

/**
 1kV=1000V
 1V=1000mV
 1mV=1000μV
 */
/// 电压单位
typedef NS_ENUM(NSInteger, YOECGChartViewVoltageUnit) {
    /// default 微伏 uV
    YOECGChartViewVoltageUnitMicroVolt = 0,
    ///   毫伏 mV
    YOECGChartViewVoltageUnitMilliVolt,
    // 伏 v
    YOECGChartViewVoltageUnitVolt,
    // 千伏 kV
    YOECGChartViewVoltageUnitKiloVolt,
    
};


typedef NS_ENUM(NSInteger, YOECGChartViewType) {
    YOECGChartViewStatic, // default
    YOECGChartViewRealTimeOneLine,
    YOECGChartViewRealTimeTwoLine,
};
