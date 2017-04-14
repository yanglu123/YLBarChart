//
//  BarChartView.m
//  BarChart
//
//  Created by Yuanin2 on 2017/4/14.
//  Copyright © 2017年 YangLu. All rights reserved.
//

#import "BarChartView.h"
#define BarChartBoxH self.frame.size.height / 7
#define BarChartBoxW (self.frame.size.width - BarChartRightSpacing - BarChartLeftSpacing) / 7
#define BarChartLeftSpacing  40
#define BarChartRightSpacing 25
#define barChartColumnW 20
@interface BarChartView()
//y轴刻度
@property(nonatomic,strong) NSMutableArray *yArr;

@property(nonatomic,copy) NSString *yUnit;//Y轴单位

@property(nonatomic, assign) int level;

@property(nonatomic, copy) NSString *type;

@property(nonatomic,assign)int avverage;//平均值

@end
@implementation BarChartView
-(NSMutableArray *)yArr{
    if(!_yArr){
        _yArr = [NSMutableArray array];
    }
    return _yArr;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setDataResource:(NSArray *)dataResource{
    _dataResource = dataResource;
    self.yUnit = @"(单位:万元)";//Y轴单位，默认元
    [self getYDataArrWithDataResource:_dataResource];
    
}

-(void)drawRect:(CGRect)rect{
    //创建画布
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]};
    
    [self.yUnit drawInRect:CGRectMake(2,  BarChartBoxH - 25, BarChartLeftSpacing+30, 22) withAttributes:attribute];
    
    //绘制区域轴
    for (int i = 0 ; i < 4 ; i++) {
        if (i==3) {
            [[UIColor colorWithRed:255.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]set];
        }else{
            [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]set];
        }
        if (i==0) {
            CGContextSetLineWidth(ctr, 0.5);
            CGContextMoveToPoint(ctr, BarChartLeftSpacing, BarChartBoxH * (i + 1));
            CGContextAddLineToPoint(ctr, self.frame.size.width - BarChartRightSpacing, BarChartBoxH * (i + 1));
            CGContextStrokePath(ctr);
            //绘制y轴刻度
            [self.yArr[3 - i] drawInRect:CGRectMake(8, BarChartBoxH * (i + 1) - 7, BarChartLeftSpacing - 10, 22) withAttributes:attribute];
        }else if (i==3){
            CGContextSetLineWidth(ctr, 0.5);
            CGContextMoveToPoint(ctr, BarChartLeftSpacing, BarChartBoxH * 6);
            CGContextAddLineToPoint(ctr, self.frame.size.width - BarChartRightSpacing, BarChartBoxH * 6);
            CGContextStrokePath(ctr);
            //绘制y轴刻度
            [self.yArr[3 - i] drawInRect:CGRectMake(8, BarChartBoxH * 6 - 7, BarChartLeftSpacing - 10, 22) withAttributes:attribute];
        }else{
            CGContextSetLineWidth(ctr, 0.5);
            CGContextMoveToPoint(ctr, BarChartLeftSpacing, BarChartBoxH+(self.frame.size.height-BarChartBoxH*2)/3.0*i);
            CGContextAddLineToPoint(ctr, self.frame.size.width - BarChartRightSpacing, BarChartBoxH+(self.frame.size.height-BarChartBoxH*2)/3.0*i);
            CGContextStrokePath(ctr);
            //绘制y轴刻度
            [self.yArr[3 - i] drawInRect:CGRectMake(8, BarChartBoxH+(self.frame.size.height-BarChartBoxH*2)/3.0*i - 7, BarChartLeftSpacing - 10, 22) withAttributes:attribute];
        }
        
        
    }
    
    //绘制x轴
    for (int i = 0; i < 8 ; i++) {
        CGContextSetLineWidth(ctr, 0.5);
        [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]set];
        CGContextMoveToPoint(ctr, BarChartLeftSpacing + i * BarChartBoxW, BarChartBoxH * 6);
        CGContextAddLineToPoint(ctr, BarChartLeftSpacing + i * BarChartBoxW, BarChartBoxH * 6 + 3);
        CGContextStrokePath(ctr);
    }
    
    for (int i = 0 ; i < 7 ; i++) {
        //绘制X轴坐标
        NSDictionary *dataDic = self.dataResource[i];
        NSString *monthStr = dataDic[@"date"];
        NSString *moneyStr = dataDic[@"value"];
        CGFloat num = [moneyStr floatValue] / self.level;
        CGFloat scale = 0.0;
        scale=num/[[self.yArr lastObject] integerValue];
        //        if([self.type isEqualToString:@"f"]){
        //            scale = num / 50;
        //
        //        }else{
        //            scale =  num / 100;
        //
        //        }
        [self drawMyRectWithCornerX:BarChartLeftSpacing + BarChartBoxW * (i + 0.5) - barChartColumnW * 0.5 andY:BarChartBoxH * 6 andRadius:0 andWidth:barChartColumnW andHeight:- 5 * scale * BarChartBoxH andCtr:ctr andColor:[self colorWithIndex:i]andBarTag:i+200];
        
        //绘制柱子
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]};
        
        [monthStr drawInRect:CGRectMake(BarChartLeftSpacing + BarChartBoxW * i, BarChartBoxH * 6 + 5 , BarChartBoxW, 22) withAttributes:attribute];
    }
    
}


