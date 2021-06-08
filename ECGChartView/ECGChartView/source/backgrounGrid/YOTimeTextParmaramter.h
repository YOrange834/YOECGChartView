//
//  YOTimeTextParmaramter.h
//  ECGChartView
//
//  Created by Mac on 2021/6/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YOTimeTextParmaramter : NSObject

/// 字体大小
@property (nonatomic) int fontSize;

/// 字体名称
@property (nonatomic) NSString *fontName;

/// 字体颜色
@property (nonatomic) UIColor *textColor;

/// 字体背景色
@property (nonatomic) UIColor *backgroundColor;

/// 是否裁剪超出的范围
@property (nonatomic) BOOL isWrapped;


@end

NS_ASSUME_NONNULL_END
