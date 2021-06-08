//
//  YOTimeTextParmaramter.m
//  ECGChartView
//
//  Created by Mac on 2021/6/8.
//

#import "YOTimeTextParmaramter.h"

@implementation YOTimeTextParmaramter

-(instancetype)init{
    if (self = [super init]) {
        self.textColor = [UIColor colorWithRed:0x99 / 255.0 green:0x99 / 255.0 blue:0x99 / 255.0 alpha:1];
        self.fontName = [UIFont systemFontOfSize:30].fontName;
        self.fontSize = 12;
        self.isWrapped = YES;
    }
    return self;
}


@end
