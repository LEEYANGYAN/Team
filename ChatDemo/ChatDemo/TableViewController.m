//
//  TableViewController.m
//  ChatDemo
//
//  Created by lwx on 16/5/26.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "AFNetworking.h"
#import "ChatView.h"


static NSString *cellID = @"cellID";

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate> {
    ChatView *_chat;
    CALayer  *_layer;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableSet *layerSet;

@end

@implementation TableViewController



- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
    
}


- (NSMutableSet *)layerSet {
    if (!_layerSet) {
        
        _layerSet = [NSMutableSet set];
        
    }
    return _layerSet;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self getData];
    
    [self createView];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:cellID];

}


- (void)createView {
    
    ChatView *chat = [[ChatView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49)];
    [self.tableView.superview addSubview:chat];
    _chat = chat;
    
}

- (void)getData {
    
    NSString *urlStr = @"http://api2.hichao.com/stars?gc=AppStore&gf=iphone&gn=mxyc_ip&gv=3.60&gi=81ACD2E7-25F1-480C-A54E-2BCC01126F22&gs=640x1136&gos=7.0.6&access_token=&flag=&category=全部&lts=1399691696&pin=62648";
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        NSDictionary *data = dic[@"data"];
        
        NSArray *arr = data[@"items"];
        
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (NSDictionary *tempDic in arr) {
            
            NSDictionary *component = tempDic[@"component"];
            
            NSString *model = component[@"picUrl"];
             
            
            [tempArr addObject:model];
        }
        
        self.dataArray = tempArr;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.dataArray.count != 0) {
        return self.dataArray.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (self.dataArray.count != 0) {
        
        NSString *model = self.dataArray[indexPath.row];
        
        if (model) {
            
            [cell setAllDefalut];
            
            cell.url = model;
            
            
            [cell buttonHandle:^(UIButton *btn, UIImage *image, UIImageView *cellImageView) {
                
                 CGRect startRect = [cellImageView convertRect:cellImageView.frame toView:nil];
                
                [self initLayerFromRect:startRect toPoint:_chat.chatPoint withImage:image];
                
//                NSLog(@"%@",strUrl);
                _chat.count++;
            }];
            
        }
    }
    
    
    return cell;
}


- (void)initLayerFromRect:(CGRect)rect toPoint:(CGPoint)point withImage:(UIImage *)image{
    
    
    CALayer *layer = [[CALayer alloc] init];
    
    layer.frame = rect;
    layer.contents = (id)image.CGImage;
    [self.view.layer addSublayer:layer];
    [self.layerSet addObject:layer];
    
    
    CAKeyframeAnimation *layerKFAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:layer.position];
    [bezierPath addQuadCurveToPoint:point controlPoint:CGPointMake(self.view.bounds.size.width/2, -200)];
    
    layerKFAnimation.path = bezierPath.CGPath;
    layerKFAnimation.removedOnCompletion  = NO;
    layerKFAnimation.duration             = 2;
    layerKFAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    layerKFAnimation.fillMode             = kCAFillModeBoth;
    
    
    CABasicAnimation *layerBasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    layerBasicAnimation.duration          = 2;
    layerBasicAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    layerBasicAnimation.fillMode             = kCAFillModeBoth;
    layerBasicAnimation.removedOnCompletion  = NO;    
    layerBasicAnimation.fromValue = @1;
    layerBasicAnimation.toValue   = @(0.1);
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[layerKFAnimation,layerBasicAnimation];
    group.beginTime = CACurrentMediaTime() + 0.1;
    group.duration = 2;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    group.delegate = self;
    [layer addAnimation:group forKey:@"group"];
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    

    [self.layerSet enumerateObjectsUsingBlock:^(CALayer *layer, BOOL * _Nonnull stop) {
        
   
        
        if (anim == [layer animationForKey:@"group"]) {
            
            __block CALayer *weakLayer = layer;
            
            NSLog(@"开始动画");
            [CATransaction begin];
            [CATransaction setValue:[NSNumber numberWithFloat:0.5f] forKey:kCATransactionAnimationDuration];
            [CATransaction setCompletionBlock:^{
                NSLog(@"完成动画");
                [weakLayer removeFromSuperlayer];
                [self.layerSet removeObject:weakLayer];
                weakLayer = nil;
                
            }];
            layer.opacity = 0;
            layer.bounds = CGRectMake(0, 0, 0, 0);
            [CATransaction commit];
            NSLog(@"结束动画");
       
        }
    }];
    
}



@end
