//
//  ViewController.m
//  BarChart
//
//  Created by Yuanin2 on 2017/4/14.
//  Copyright © 2017年 YangLu. All rights reserved.
//

#import "ViewController.h"
#import "BarChartView.h"
#import "MarkDownView.h"
@interface ViewController ()<BarChartViewDelete>
@property(nonatomic,weak) BarChartView *barChartView;
@property(strong,nonatomic)MarkDownView *markView;
@end

@implementation ViewController
-(MarkDownView *)markView{
    if (!_markView) {
        _markView=[[MarkDownView alloc]init];
        [self.view addSubview:_markView];
        
    }
    return _markView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *valueDic1 = @{@"date":@"7月",@"value":@"56.36"};
    NSDictionary *valueDic2 = @{@"date":@"8月",@"value":@"40.87"};
    NSDictionary *valueDic3 = @{@"date":@"9月",@"value":@"60"};
    NSDictionary *valueDic4 = @{@"date":@"10月",@"value":@"30"};
    NSDictionary *valueDic5 = @{@"date":@"11月",@"value":@"40"};
    NSDictionary *valueDic6 = @{@"date":@"12月",@"value":@"50"};
    NSDictionary *valueDic7 = @{@"date":@"13月",@"value":@"35"};
    BarChartView *barChartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width-30, 170)];
    self.barChartView = barChartView;
    self.barChartView.delegate=self;
    self.barChartView.dataResource = @[valueDic1,valueDic2,valueDic3,valueDic4,valueDic5,valueDic6,valueDic7];;
    [self.view addSubview:self.barChartView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSString *str=[NSString stringWithFormat:@"成交金额:%@万元",self.barChartView.dataResource[lineIndex][@"value"]];
    CGSize size = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width -30, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
    if (lineIndex!=0&&lineIndex!=6) {
        self.markView.offsetX=0;
        self.markView.frame=CGRectMake(self.barChartView.frame.origin.x+point.x+10-(size.width+10)/2.0,self.barChartView.frame.origin.y+point.y-40, size.width+10, 32);
        self.markView.money=self.barChartView.dataResource[lineIndex][@"value"];
        [self.markView drawNow];
    }else if(lineIndex==0){
        self.markView.offsetX=-10;
        self.markView.frame=CGRectMake(self.barChartView.frame.origin.x+point.x+10-(size.width+10)/2.0-self.markView.offsetX,self.barChartView.frame.origin.y+point.y-40, size.width+10, 32);
        self.markView.money=self.barChartView.dataResource[lineIndex][@"value"];
        [self.markView drawNow];
    }else if (lineIndex==6){
        self.markView.offsetX=15;
        self.markView.frame=CGRectMake(self.barChartView.frame.origin.x+point.x+10-(size.width+10)/2.0-self.markView.offsetX,self.barChartView.frame.origin.y+point.y-40, size.width+10, 32);
        self.markView.money=self.barChartView.dataResource[lineIndex][@"value"];
        [self.markView drawNow];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
