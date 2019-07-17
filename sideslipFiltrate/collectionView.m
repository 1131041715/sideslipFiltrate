//
//  collectionView.m
//  sideslipFiltrate
//
//  Created by 大碗豆 on 17/8/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "collectionView.h"
#import "sideslipFiltrateCollectionViewCell.h"


#define LeftMargin 50

#define BackViewWitdh self.frame.size.width - LeftMargin

static CGFloat toolsViewHeith = 50;
static CGFloat animationTime = 0.25;


@interface collectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UIView *bgView;              /** 背景view */
@property (nonatomic, strong) UIView *toolsView;           /** 自定义标签栏 */
@property (nonatomic, strong) UIButton *sureButton;        /** 确认按钮 */
@property (nonatomic, strong) UIButton *canselButton;      /** 取消按钮 */

@property (nonatomic, strong) UICollectionView *collectionView;  /** 选项view */
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * itemArr;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end


@implementation collectionView

static NSString *str = @"sideslipFiltrateCollectContent";
static NSString *str1 = @"sideslipFiltrateCollectHead";
static NSString *str2 = @"sideslipFiltrateCollectFoot";

//// init 会调用 initWithFrame
//- (instancetype)init{
//    if (self = [super init]) {
//    }
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self initSubViews];
////        [self initBaseData];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _titleArr = [NSArray arrayWithArray:titles];
        _itemArr = [NSArray arrayWithArray:items];
        [self loadData];
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items {
    
    self = [super init];
    
    if (self) {
        
        _titleArr = [NSArray arrayWithArray:titles];
        _itemArr = [NSArray arrayWithArray:items];
        [self loadData];
        [self initSubViews];
    }
    return self;
}

- (void)loadData {
    
    [self.dataArr removeAllObjects];
    
    
    for (int i = 0; i < _itemArr.count; i++) {
        
        NSMutableArray * array = [[NSMutableArray alloc] init];
        NSArray * arr = _itemArr[i];
        
        for (int j = 0; j < arr.count; j++) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:arr[j] forKey:@"title"];
            if (j == 0) {
                
                [dic setObject:@YES forKey:@"isSelected"];
            } else {
                
                [dic setObject:@NO forKey:@"isSelected"];
            }
            [array addObject:dic];
        }
        [self.dataArr addObject:array];
    }
}


- (void)initSubViews{
    
    self.frame = CGRectMake(0, 20, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height - 20);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    //        [self.bgView addSubview:self.toolsViewBottom];
    //
    [self.toolsView addSubview:self.canselButton];
    [self.toolsView addSubview:self.sureButton];
    [self.toolsView addSubview:[self selectCity]];
    
    [self.bgView addSubview:self.collectionView];
    //
    //        [self.toolsViewBottom addSubview:[self pctView]];
    //        [self.bgView addSubview:self.cityPickerView];
    
    [self showPickView];
    
    
    
}

#pragma mark - lazy

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, BackViewWitdh, self.frame.size.height)];
        _bgView.backgroundColor = [UIColor purpleColor];
    }
    return _bgView;
}


- (UIView *)toolsView{
    
    if (!_toolsView) {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BackViewWitdh, toolsViewHeith)];
        //        _toolsView.layer.borderWidth = 0.5;
        //        _toolsView.layer.borderColor = [UIColor redColor].CGColor;
        _toolsView.backgroundColor = [UIColor redColor];
    }
    return _toolsView;
}


- (UIButton *)canselButton{
    if (!_canselButton) {
        _canselButton = ({
            UIButton *canselButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, toolsViewHeith, toolsViewHeith)];
            [canselButton setTitle:@"重置" forState:UIControlStateNormal];
            canselButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [canselButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [canselButton addTarget:self action:@selector(canselButtonClick) forControlEvents:UIControlEventTouchUpInside];
            canselButton;
        });
    }
    return _canselButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = ({
            UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(BackViewWitdh - 20 - toolsViewHeith, 0, toolsViewHeith, toolsViewHeith)];
            [sureButton setTitle:@"确定" forState:UIControlStateNormal];
            sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
            sureButton;
        });
    }
    return _sureButton;
}

