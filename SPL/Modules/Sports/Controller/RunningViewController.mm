//
//  RunningViewController.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "RunningViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "RunStatusView.h"
#import "SportsRequest.h"
#import "TTAlertView.h"
typedef enum : NSUInteger {
    TrailStart,
    TrailEnd
} Trail;

@interface RunningViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate,RunStatusViewDelegate,TTAlertViewDelegate>
/** 百度定位地图服务 */
@property (nonatomic, strong) BMKLocationService *bmkLocationService;
/** 百度地图View */
@property (nonatomic,strong) BMKMapView *mapView;
/** 记录上一次的位置 */
@property (nonatomic, strong) CLLocation *preLocation;
/** 位置数组 */
@property (nonatomic, strong) NSMutableArray *locationArrayM;
/** 轨迹线 */
@property (nonatomic, strong) BMKPolyline *polyLine;
/** 轨迹记录状态 */
@property (nonatomic, assign) Trail trail;
/** 起点大头针 */
@property (nonatomic, strong) BMKPointAnnotation *startPoint;
/** 终点大头针 */
@property (nonatomic, strong) BMKPointAnnotation *endPoint;
/** 累计步行时间 */
@property (nonatomic,assign) NSTimeInterval sumTime;
/** 累计步行距离 */
@property (nonatomic,assign) CGFloat sumDistance;

@property (nonatomic,strong) RunStatusView *statusView;

@property (nonatomic,strong) UIButton *fullScreenBtn;

@end

@implementation RunningViewController

- (void)dealloc
{
    DBG(@"dealloc----RunningViewController");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.bmkLocationService.delegate = self;
    [self startTrack];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.bmkLocationService.delegate = nil;
    
//    [self.statusView.timeContentLabel]
//    [self.statusView.timeContentLabel pause];;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化百度位置服务
    [self initBMLocationService];
    
    // 初始化地图窗口
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT)];
    
    // 设置地图窗口上的子控件
    [self setupMapViewSubViews];
    
    // 设置MapView的一些属性
    [self setMapViewProperty];
    
    // 状态信息view  // 初始化 状态信息
//    self.statusView = [[RunStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
    
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.statusView];
    
    // 状态信息View回调
//    self.statusView.delegate = self;

}
/**
 *  初始状态view
 */
