//
//  YOECGChartView.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "ECGParamter.h"

NS_ASSUME_NONNULL_BEGIN

@interface YOECGChartView : UIView


@property (nonatomic) ECGParamter *standard;

/*
 查阅大量资料，心电图一般是7大格子 上面4个走正电压 下面3个走负电压
 */

/// 0点位以上的大格子个数 默认4格
@property (nonatomic) int positiveNum;

/// 0点位以上的大格子个数 默认3格
@property (nonatomic) int negativeNum;



-(void)reloadView;


-(void)drawLine:(NSArray *)voltageArr;


@end

NS_ASSUME_NONNULL_END
