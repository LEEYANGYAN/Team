//
//  TableViewCell.h
//  ChatDemo
//
//  Created by lwx on 16/5/26.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddBlock)(UIButton *btn,UIImage *image,UIImageView *cellImageView);


@interface TableViewCell : UITableViewCell

@property (nonatomic, copy) AddBlock tagHandle;

@property (nonatomic, copy) NSString *url;

- (void)setAllDefalut;

- (void)buttonHandle:(AddBlock)block;

@end
