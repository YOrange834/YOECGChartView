//
//  YOECGChartView.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "YOECGParamter.h"
#import "YOECGLineView.h"
#import "YOECGBackGroundGridView.h"
#import "YOECGHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOECGChartView : UIView

/// 心电图相关参数
@property (nonatomic) YOECGParamter *standard;

/// 网格视图
@property (strong, nonatomic) YOECGBackGroundGridView *gridView;

/// 心电图视图
@property (strong, nonatomic) YOECGLineView *ecgView;


/// 0点位以上的大格子个数 默认4格
@property (nonatomic) int positiveNum;

/// 0点位以上的大格子个数 默认3格
@property (nonatomic) int negativeNum;


-(void)drawStaticECGLine:(NSArray *)voltageArr;


/// 实时心电图绘制之前，需要reload 网格线条
-(void)reloadGridView;

/// 实时心电图【双轨迹】
-(void)drawRealTimeECGLine:(NSArray *)voltageArr;

/// 实时心电图【YES 双轨迹 ,NO 单轨迹】
-(void)drawRealTimeECGLine:(NSArray *)voltageArr twoLine:(BOOL)twoLine;


-(void)refreshSubViewFrame;

/// 修改配置参数后刷新视图
-(void)reload;

@end

NS_ASSUME_NONNULL_END
