//
//  BarChartView.h
//  BarChart
//
//  Created by Yuanin2 on 2017/4/14.
//  Copyright © 2017年 YangLu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BarChartViewDelete<NSObject>
/**
 * Callback method that gets invoked when the user taps on the chart line.
 */
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex;
@end
@interface BarChartView : UIView
@property(nonatomic,strong) NSArray *dataResource;
@property(nonatomic,assign)id<BarChartViewDelete>delegate;

-(UIColor *)colorWithIndex:(int)index;
@end
