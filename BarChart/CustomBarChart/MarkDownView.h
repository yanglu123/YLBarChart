//
//  MarkDownView.h
//  BarChart
//
//  Created by Yuanin2 on 2017/4/14.
//  Copyright © 2017年 YangLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkDownView : UIView
@property(assign,nonatomic)NSInteger offsetX;/**<偏移量 0:centet left:负偏移 right:正偏移*/
@property (copy,nonatomic)NSString *money;

-(void)drawNow;
@end
