//
//  collectionView.h
//  sideslipFiltrate
//
//  Created by 大碗豆 on 17/8/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items;

@end
