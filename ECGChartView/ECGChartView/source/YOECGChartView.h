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

NS_ASSUME_NONNULL_BEGIN

@interface YOECGChartView : UIView


@property (nonatomic) YOECGParamter *standard;

@property (strong, nonatomic) YOECGBackGroundGridView *gridView;

@property (strong, nonatomic) YOECGLineView *ecgView;


/*
 查阅大量资料，心电图一般是7大格子 上面4个走正电压 下面3个走负电压
 */

/// 0点位以上的大格子个数 默认4格
@property (nonatomic) int positiveNum;

/// 0点位以上的大格子个数 默认3格
@property (nonatomic) int negativeNum;



-(void)reloadView;


-(void)drawLine:(NSArray *)voltageArr;


-(void)refreshSubViewFrame;

@end

NS_ASSUME_NONNULL_END
