# ECG

### How to use YOECGChartView

* installation with CocoaPods: 

  ```
  pod 'YOECGChartView', :git => 'https://github.com/YOrange834/YOECGChartView.git'
  ```

  

### show

![IMG_2233](https://github.com/YOrange834/YOECGChartView/blob/main/res/IMG_2233%E5%89%AF%E6%9C%AC.png)



### 参数调试

![IMG_2233](https://github.com/YOrange834/YOECGChartView/blob/main/res/report_par.png)

```objective-c
/// 走纸速速 默认25mm/s (0.025s) 【不建议修改】
@property (nonatomic) int speed;

/// 采样频率 默认 250HZ  【不建议修改】
@property (nonatomic) int sampleFrequency;

/// 纸张规格 10 mm/mV (一小格 0.1mV)  【不建议修改】
@property (nonatomic) int voltageSpecifications;

/// 一大格的尺寸(正方形尺寸一样)
@property (nonatomic) float oneGridSize;

/// 输入数据的电压单位 默认 uV 微伏
@property (assign, nonatomic) YOECGChartViewVoltageUnit voltageUnit;
```

调节上面参数可以修改视图大小



### Swift

> (>=0.0.3)完善Swift Demo



### Other Function 

You can click  https://github.com/YOrange834/HealthChartView