- (RunStatusView *)statusView
{
    if (!_statusView) {
        _statusView = [[RunStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _statusView.delegate = self;
    }
    return _statusView;
}


/**
 *  初始化百度位置服务
 */
- (void)initBMLocationService
{
    // 初始化位置百度位置服务
    self.bmkLocationService = [[BMKLocationService alloc] init];
    
    //设置更新位置频率(单位：米;必须要在开始定位之前设置)
    //    [self.bmkLocationService setDistanceFilter:5];
    self.bmkLocationService.distanceFilter = 50;
//    [BMKLocationService setLocationDistanceFilter:5];
    self.bmkLocationService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    
    //    [self.bmkLocationService setDesiredAccuracy:kCLLocationAccuracyBest];
}


#pragma mark - "IBAction" Method

/**
 *  开启百度地图定位服务
 */
- (void)startTrack
{
    // 1.清理上次遗留的轨迹路线以及状态的残留显示
    [self clean];
    
    // 2.打开定位服务
    [self.bmkLocationService startUserLocationService];
    
    // 3.更新状态栏的“是否打开地理位置服务”的 Label
    //    self.statusView.startLocatonServiceLabel.text = @"YES";
    //    self.statusView.stopLocatonServiceLabel.text = @"NO";
    
    // 4.设置当前地图的显示范围，直接显示到用户位置
    BMKCoordinateRegion adjustRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(self.bmkLocationService.userLocation.location.coordinate, BMKCoordinateSpanMake(0.02f,0.02f))];
    [self.mapView setRegion:adjustRegion animated:YES];
    
    // 5.如果计时器在计时则复位
    if ([self.statusView.timeContentLabel counting] || self.statusView.timeContentLabel.text != nil) {
        [self.statusView.timeContentLabel reset];
    }
    
    // 6.开始计时
    [self.statusView.timeContentLabel start];
    
    // 7.设置轨迹记录状态为：开始
    self.trail = TrailStart;
}
/**
 *  清空数组以及地图上的轨迹
 */
- (void)clean
{
    // 清空状态栏信息
    self.statusView.distanceLabel.text = nil;
    //    self.statusView.avgSpeed.text = nil;
    self.statusView.speedContentLabel.text = nil;
    //    self.statusView.sumTime.text = nil;
    //    self.statusView.latituteLabel.text = nil;
    //    self.statusView.longtituteLabel.text = nil;
    //    self.statusView.distanceWithPreLoc.text = nil;
    //    self.statusView.startLocatonServiceLabel.text = @"NO";
    //    self.statusView.stopLocatonServiceLabel.text = @"YES";
    //    self.statusView.startPointLabel.text = @"NO";
    //    self.statusView.stopPointLabel.text = @"NO";
    
    //清空数组
    [self.locationArrayM removeAllObjects];
    
    //清屏，移除标注点
    if (self.startPoint) {
        [self.mapView removeAnnotation:self.startPoint];
        self.startPoint = nil;
    }
    if (self.endPoint) {
        [self.mapView removeAnnotation:self.endPoint];
        self.endPoint = nil;
    }
    if (self.polyLine) {
        [self.mapView removeOverlay:self.polyLine];
        self.polyLine = nil;
    }
}


/**
 *  停止百度地图定位服务
 */
- (void)stopTrack
{
    // 1.停止计时器
    [self.statusView.timeContentLabel pause];
    DBG(@"累计计时为：%@",self.statusView.timeContentLabel.text);
    
    // 2.更新状态栏的“是否打开地理位置服务”的 Label
    //    self.statusView.startLocatonServiceLabel.text = @"NO";
    //    self.statusView.stopLocatonServiceLabel.text = @"YES";
    
    // 3.设置轨迹记录状态为：结束
    self.trail = TrailEnd;
    
    // 4.关闭定位服务
    [self.bmkLocationService stopUserLocationService];
    
    // 5.添加终点旗帜
    if (self.startPoint) {
        self.endPoint = [self creatPointWithLocaiton:self.preLocation title:@"终点"];
    }
    
    
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.locationArrayM];
    //NSString *s = [data base64Encoding];
    //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    
    //NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"%@",jsonStr);
}

/**
 *  添加一个大头针
 *
 *  @param location
 */
- (BMKPointAnnotation *)creatPointWithLocaiton:(CLLocation *)location title:(NSString *)title;
{
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = title;
    [self.mapView addAnnotation:point];
    
    return point;
}

/**
 *  设置 百度MapView的一些属性
 */
- (void)setMapViewProperty
{
    // 显示定位图层
    self.mapView.showsUserLocation = YES;
    
    // 设置定位模式
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    
    // 允许旋转地图
    self.mapView.rotateEnabled = YES;
    
    // 显示比例尺
    //    self.bmkMapView.showMapScaleBar = YES;
    //    self.bmkMapView.mapScaleBarPosition = CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50);
    
    // 定位图层自定义样式参数
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = NO;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = NO;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    displayParam.locationViewImgName = @"walk";
    [self.mapView updateLocationViewWithParam:displayParam];
}


