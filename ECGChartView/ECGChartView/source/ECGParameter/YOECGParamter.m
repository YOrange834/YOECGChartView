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

/**
 
 机型                                 开发尺寸             分辨率                  比例            屏幕尺寸          倍图     状态栏H  导航栏H t   abbarH s     afeBottom
 iPhone 4/4S                   320 x 480 pt       960  x 640  px          3:2            3.5英寸             @2x        20          44          49    0
 iPhone 5/5c/5s/SE         320 x 568 pt     1136 x 640  px          16:9           4.0英寸             @2x        20          44          49    0
 iPhone 6/6s/7/8              375 x 667 pt     1134 x 750  px          16:9           4.7英寸             @2x        20          44          49    0
 iPhone 6+/6s+/7+/8+     414 x 736 pt      1920 x 1080 px          16:9           5.5英寸             @3x        20          44          49    0
 iPhone XR                    414 x 896 pt       1792 x 828  px          19.5:9         6.1英寸             @2x        48          44          83    34
 iPhone X/XS                 375 x 812 pt       2436 x 1125 px          19.5:9         5.8英寸             @3x        44          44          83    34
 iPhone XS Max           414 x 896 pt         2688 x 1242 px          19.5:9         6.5英寸             @3x        44          44          83    34
 iPhone 11                    414 x 896 pt        1792 × 828  px          19.5:9         6.1英寸             @2x        48          44          83    34
 iPhone 11 Pro             375 x 812 pt        2436 × 1125 px          19.5:9         5.8英寸             @3x        44          44          83    34
 iPhone 11 Pro Max      414 x 896 pt        2688 × 1242 px          19.5:9         6.5英寸             @3x        44          44          83    34
 iPhone 12 / 12 Pro     390 x 844 pt        2532 x 1170 px          19.5:9         6.1英寸             @3x        47          44          83    34
 iPhone 12 Pro Max     428 x 926 pt        2778 x 1284 px          19.5:9         6.7英寸             @3x        47          44          83    34
 iPhone 12 mini            375 x 812 pt        2340 x 1080 px          19.5:9         5.4英寸             @3x        44          44          83    34
 
 */


@end
