//
//  ECGParamter.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "YOECGParamter.h"
#import <UIKit/UIKit.h>
@implementation YOECGParamter

-(instancetype)init{
    if (self = [super init]) {
        self.speed = 25;
        self.voltageSpecifications = 10;
        self.sampleFrequency = 250;
        self.oneGridSize = [self oneMillimetrePt] * 5;
        self.voltageUnit = YOECGChartViewVoltageUnitMicroVolt;
    }
    return self;
}

-(float)secodePerWidth{
    return self.speed;
}

-(float)onePointWidth{
    /**
     1 格子 = self.oneGridSize / 5.0
     1 格子 = 1mm
     1s走纸距离(格子数) = 速度 * 时间 => self.speed * 1 =  self.speed * 1
     1s走纸点数 = self.sampleFrequency;
     每个点的 pt 为 格子数 * 一个格子的距离 => self.speed * self.oneGridSize / 5.0
     */
    return self.speed * self.oneGridSize / 5.0 / self.sampleFrequency ;
}

-(float)onePointHeight{
    /**
     
     voltageSpecifications 纸张规格 10 mm/mV (一小格 0.1mV)  【不建议修改】
     
     1 格子 = self.oneGridSize / 5.0
     1 格子 = 1mm / 0.1mV
     1 格子 = 1mm / voltageSpecifications mm/mV  = (1.0 / voltageSpecifications )mV
     
     每个点的 pt 为 格子数 * 一个格子的距离 => self.speed * self.oneGridSize / 5.0
     */
    return self.oneGridSize / 5.0 / (1.0 / self.voltageSpecifications); // 每个距离的mV  =>  pt / mV
    
}


-(float)oneMillimetrePt{
    CGFloat sc_w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat sc_h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat sc_s;
    CGFloat ff = [[UIScreen mainScreen] nativeBounds].size.height;
    
    if (ff == 1136) {
        sc_s = 4.0;
    }else if(ff == 1334.0){
        sc_s = 4.7;
    }else if (ff == 2340){
        sc_s = 5.4;
    }else if (ff== 1920){
        sc_s = 5.5;
    }else if (ff== 2436){
        sc_s = 5.8;
    }else if (ff == 1792){
        sc_s = 6.1;
    }else if (ff == 2532){
        sc_s = 6.1;
    }else if (ff == 2688){
        sc_s = 6.5;
    }else if (ff == 2778){
        sc_s = 6.7;
    }else{
        sc_s = 5.8;
    }
    
    //1mm米的像素点
    float ppm = sqrt(sc_w * sc_w + sc_h * sc_h)/(sc_s * 25.4) ;//mm
    return ppm;// / [UIScreen mainScreen].scale;
}



-(BOOL)parameterIsRight{
    return self.speed * self.sampleFrequency * self.voltageSpecifications * self.oneGridSize > 0;
}


@end