-(UIColor *)colorWithIndex:(int)index{
    UIColor *color;
    switch (index) {
        case 0:
            color = [UIColor colorWithRed:117/255.0 green:126/255.0 blue:255/255.0 alpha:1];
            break;
        default:
            color = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
            break;
    }
    return color;
}

/**
 *  绘制圆弧矩形
 *
 *  @param x      起始点的横坐标
 *  @param y      起始点的纵坐标
 *  @param radius 圆角弧形的半径
 *  @param width  矩形的宽度
 *  @param height 矩形的高度
 *  @param ctr    绘图上下文
 *  @param color  背景颜色
 *  @param tag    tag值
 */
- (void)drawMyRectWithCornerX:(CGFloat)x andY:(CGFloat)y andRadius:(CGFloat)radius andWidth:(CGFloat)width andHeight:(CGFloat)height andCtr:(CGContextRef)ctr andColor:(UIColor *)color andBarTag:(NSInteger)tag{
    UIButton  *barBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    barBtn.frame=CGRectMake(x, y, width, 0);
    barBtn.tag=tag;
    [self addSubview:barBtn];
    [barBtn addTarget:self action:@selector(BarChartClick:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:1.0 animations:^{
        barBtn.frame=CGRectMake(x, y, width, height);
        barBtn.backgroundColor=color;
    }];
    if (tag==200) {//显示第一个
        CGPoint point=barBtn.frame.origin;
        [self.delegate userClickedOnLinePoint:point lineIndex:barBtn.tag-200];
    }
}
-(void)BarChartClick:(UIButton *)btn{
    for (int i=0; i<7; i++) {
        UIButton *unbtn=[self viewWithTag:200+i];
        if (unbtn==btn) {
            unbtn.backgroundColor=[UIColor colorWithRed:117/255.0 green:126/255.0 blue:255/255.0 alpha:1];
        }else{
            unbtn.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        }
    }
    CGPoint point=btn.frame.origin;
    [self.delegate userClickedOnLinePoint:point lineIndex:btn.tag-200];
}

-(void)getYDataArrWithDataResource:(NSArray *)dataResource{
    //获取最大值
    CGFloat maxValue = [self maxValueWithDataResource:dataResource];
    
    //获取刻度值
    //    [self getUnitWithMaxValue:maxValue];
    [self getUnitWithMaxValues:maxValue];
}

-(CGFloat)maxValueWithDataResource:(NSArray *)dataResource{
    //获取最大值
    NSDictionary *dic = self.dataResource[0];
    CGFloat maxValue = [dic[@"value"] floatValue];
    
    for(int i = 1 ; i < dataResource.count ; i++){
        NSDictionary *dic = self.dataResource[i];
        CGFloat compareValue = [dic[@"value"] floatValue];
        if(maxValue < compareValue){
            maxValue = compareValue;
        }
    }
    
    return maxValue;
    
}
-(void)getUnitWithMaxValues:(CGFloat)maxValue{
    CGFloat AverageValue=maxValue/3.0;
    self.avverage=(int)ceilf(AverageValue);
    for (int i=0; i<4; i++) {
        [self.yArr addObject:[NSString stringWithFormat:@"%d",self.avverage*i]];
    }
    self.yUnit=@"(单位:万元)";
    self.level=1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