- (UILabel *)selectCity{
    
    CGFloat bakViewWidth = BackViewWitdh;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((bakViewWidth/2 - toolsViewHeith), 0, toolsViewHeith * 2 , toolsViewHeith)];
    
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"筛选";
    return lab;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 50);
        layout.minimumLineSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.headerReferenceSize = CGSizeMake(5, 40);
        layout.footerReferenceSize = CGSizeMake(10, 20);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, toolsViewHeith + 10, BackViewWitdh, self.frame.size.height - toolsViewHeith - 10)  collectionViewLayout:layout];
        collection.backgroundColor = [UIColor yellowColor];
        collection.delegate = self;
        collection.dataSource = self;
        //进行注册
//        [collection registerNib:[UINib nibWithNibName:NSStringFromClass([sideslipFiltrateCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:str];
        [collection registerClass:[sideslipFiltrateCollectionViewCell class] forCellWithReuseIdentifier:str];
        //header注册
        [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:str1];
        //foot注册
        [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:str2];
        
        
        
        _collectionView = collection;
    }
    
    return _collectionView;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _titleArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_itemArr[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    sideslipFiltrateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    
    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    
//    lab.text = [NSString stringWithFormat:@"%zd",arc4random_uniform(100)];
//    lab.textColor = [UIColor blackColor];
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.backgroundColor = [UIColor whiteColor];
    
//    cell.lab_title.text = [NSString stringWithFormat:@"%zd",arc4random_uniform(100)];
    
//    [cell.contentView addSubview:lab];
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    
    if (indexPath.row < [self.dataArr[indexPath.section] count]) {
        
        NSDictionary * dic = _dataArr[indexPath.section][indexPath.row];
        [cell configCellWithData:dic];
    }
    
    
    cell.backgroundColor = [UIColor orangeColor];
    
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.row);
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArr[indexPath.section]];
    
    for (int i = 0; i < array.count; i++) {
        
        NSMutableDictionary * dic = array[i];
        if (i == indexPath.row) {
            
            [dic setObject:@YES forKey:@"isSelected"];
        } else {
            
            [dic setObject:@NO forKey:@"isSelected"];
        }
        [array replaceObjectAtIndex:i withObject:dic];
    }
    [_dataArr replaceObjectAtIndex:indexPath.section withObject:array];
    [_collectionView reloadData];

    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *re = nil;
    
    
    
//    [re removeFromSuperview];
    //设置追加视图
    if (kind == UICollectionElementKindSectionHeader) {
        
        
        
        //头部
        re = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:str1 forIndexPath:indexPath];
        re.backgroundColor = [UIColor purpleColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
        lab.text = _titleArr[indexPath.section];
//        lab.textColor = [UIColor greenColor];
//        lab.backgroundColor = [UIColor cyanColor];
        
        
        
        for (UIView *view in [re subviews]) {
            
            [view removeFromSuperview];
        }
        
        [re addSubview:lab];
        return  re;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        //尾部
        
        re = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:str2 forIndexPath:indexPath];
        re.backgroundColor = [UIColor orangeColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, BackViewWitdh - 20, 1)];
        lineView.backgroundColor = [UIColor redColor];
        
        
        for (UIView *view in [re subviews]) {
            
            [view removeFromSuperview];
        }
        
        if (indexPath.section < self.dataArr.count - 1) {
            
            [re addSubview:lineView];
        }
        
        return re;
    }
    return  nil;
    
}


- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}


#pragma event menthods
- (void)canselButtonClick{
//    [self hidePickView];
    
    [self loadData];
    
    [_collectionView reloadData];
    
    NSLog(@"%s~~~~~~~~~",__func__ );
    
}

- (void)sureButtonClick{
    [self hidePickView];
    
    NSLog(@"%s~~~~~~~~~",__func__ );
    
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArr[i]];
        for (int j = 0; j < array.count; j++) {
            NSMutableDictionary * dic = array[j];
            if ([dic[@"isSelected"] boolValue]) {
                NSLog(@"%@~~~~~~~~~",dic[@"title"]);
            }
        }
    }
}


#pragma mark private methods
- (void)showPickView{
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(LeftMargin, 0, BackViewWitdh, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hidePickView{
    
    [UIView animateWithDuration:animationTime animations:^{
        
        self.bgView.frame = CGRectMake(self.frame.size.height, 0, BackViewWitdh, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
