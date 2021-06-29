//
//  ECGReportViewController.m
//  ECGChartView
//
//  Created by Mac on 2021/6/4.
//

#import "ECGReportViewController.h"
#import "YOECGChartView.h"

@interface ECGReportViewController ()<UIScrollViewDelegate>

@property (nonatomic) YOECGChartView *ecg ;
@property (assign, nonatomic) float picWidth;  //图片的宽度
@property (assign, nonatomic) float picHeight; //图片的高度
@end

@implementation ECGReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
    //当数据结构为数组时
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:data];
//    for (int i = 0; i < dataArr.count; i++) {
//        NSNumber *str = dataArr[i];
//        dataArr[i] = @(-str.intValue);
//    }
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 88, [[UIScreen mainScreen] bounds].size.width, 400))];
    
    
    YOECGChartView *ecg = [[YOECGChartView alloc]initWithFrame:(CGRectMake(10, 88, [[UIScreen mainScreen] bounds].size.width, 400))];
    ecg.standard.sampleFrequency = 500;
//    ecg.standard.speed = 25;
    
    ecg.ecgView.clipsToBounds = YES;
    
    float width = dataArr.count * ecg.standard.onePointWidth;
    CGRect frame = ecg.frame;
    frame.size.width = width;
    ecg.frame = frame;
    
    scrollView.contentSize = CGSizeMake(width + 20, 400);
    scrollView.maximumZoomScale = 5;
    
    [ecg refreshSubViewFrame];
    
    ecg.gridView.isShowSecondText = YES;
    ecg.gridView.startSecond = 0;
    
//    ecg.oneGradeSize = 257 / 14.0 / 5
    
    [ecg drawStaticECGLine:dataArr];
    
    [scrollView addSubview:ecg];
    
    _ecg = ecg;
    
    _picWidth = width;
    _picHeight = 400;
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
//    self.view.backgroundColor = UIColor.greenColor;
    
}


//返回需要缩放的视图控件 缩放过程中
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _ecg;
}

//开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    NSLog(@"开始缩放");
}
//结束缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"结束缩放");
}

//缩放中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 延中心点缩放
    CGFloat imageScaleWidth = scrollView.zoomScale * _picWidth;
    CGFloat imageScaleHeight = scrollView.zoomScale * _picHeight;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    if (imageScaleWidth < self.view.frame.size.width) {
        imageX = floorf((self.view.frame.size.width - imageScaleWidth) / 2.0);
    }
    if (imageScaleHeight < self.view.frame.size.height) {
        imageY = floorf((self.view.frame.size.height - imageScaleHeight) / 2.0);
    }
    _ecg.frame = CGRectMake(imageX, imageY, imageScaleWidth, imageScaleHeight);
}



@end
