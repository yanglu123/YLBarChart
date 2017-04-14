//
//  MarkDownView.m
//  BarChart
//
//  Created by Yuanin2 on 2017/4/14.
//  Copyright © 2017年 YangLu. All rights reserved.
//

#import "MarkDownView.h"
@interface MarkDownView()
@property(nonatomic,copy)NSString *showStr;
@property(strong,nonatomic)UILabel *contentLab;
@end
@implementation MarkDownView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.opaque=NO;
        self.offsetX=0;
    }
    //    self.backgroundColor=[UIColor cyanColor];
    return self;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.opaque=NO;
        self.offsetX=0;
    }
    return self;
}
-(NSString *)showStr{
    _showStr=[NSString stringWithFormat:@"成交金额:%@万元",self.money];
    return _showStr;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat width=rect.size.width;
    CGFloat hight=rect.size.height;
    CGFloat radius=(width+hight)*0.02;
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, width/2.0+_offsetX, hight);
    CGContextAddLineToPoint(context,width/2.0+_offsetX-5, hight-8);
    CGContextAddLineToPoint(context,radius, hight-8);
    //1
    CGContextAddArc(context, radius, hight-8-radius, radius, M_PI_2,M_PI, 0);
    CGContextAddLineToPoint(context, 0,radius);
    
    
    //2.
    CGContextAddArc(context, radius, radius, radius, M_PI, -M_PI_2, 0);
    CGContextAddLineToPoint(context, width-radius, 0);
    //3.
    
    CGContextAddArc(context, width-radius, radius, radius, -M_PI_2, 0, 0);
    CGContextAddLineToPoint(context, width, hight-8-radius);
    
    //4.
    CGContextAddArc(context, width-radius,hight-8-radius, radius,0, M_PI_2, 0);
    CGContextAddLineToPoint(context, width/2.0+_offsetX+5, hight-8);
    CGContextAddLineToPoint(context, width/2.0+_offsetX, hight);
    CGContextSetLineWidth(context, 1.0);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor colorWithRed:255/255.0 green:96/255.0 blue:0 alpha:1] setFill];
    //设置填充色
    [[UIColor colorWithRed:255/255.0 green:96/255.0 blue:0 alpha:1] setStroke];
    //设置边框颜色
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
}
-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab=[[UILabel alloc]init];
        _contentLab.textAlignment=NSTextAlignmentCenter;
        _contentLab.font=[UIFont systemFontOfSize:11];
        _contentLab.textColor=[UIColor whiteColor];
        [self addSubview:_contentLab];
    }
    return _contentLab;
}
-(void)drawNow{
    self.contentLab.text=self.showStr;
    self.contentLab.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-8);
    [self setNeedsDisplay];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
