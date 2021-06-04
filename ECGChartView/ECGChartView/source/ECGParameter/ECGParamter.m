//
//  ECGParamter.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "ECGParamter.h"

@implementation ECGParamter

-(instancetype)init{
    if (self = [super init]) {
        self.sampleFrequency = 250;
        self.oneGradeSize = 257 / 14.0 / 5;
    }
    return self;
}


-(int)speed{
    return 25;
}

-(int)voltageSpecifications{
    return 10;
}


@end