#pragma mark - BMKLocationServiceDelegate
/**
 *  定位失败会调用该方法
 *
 *  @param error 错误信息
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"did failed locate,error is %@",[error localizedDescription]);
    UIAlertView *gpsWeaknessWarning = [[UIAlertView alloc]initWithTitle:@"Positioning Failed" message:@"Please allow to use your Location via Setting->Privacy->Location" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [gpsWeaknessWarning show];
}

/**
 *  用户位置更新后，会调用此函数
 *  @param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    // 1. 动态更新我的位置数据
    [self.mapView updateLocationData:userLocation];
    DBG(@"La:%f, Lo:%f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    // 2. 更新状态栏的经纬度 Label
    //    self.statusView.latituteLabel.text = [NSString stringWithFormat:@"%.4f",userLocation.location.coordinate.latitude];
    //    self.statusView.longtituteLabel.text = [NSString stringWithFormat:@"%.4f",userLocation.location.coordinate.longitude];
    //    self.runStatusView.avgSpeed.text = [NSString stringWithFormat:@"%.2f",userLocation.location.speed];
    
    // 3. 如果精准度不在100米范围内
    if (userLocation.location.horizontalAccuracy > kCLLocationAccuracyNearestTenMeters) {
        DBG(@"userLocation.location.horizontalAccuracy is %f",userLocation.location.horizontalAccuracy);
//        UIAlertView *gpsSignal = [[UIAlertView alloc]initWithTitle:@"GPS Signal" message:@"Hey,GPS Signal is terrible,please move your body..." delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil, nil];
        //        [gpsSignal show];
        //        return;
    }//else if (TrailStart == self.trail) { // 开始记录轨迹
    [self startTrailRouteWithUserLocation:userLocation];
    //}
}

/**
 *  用户方向更新后，会调用此函数
 *  @param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    // 动态更新我的位置数据
    [self.mapView updateLocationData:userLocation];
}


#pragma mark - Selector for didUpdateBMKUserLocation:
/**
 *  开始记录轨迹
 *
 *  @param userLocation 实时更新的位置信息
 */
- (void)startTrailRouteWithUserLocation:(BMKUserLocation *)userLocation
{
    if (self.preLocation) {
        // 计算本次定位数据与上次定位数据之间的时间差
        NSTimeInterval dtime = [userLocation.location.timestamp timeIntervalSinceDate:self.preLocation.timestamp];
        
        // 累计步行时间
        self.sumTime += dtime;
        //        self.statusView.sumTime.text = [NSString stringWithFormat:@"%.3f",self.sumTime];
        
        // 计算本次定位数据与上次定位数据之间的距离
        CGFloat distance = [userLocation.location distanceFromLocation:self.preLocation];
        //        self.statusView.distanceWithPreLoc.text = [NSString stringWithFormat:@"%.3f",distance];
        DBG(@"与上一位置点的距离为:%f",distance);
        
        // (5米门限值，存储数组划线) 如果距离少于 5 米，则忽略本次数据直接返回该方法
        if (distance < 5) {
            NSLog(@"与前一更新点距离小于5m，直接返回该方法");
            return;
        }
        
        // 累加步行距离
        self.sumDistance += distance;
        self.statusView.distanceLabel.text = [NSString stringWithFormat:@"%.3f",self.sumDistance / 1000.0];
        DBG(@"步行总距离为:%f",self.sumDistance);
        
        // 计算移动速度
        CGFloat speed = distance / dtime;
        self.statusView.speedContentLabel.text = speed > 0?[NSString stringWithFormat:@"%.3f m/s",speed]:@"0 m/s";
        
        [self.statusView reloadData];
        // 计算平均速度
        //        CGFloat avgSpeed  =self.sumDistance / self.sumTime;
        //        self.statusView.avgSpeed.text = [NSString stringWithFormat:@"%.3f",avgSpeed];
    }
    
    // 2. 将符合的位置点存储到数组中
    [self.locationArrayM addObject:userLocation.location];
    self.preLocation = userLocation.location;
    
    // 3. 绘图
    [self drawWalkPolyline];
    
}

/**
 *  绘制步行轨迹路线
 */
- (void)drawWalkPolyline
{
    //轨迹点
    NSUInteger count = self.locationArrayM.count;
    
    // 手动分配存储空间，结构体：地理坐标点，用直角地理坐标表示 X：横坐标 Y：纵坐标
    BMKMapPoint *tempPoints = new BMKMapPoint[count];
    
    [self.locationArrayM enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger idx, BOOL *stop) {
        BMKMapPoint locationPoint = BMKMapPointForCoordinate(location.coordinate);
        tempPoints[idx] = locationPoint;
        DBG(@"idx = %ld,tempPoints X = %f Y = %f",idx,tempPoints[idx].x,tempPoints[idx].y);
        
        // 放置起点旗帜
        if (0 == idx && TrailStart == self.trail && self.startPoint == nil) {
            self.startPoint = [self creatPointWithLocaiton:location title:@"起点"];
        }
    }];
    
    //移除原有的绘图
    if (self.polyLine) {
        [self.mapView removeOverlay:self.polyLine];
    }
    
    // 通过points构建BMKPolyline
    self.polyLine = [BMKPolyline polylineWithPoints:tempPoints count:count];
    
    //添加路线,绘图ƒ
    if (self.polyLine) {
        [self.mapView addOverlay:self.polyLine];
    }
    
    // 清空 tempPoints 内存
    delete []tempPoints;
    
    [self mapViewFitPolyLine:self.polyLine];
}

