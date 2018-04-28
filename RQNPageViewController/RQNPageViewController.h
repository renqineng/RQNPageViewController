//
//  RQNPageViewController.h
//  RQNPageViewController
//
//  Created by mac on 2018/4/28.
//  Copyright © 2018年 mac. All rights reserved.

 



#import <UIKit/UIKit.h>


typedef enum location{
    
    selectionIndicatorLocationUp = 0,//指示条在顶部
    selectionIndicatorLocationDown,//在底部
    selectionIndicatorLocationNone//无指示条
    
}SelectionIndicatorLocation;

typedef enum selectionStyle{
    
    selectionStyleTextWidthStripe = 0,//和文字一样宽的线条
    selectionStyleFullWidthStripe,//满格线条
    selectionStyleBox,//箱型
    selectionStyleArrow//箭头
    
}SelectionStyle;



@interface RQNPageViewController : UIViewController




/**
 所有要显示数据的控制器（要和titles下标对应）
 */
@property (nonatomic,strong) NSArray *pages;

/**
 控制器对应的标签（要和对应的视图控制器下标相对应）
 */
@property (nonatomic,strong) NSArray *pageTitles;

/**
 标签frame
 */
@property (nonatomic,assign) CGRect titlesViewFrame;

/**
 字体属性
 */
@property (nonatomic,strong) NSDictionary *titleTextAttributes;
/**
 选中标签的字体属性
 */
@property (nonatomic,strong) NSDictionary *selectedTitleTextAttributes;
/**
 标签栏背景色
 */
@property (nonatomic,strong) UIColor *titleViewBackgroundColor;
/**
 选中标签的指示条高度
 */
@property (nonatomic,assign) CGFloat selectionIndicatorHeight;
/**
 指示条颜色
 */
@property (nonatomic,strong) UIColor *selectionIndicatorColor;
/**
 指示条位置
 */
@property (nonatomic,assign)  SelectionIndicatorLocation selectionIndicatorLocation;
/**
 指示条风格
 */
@property (nonatomic,assign) SelectionStyle selectionStyle;
/**
 箱型指示器颜色
 */
@property (nonatomic,strong) UIColor *selectionIndicatorBoxColor;



/**
 显示控制器view的frame
 */
@property (nonatomic,assign) CGRect pageViewFrame;




/**
 创建RQNPageViewController对象的类方法
 
 @param pageTitles 控制器对应的标签（要和对应的视图控制器下标相对应
 @param controllers 所有要显示数据的控制器（要和titles下标对应
 @param frame 标签frame
 @return 返回pageViewController对象
 */
+ (instancetype)pageViewControllerWithPageTitles:(NSArray <NSString *> *)pageTitles
                                     controllers:(NSArray *)controllers
                                 titlesViewFrame:(CGRect)frame;





@end
