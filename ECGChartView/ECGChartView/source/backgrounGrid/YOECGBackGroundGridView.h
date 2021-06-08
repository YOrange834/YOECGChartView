//
//  YOECGBackGroundGridView.h
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "YOECGHeader.h"
#import "YOECGParamter.h"
#import "YOTimeTextParmaramter.h"

NS_ASSUME_NONNULL_BEGIN

/// 背景网格视图
@interface YOECGBackGroundGridView : UIView

@property (nonatomic) YOECGParamter *standard;

/// 对齐方式
@property (nonatomic) YOECGChartViewAlignment showAligment;

///大格字的颜色(一个大格字中有5个小格子)
@property (nonatomic) UIColor *bigGridColor;

///小格字的颜色
@property (nonatomic) UIColor *smallGridColor;


/// 格子的总数(横向，一般是8格)
@property (nonatomic) int gridTotal;

/// 每秒开始出线的格子高度
@property (nonatomic) float secodeLineHeight;

/// 是否展示秒数的文案 高度和secodeLineHegith相同
@property (nonatomic) BOOL isShowSecondText;

/// 时间相关参数设置
@property (nonatomic, strong) YOTimeTextParmaramter *textPar;

/// 开始的秒数
@property (nonatomic) int startSecond;

/// 秒数的CATextLayer
@property (nonatomic) NSMutableArray <CATextLayer *>*textArr;


-(void)reloadGrid;


@end

NS_ASSUME_NONNULL_END