/**
 *  根据polyline设置地图范围
 *
 *  @param polyLine
 */
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [self.mapView setVisibleMapRect:rect];
    self.mapView.zoomLevel = self.mapView.zoomLevel - 0.3;
}


#pragma mark - BMKMapViewDelegate

/**
 *  根据overlay生成对应的View
 *  @param mapView 地图View
 *  @param overlay 指定的overlay
 *  @return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor clearColor] colorWithAlphaComponent:0.7];
        polylineView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 10.0;
        return polylineView;
    }
    return nil;
}

/**
 *  只有在添加大头针的时候会调用，直接在viewDidload中不会调用
 *  根据anntation生成对应的View
 *  @param mapView 地图View
 *  @param annotation 指定的标注
 *  @return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        if(self.startPoint){ // 有起点旗帜代表应该放置终点旗帜（程序一个循环只放两张旗帜：起点与终点）
            annotationView.pinColor = BMKPinAnnotationColorGreen; // 替换资源包内的图片
            //            self.statusView.stopPointLabel.text = @"YES";
        }else { // 没有起点旗帜，应放置起点旗帜
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            //            self.statusView.startPointLabel.text = @"YES";
        }
        
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        
        // 不可拖拽
        annotationView.draggable = NO;
        
        return annotationView;
    }
    return nil;
}

// 设置mapview上的控件
- (void)setupMapViewSubViews
{
    self.fullScreenBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-100-SAFE_BOTTOM_HEIGHT, 70, 70)];
    [self.fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"live_fullscreen_off"] forState:UIControlStateNormal];
    [self.fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"live_fullscreen_off_down"] forState:UIControlStateHighlighted];
    [self.fullScreenBtn addTarget:self action:@selector(showMessgeView) forControlEvents:UIControlEventTouchUpInside];
    self.fullScreenBtn.hidden = YES;
    [self.mapView addSubview:self.fullScreenBtn];
}

#pragma mark - lazyLoad

- (NSMutableArray *)locationArrayM
{
    if (_locationArrayM == nil) {
        _locationArrayM = [NSMutableArray array];
    }
    
    return _locationArrayM;
    
}
#pragma mark - statusviewDelegate
-(void)closeButtonClick
{
 
    NSString *str = [NSString stringWithFormat:@"本次跑步距离为：%.1f米",self.sumDistance];
    TTAlertView *alert = [[TTAlertView alloc] initWithTitle:@"提示" andImage:[UIImage imageNamed:@"dock_camera_down"] content:str cancleButton:@"确定" otherButtons: nil];
    
    alert.delegate = self;
    [alert show];
    
   
    
}

- (void)alertView:(TTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if (TrailStart  == self.trail) {
        [self stopTrack];
        [self updateSportsData];
    }
    
    [self clickback];
}
- (void)showMapButtonClick
{
    [UIView animateWithDuration:0.5 animations:^{
       
        self.statusView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.fullScreenBtn.hidden = NO;
    }];
}

- (void)stopButtonClick
{
    [self stopTrack];
    
    [self updateSportsData];
}

- (void)showMessgeView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.statusView.alpha = 0.8;
        
    } completion:^(BOOL finished) {
        
        self.fullScreenBtn.hidden = YES;
    }];
}

#pragma mark - update
- (void)updateSportsData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafeObject:[NSString stringWithFormat:@"%f",self.sumDistance] forKey:@"distance"];
    [params setSafeObject:[NSString stringWithFormat:@"%f",self.statusView.timeContentLabel.getTimeCounted] forKey:@"time"];
    
    [SportsRequest postSportsDataWithParams:params success:^{
        
        
    } failure:^(StatusModel *status) {
       
        [self showNotice:status.msg];
    }];
}

@end
