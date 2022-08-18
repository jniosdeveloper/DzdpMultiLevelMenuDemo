//
//  JNTypeShowView.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNTypeShowView.h"
#import "JNLifeMenuTextImageCell.h"

@interface JNTypeShowView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, strong) NSArray<JNLifeShopCategoryModel *> *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *innerContainerView;
@property (nonatomic, strong) JNLifeShopCategoryModel *currentSelectModel;
@end

@implementation JNTypeShowView
- (instancetype)initWithMenuOriginY:(CGFloat)originY dataSource:(NSArray<JNLifeShopCategoryModel *> *)dataSource {
    if (self = [super init]) {
        self.originY = originY;
        self.dataArray = dataSource;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    
    self.frame = CGRectMake(0, 0, JNScreenW, JNScreenH);
    self.backgroundColor = UIColor.clearColor;
    self.userInteractionEnabled = YES;
    self.hidden = YES;
    
    CGFloat height = 360.0;
    CGFloat cornerRadius = 20;
    [self addSubview:self.containerView];
    self.containerView.frame = CGRectMake(16.0, self.originY - cornerRadius, JNScreenW - 32.0, height + cornerRadius);
    self.containerView.clipsToBounds = YES;
    
    self.innerContainerView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.innerContainerView];
    
    [self.innerContainerView addSubview:self.tableView];
    self.tableView.frame = self.innerContainerView.bounds;
    [self.tableView registerNib:JNLifeMenuTextImageCell.nib forCellReuseIdentifier:JNLifeMenuTextImageCell.cellReuseIdentifier];
    [self.innerContainerView addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadius:CGSizeMake(20.0, 20.0)];
    
    [self.tableView reloadData];
}

#pragma mark - override
- (void)show {
    [self.innerContainerView.layer removeAllAnimations];
    self.hidden = NO;
    self.innerContainerView.center = CGPointMake(self.containerView.frame.size.width / 2, 0 - self.innerContainerView.bounds.size.height / 2);
    [UIView animateWithDuration:0.3 animations:^{
        self.innerContainerView.center = CGPointMake(self.containerView.frame.size.width / 2, self.tableView.bounds.size.height / 2);
    } completion:nil];
    
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.innerContainerView.center = CGPointMake(self.containerView.frame.size.width / 2, 0 - self.innerContainerView.bounds.size.height / 2);
    } completion:^(BOOL finish){
        if (!finish) {
            return;
        }
        self.hidden = YES;
    }];
}
- (void)updateSelectState:(JNLifeShopCategoryModel *)selectModel {
    for (JNLifeShopCategoryModel *model in self.dataArray) {
        if ([model.categoryName isEqualToString:selectModel.categoryName]) {
            model.select = YES;
        } else {
            model.select = NO;
        }
    }
    self.currentSelectModel = selectModel;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JNLifeMenuTextImageCell *cell = [tableView dequeueReusableCellWithIdentifier:JNLifeMenuTextImageCell.cellReuseIdentifier forIndexPath:indexPath];
    JNLifeShopCategoryModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.categoryName;
    cell.checkImageView.hidden = !model.select;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JNLifeShopCategoryModel *model = self.dataArray[indexPath.row];
    [self dismiss];
    if (self.dismissCallBack) {
        self.dismissCallBack(model);
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint pointTemp = [self convertPoint:point toView:self.tableView];
    if ([self.tableView pointInside:pointTemp withEvent:event]) {
        return YES;
    } else {
        return NO;
    }
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.clearColor;
    }
    return _containerView;
}
- (UIView *)innerContainerView {
    if (!_innerContainerView) {
        _innerContainerView = [[UIView alloc] init];
        _innerContainerView.backgroundColor = UIColor.whiteColor;
    }
    return _innerContainerView;
}
@end
