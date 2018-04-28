//
//  RQNPageViewController.m
//  RQNPageViewController
//
//  Created by mac on 2018/4/28.
//  Copyright © 2018年 mac. All rights reserved.
//





#import "RQNPageViewController.h"
#import <HMSegmentedControl.h>





@interface RQNPageViewController ()<UIPageViewControllerDelegate ,UIPageViewControllerDataSource>

@property (nonatomic,weak) HMSegmentedControl *pageControl;

@property (nonatomic,weak) UIPageViewController *pageViewController;

@property (nonatomic,assign) NSInteger currentIndex;



@end

@implementation RQNPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建系统pageViewController
    [self setUpPageViewController];
    
    
    
}


#pragma mark 创建PageViewController
- (void)setUpPageViewController
{
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //    pageViewController.view.backgroundColor = [UIColor whiteColor];
    //    pageViewController.view.x = 0;
    //    pageViewController.view.y = 0;
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    _pageViewController = pageViewController;
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
}


#pragma mark   pageViewController数据源方法
//向右滚（获取下一个控制器 -- 即将显示的控制器）
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //获取当前控制器所在数组的下标
    NSInteger index = [self.pages indexOfObject:viewController];
    
    if (index == 0) {//第一个控制器时
        index = self.pages.count - 1;//获取最后一个控制器的index
    }else{//不是最后一个控制器时
        index--;
    }

    return self.pages[index];
    
}

//向左滚动
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //获取当前控制器所在数组的下标
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == self.pages.count - 1) {//最后一个控制器时
        index = 0;//获取第一个控制器的index
    }else{//不是最后一个控制器时
        index++;
    }
    
    return self.pages[index];
}

#pragma mark   pageViewController代理方法
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    //获取index
    self.currentIndex = [self.pages indexOfObject:[pendingViewControllers lastObject]];
    
    //    [_pageControl setSelectedSegmentIndex:self.currentIndex animated:YES];
    
}



//完成跳转时调用（只有亲自滑动页面进行翻页才会调用）
//b 结束动画方法，一定要根据completed判断是否结束，YES表示偏移完成，NO表示取消，如果判定当前的index, 注意不要使用previousViewControllers判断index，需要根据上面的方法来判定
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    if (completed) {//跳转完成
        [_pageControl setSelectedSegmentIndex:self.currentIndex animated:YES];
    }
    
}





#pragma mark     根据index 跳转至相应界面

- (void)segmentedControlChangedValue:(HMSegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    //根据按钮即将跳转的页面index与当前页index比较来确定滚动方向
    UIPageViewControllerNavigationDirection  navigationDirection  = index > self.currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse ;
    //根据index 跳转界面
    //    __weak RQNGameViewController *weakSelf = self;
    [_pageViewController setViewControllers:[NSArray arrayWithObjects:self.pages[sender.selectedSegmentIndex], nil] direction:navigationDirection animated:YES completion:^(BOOL finished) {
        
        if (finished) {
            self.currentIndex = index;
        }
        
    }];
    
}





#pragma mark  创建SegmentedControl

- (void)setPageTitles:(NSArray *)pageTitles
{
    _pageTitles = pageTitles;
    
    //创建 标签  控件
    HMSegmentedControl *pageControl = [[HMSegmentedControl alloc] initWithSectionTitles:pageTitles];
    
    [pageControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    _pageControl = pageControl;
    
}

//设置frame
- (void)setTitlesViewFrame:(CGRect)titlesViewFrame
{
    _titlesViewFrame = titlesViewFrame;
    //标签frame
    _pageControl.frame = titlesViewFrame;

}
//显示的viewframe
- (void)setPageViewFrame:(CGRect)pageViewFrame
{
    _pageViewFrame = pageViewFrame;
    
    //显示的viewframe
    _pageViewController.view.frame = pageViewFrame;
}

#pragma mark 设置要显示的所有控制器和显示的第一个控制器页面
- (void)setPages:(NSArray *)pages
{
    _pages = pages;
    
    //navigationOrientation设定了翻页方向，UIPageViewControllerNavigationDirection枚举类型定义了以下两种翻页方式。
    //UIPageViewControllerNavigationDirectionForward：从右向左（或从下往上）；
    //UIPageViewControllerNavigationDirectionReverse：从左往右（或从上往下）
    //设置第一显示页
    [_pageViewController setViewControllers:[NSArray arrayWithObjects:pages[0], nil] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {}];
    
    
}

- (void)setSelectedPageIndex:(NSUInteger)index animated:(BOOL)animated {
    if (index < [self.pages count]) {
        [self.pageControl setSelectedSegmentIndex:index animated:YES];
        [self.pageViewController setViewControllers:@[self.pages[index]]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:animated
                                         completion:NULL];
    }
}

- (void)setTitleTextAttributes:(NSDictionary *)titleTextAttributes
{
    _titleTextAttributes = titleTextAttributes;
    
    _pageControl.titleTextAttributes = titleTextAttributes;
}

- (void)setSelectedTitleTextAttributes:(NSDictionary *)selectedTitleTextAttributes
{
    _selectedTitleTextAttributes = selectedTitleTextAttributes;
    
    _pageControl.selectedTitleTextAttributes = selectedTitleTextAttributes;
}

- (void)setTitleViewBackgroundColor:(UIColor *)titleViewBackgroundColor
{
    _titleViewBackgroundColor = titleViewBackgroundColor;
    
    _pageControl.backgroundColor = titleViewBackgroundColor;
}

- (void)setSelectionIndicatorHeight:(CGFloat)selectionIndicatorHeight
{
    _selectionIndicatorHeight = selectionIndicatorHeight;
    
    _pageControl.selectionIndicatorHeight = selectionIndicatorHeight;
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor
{
    _selectionIndicatorColor = selectionIndicatorColor;
    
    _pageControl.selectionIndicatorColor = selectionIndicatorColor;
}

- (void)setSelectionIndicatorLocation:(SelectionIndicatorLocation)selectionIndicatorLocation
{
    _selectionIndicatorLocation = selectionIndicatorLocation;
    
    _pageControl.selectionIndicatorLocation = selectionIndicatorLocation;
}

- (void)setSelectionStyle:(SelectionStyle)selectionStyle
{
    _selectionStyle = selectionStyle;
    
    _pageControl.selectionStyle = selectionStyle;
}

- (void)setSelectionIndicatorBoxColor:(UIColor *)selectionIndicatorBoxColor
{
    _selectionIndicatorBoxColor = selectionIndicatorBoxColor;
    
    _pageControl.selectionIndicatorBoxColor = selectionIndicatorBoxColor;
}




//创建对象类方法
+ (instancetype)pageViewControllerWithPageTitles:(NSArray <NSString *> *)pageTitles controllers:(NSArray *)controllers titlesViewFrame:(CGRect)frame
{
    RQNPageViewController *pageViewController = [[RQNPageViewController alloc] init];
    
    pageViewController.pageTitles = pageTitles;
    
    pageViewController.pages = controllers;
    
    pageViewController.titlesViewFrame = frame;
    
    return pageViewController;
    
}

@end





























