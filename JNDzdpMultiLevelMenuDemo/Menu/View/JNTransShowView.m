//
//  JNTransShowView.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNTransShowView.h"
#import "JNLifeMenuTextCell.h"
#import "JNLifeMenuTextImageCell.h"
#import "JNLifeDistanceModel.h"
#import "JNLifeModuleDataManager.h"
#import "JNLifeTransModel.h"

@interface JNTransShowView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *innerContainerView;
@property (nonatomic, strong) NSArray<JNLifeDistanceModel *> *distanceArray;
@property (nonatomic, strong) NSArray<JNLifeStationsModel *> *linesArray;

// 列表数据源数组
@property (nonatomic, strong) NSMutableArray<JNLifeTransModel *> *listDataArray;
@property (nonatomic, assign) NSInteger table1Index;
@property (nonatomic, assign) NSInteger table2Index;
@property (nonatomic, assign) NSInteger table3Index;

@property (nonatomic, strong) JNLifeTransSelectModel *currentSelectIndexModel;

// 保留原始数据
@property (nonatomic, strong) NSMutableArray<JNLifeTransModel *> *oriArray;

// 记录上一次索引
@property (nonatomic, assign) NSInteger table1PreIndex;
@property (nonatomic, assign) NSInteger table2PreIndex;
@property (nonatomic, assign) NSInteger table3PreIndex;

@end

@implementation JNTransShowView
- (instancetype)initWithMenuOriginY:(CGFloat)originY {
    if (self = [super init]) {
        self.originY = originY;
        [self configData];
        [self configUI];
    }
    return self;
}
- (void)configData {
    
    self.currentSelectIndexModel = [[JNLifeTransSelectModel alloc] init];
    
    self.table1PreIndex = 0;
    self.table2PreIndex = 0;
    self.table3PreIndex = -1;
    
    self.table1Index = 0;
    self.table2Index = 0;
    self.table3Index = -1;
    
    [self.listDataArray addObjectsFromArray:[self dealDataSourceLogic]];
    
    JNLifeTransModel *model0 = self.listDataArray[self.table1Index];
    model0.selected = YES;
    JNLifeTransModel *model = self.listDataArray[self.table1Index].transItems[self.table2Index];
    model.selected = YES;
    [self.oriArray addObjectsFromArray:[self dealDataSourceLogic]];
}
- (NSArray<JNLifeTransModel *> *)dealDataSourceLogic {
    
    NSMutableArray<JNLifeTransModel *> *tempSourceArray = [NSMutableArray array];
    
    // 处理数据源
    JNLifeTransModel *model1 = [[JNLifeTransModel alloc] init];
    model1.title = @"距离";
    model1.idString = @"";
    
    NSMutableArray<JNLifeTransModel *> *distanceArray = [NSMutableArray array];
    for (JNLifeDistanceModel *model in self.distanceArray) {
        JNLifeTransModel *temp = [[JNLifeTransModel alloc] init];
        temp.title = model.title;
        temp.idString = model.distance;
        temp.transItems = @[].mutableCopy;
        [distanceArray addObject:temp];
    }
    model1.transItems = distanceArray;
    [tempSourceArray addObject:model1];
    
    NSArray<JNLifeStationsModel *> *stationsArray = [JNLifeModuleDataManager getLineStationData];
    JNLifeTransModel *model2 = [[JNLifeTransModel alloc] init];
    model2.title = @"地铁";
    model2.idString = @"";
    
    NSMutableArray<JNLifeTransModel *> *linesArray = [NSMutableArray array];
    JNLifeTransModel *lineNolimited = [[JNLifeTransModel alloc] init];
    lineNolimited.title = @"不限";
    lineNolimited.idString = @"";
    lineNolimited.selected = NO;
    lineNolimited.transItems = @[].mutableCopy;
    lineNolimited.selected = NO;
    [linesArray addObject:lineNolimited];
    
    for (JNLifeStationsModel *model in stationsArray) {
        JNLifeTransModel *temp = [[JNLifeTransModel alloc] init];
        temp.title = model.name;
        temp.idString = model.code;
        NSMutableArray<JNLifeTransModel *> *stations = [NSMutableArray array];
        // 处理第三层站点数据
        for (JNLifeStationItem *item in model.stationInfos) {
            JNLifeTransModel *stationItem = [[JNLifeTransModel alloc] init];
            stationItem.title = item.name;
            stationItem.idString = item.ID;
            stationItem.longitude = item.longitude;
            stationItem.latitude = item.latitude;
            [stations addObject:stationItem];
            temp.transItems = stations;
        }
        [linesArray addObject:temp];
    }
    model2.transItems = linesArray;
    [tempSourceArray addObject:model2];
    
    return tempSourceArray;
}

- (void)configUI {
    
    self.frame = CGRectMake(0, 0, JNScreenW, JNScreenH);
    self.backgroundColor = UIColor.clearColor;
    self.userInteractionEnabled = YES;
    self.hidden = YES;
    CGFloat cornerRadius = 20;
    CGFloat height = 360.0;
    [self addSubview:self.containerView];
    self.containerView.frame = CGRectMake(16.0, self.originY - cornerRadius, JNScreenW - 32.0, height + cornerRadius);
    self.containerView.clipsToBounds = YES;
    
    [self.containerView addSubview:self.innerContainerView];
    self.innerContainerView.frame = self.containerView.bounds;
    
    
    // 设置3个tableView
    [self.innerContainerView addSubview:self.tableView1];
    self.tableView1.backgroundColor = [UIColor colorWithHexString:@"#F5F6F7"];
    self.tableView1.frame = CGRectMake(0, cornerRadius, 74.0, self.innerContainerView.jn_height - cornerRadius);
    [self.tableView1 registerNib:JNLifeMenuTextCell.nib forCellReuseIdentifier:JNLifeMenuTextCell.cellReuseIdentifier];
    UITableView *preView = self.tableView1;
    
    [self.innerContainerView addSubview:self.tableView2];
    self.tableView2.backgroundColor = [UIColor colorWithHexString:@"#F9FAFB"];
    self.tableView2.frame = CGRectMake(preView.jn_right, cornerRadius, self.innerContainerView.jn_width - 74.0, self.innerContainerView.jn_height - cornerRadius);
    [self.tableView2 registerNib:JNLifeMenuTextImageCell.nib forCellReuseIdentifier:JNLifeMenuTextImageCell.cellReuseIdentifier];
    preView = self.tableView2;
    
    [self.innerContainerView addSubview:self.tableView3];
    self.tableView3.backgroundColor = UIColor.whiteColor;
    self.tableView3.frame = CGRectMake((74.0 * 2), cornerRadius, self.innerContainerView.jn_width - (74.0 * 2), self.innerContainerView.jn_height - cornerRadius);
    [self.tableView3 registerNib:JNLifeMenuTextImageCell.nib forCellReuseIdentifier:JNLifeMenuTextImageCell.cellReuseIdentifier];
    [self.innerContainerView addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadius:CGSizeMake(20.0, 20.0)];
    
    [self _dealTable1ViewUILogic];
}
- (void)updateSelectState:(JNLifeTransSelectModel *)selectModel {
    self.currentSelectIndexModel = selectModel;

    self.table1Index = self.currentSelectIndexModel.index1;
    self.table2Index = self.currentSelectIndexModel.index2;
    self.table3Index = self.currentSelectIndexModel.index3;

    JNLifeTransModel *table1CurrentModel = self.listDataArray[self.table1Index];
    table1CurrentModel.selected = YES;
    JNLifeTransModel *table2CurrentModel = table1CurrentModel.transItems[self.table2Index];
    table2CurrentModel.selected = YES;
    if (self.table3Index != -1) {
        JNLifeTransModel *table3CurrentModel = table2CurrentModel.transItems[self.table3Index];
        table3CurrentModel.selected = YES;
    }
    [self _dealTable1ViewUILogic];
    [self reloadData];
}
- (void)menuBgDismissTapAction {
    if (self.table3Index == -1) {
        JNLifeTransModel *table1CurrentModel = self.listDataArray[self.table1Index];
        table1CurrentModel.selected = NO;
        JNLifeTransModel *table2CurrentModel = table1CurrentModel.transItems[self.table2Index];
        table2CurrentModel.selected = NO;
    }
}
#pragma mark - override
- (void)show {
    [self.innerContainerView.layer removeAllAnimations];
    self.hidden = NO;
    self.innerContainerView.center = CGPointMake(self.containerView.frame.size.width / 2, 0 - self.innerContainerView.bounds.size.height / 2);
    [UIView animateWithDuration:0.3 animations:^{
        self.innerContainerView.center = CGPointMake(self.containerView.frame.size.width / 2, self.innerContainerView.bounds.size.height / 2);
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

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint point1 = [self convertPoint:point toView:self.tableView1];
    CGPoint point2 = [self convertPoint:point toView:self.tableView2];
    CGPoint point3 = [self convertPoint:point toView:self.tableView3];
    if ([self.tableView1 pointInside:point1 withEvent:event] || [self.tableView2 pointInside:point2 withEvent:event] || [self.tableView3 pointInside:point3 withEvent:event]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView1) {
        return self.listDataArray.count;
    } else if (tableView == self.tableView2) {
        // 要根据上一层的选择的索引取对应的数据
        NSArray *temp = self.listDataArray[self.table1Index].transItems;
        return temp.count;
    } else{
        JNLifeTransModel *temp1 = self.listDataArray[self.table1Index];
        JNLifeTransModel *temp2 = temp1.transItems[self.table2Index];
        return temp2.transItems.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView1) {
        JNLifeMenuTextCell *cell = [tableView dequeueReusableCellWithIdentifier:JNLifeMenuTextCell.cellReuseIdentifier forIndexPath:indexPath];
        JNLifeTransModel *model = self.listDataArray[indexPath.row];
        cell.titleLabel.text = model.title;
        if (model.selected) {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"#DB880A"];
        } else {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        }
        return cell;
    } else if (tableView == self.tableView2) {
        JNLifeMenuTextImageCell *cell = [tableView dequeueReusableCellWithIdentifier:JNLifeMenuTextImageCell.cellReuseIdentifier forIndexPath:indexPath];
        JNLifeTransModel *model = self.listDataArray[self.table1Index].transItems[indexPath.row];
        cell.titleLabel.text = model.title;
        if (model.selected) {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"#DB880A"];
        } else {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        }
        cell.checkImageView.hidden = !model.selected;
        return cell;
    } else{
        JNLifeMenuTextImageCell *cell = [tableView dequeueReusableCellWithIdentifier:JNLifeMenuTextImageCell.cellReuseIdentifier forIndexPath:indexPath];
        JNLifeTransModel *temp1 = self.listDataArray[self.table1Index].transItems[self.table2Index];
        JNLifeTransModel *model = temp1.transItems[indexPath.row];
        cell.titleLabel.text = model.title;
        if (model.selected) {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"#DB880A"];
        } else {
            cell.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        }
        cell.checkImageView.hidden = !model.selected;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView1) {
        [self _dealPreDidSelectIndex:1 indexPath:indexPath];
        [self _dealTable1ViewUILogic];
        [self _dealTableDidSelectLogic:1];
    } else if (tableView == self.tableView2) {
        [self _dealPreDidSelectIndex:2 indexPath:indexPath];
        [self _dealTableDidSelectLogic:2];
        [self _dealUserConfirmState:2];
    } else{
        [self _dealPreDidSelectIndex:3 indexPath:indexPath];
        [self _dealTableDidSelectLogic:3];
        [self _dealUserConfirmState:3];
    }
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
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)reloadData {
    [self.tableView1 reloadData];
    [self.tableView2 reloadData];
    [self.tableView3 reloadData];
}
#pragma mark - private
- (void)_dealPreDidSelectIndex:(NSInteger)tableIndex indexPath:(NSIndexPath *)indexPath {
    if (tableIndex == 1) {
        self.table1PreIndex = self.table1Index;
        self.table2PreIndex = self.table2Index;
        self.table3PreIndex = self.table3Index;
        self.table1Index = indexPath.row;
        self.table2Index = 0;
        self.table3Index = -1;
    } else if (tableIndex == 2) {
        self.table1PreIndex = self.table1Index;
        self.table2PreIndex = self.table2Index;
        self.table3PreIndex = self.table3Index;
        self.table2Index = indexPath.row;
        self.table3Index = -1;
    } else {
        self.table1PreIndex = self.table1Index;
        self.table2PreIndex = self.table2Index;
        self.table3PreIndex = self.table3Index;
        self.table3Index = indexPath.row;
    }
}
- (void)_dealTable1ViewUILogic {
    // 拿到数据源数据
    JNLifeTransModel *model = self.listDataArray[self.table1Index];
    if ([model.title isEqualToString:@"距离"]) {
        self.tableView2.backgroundColor = UIColor.whiteColor;
        self.tableView3.hidden = YES;
    } else {
        self.tableView2.backgroundColor = [UIColor colorWithHexString:@"#F9FAFB"];
        self.tableView3.hidden = NO;
    }
}

/// 分别处理三个列表选中的情况
/// @param tableIndex 列表索引 1 2 3分别代表三个不同的列表
- (void)_dealTableDidSelectLogic:(NSInteger)tableIndex {
    if (tableIndex == 1) {
        
        JNLifeTransModel *table1PreModel = self.listDataArray[self.table1PreIndex];
        table1PreModel.selected = NO;
        JNLifeTransModel *table2PreModel = table1PreModel.transItems[self.table2PreIndex];
        table2PreModel.selected = NO;
        if (self.table3PreIndex != -1) {
            JNLifeTransModel *table3CurrentModel = table2PreModel.transItems[self.table3PreIndex];
            table3CurrentModel.selected = NO;
        }
        
        JNLifeTransModel *table1CurrentModel = self.listDataArray[self.table1Index];
        table1CurrentModel.selected = YES;
        JNLifeTransModel *table2CurrentModel = table1CurrentModel.transItems[self.table2Index];
        table2CurrentModel.selected = YES;
        
        if (self.table3Index != -1) {
            JNLifeTransModel *table3CurrentModel = table2CurrentModel.transItems[self.table3Index];
            table3CurrentModel.selected = YES;
        }
        
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        [self.tableView3 reloadData];
        
    } else if (tableIndex == 2) {
        
        JNLifeTransModel *table1PreModel = self.listDataArray[self.table1PreIndex];
        table1PreModel.selected = NO;
        JNLifeTransModel *table2PreModel = table1PreModel.transItems[self.table2PreIndex];
        table2PreModel.selected = NO;
        if (self.table3PreIndex != -1) {
            JNLifeTransModel *table3CurrentModel = table2PreModel.transItems[self.table3PreIndex];
            table3CurrentModel.selected = NO;
        }
        
        JNLifeTransModel *table1CurrentModel = self.listDataArray[self.table1Index];
        table1CurrentModel.selected = YES;
        JNLifeTransModel *table2CurrentModel = table1CurrentModel.transItems[self.table2Index];
        table2CurrentModel.selected = YES;
        if (self.table3Index != -1) {
            JNLifeTransModel *table3CurrentModel = table2CurrentModel.transItems[self.table1Index];
            table3CurrentModel.selected = YES;
        }
        [self.tableView2 reloadData];
        [self.tableView3 reloadData];
    } else {
        
        JNLifeTransModel *table1PreModel = self.listDataArray[self.table1PreIndex];
        table1PreModel.selected = NO;
        JNLifeTransModel *table2PreModel = table1PreModel.transItems[self.table2PreIndex];
        table2PreModel.selected = NO;
        if (self.table3PreIndex != -1) {
            JNLifeTransModel *table3CurrentModel = table2PreModel.transItems[self.table3PreIndex];
            table3CurrentModel.selected = NO;
        }
        
        JNLifeTransModel *table1CurrentModel = self.listDataArray[self.table1Index];
        table1CurrentModel.selected = YES;
        JNLifeTransModel *table2CurrentModel = table1CurrentModel.transItems[self.table2Index];
        table2CurrentModel.selected = YES;
        if (self.table3Index != -1) {
            JNLifeTransModel *table3CurrentModel = table2CurrentModel.transItems[self.table3Index];
            table3CurrentModel.selected = YES;
        }
        [self.tableView3 reloadData];
    }
}
// 处理用户确认选中
- (void)_dealUserConfirmState:(NSInteger)tableIndex {
    if (tableIndex == 2) {
        // 判断用户选择的类型
        if (self.table1Index == 0) {
            // 用户选择为距离的子类型. 保存当前用户的选择
            
            self.currentSelectIndexModel.preIndex1 = self.table1Index;
            self.currentSelectIndexModel.preIndex2 = self.table1Index;
            self.currentSelectIndexModel.preIndex3 = self.table1Index;
            
            self.currentSelectIndexModel.index1 = self.table1Index;
            self.currentSelectIndexModel.index2 = self.table2Index;
            self.currentSelectIndexModel.index3 = self.table3Index;
            
            self.currentSelectIndexModel.chooseType = 0;
            // 拿到选中的数据
            JNLifeTransModel *model = self.listDataArray[self.table1Index].transItems[self.table2Index];
            self.currentSelectIndexModel.dataModel = model;
            [self dismiss];
            if (self.dismissCallBack) {
                self.dismissCallBack(self.currentSelectIndexModel);
            }
        }
        // 单独处理地铁为不限的情况
        if (self.table1Index == 1) {
            if (self.table2Index == 0) {
                self.currentSelectIndexModel.preIndex1 = self.table1Index;
                self.currentSelectIndexModel.preIndex2 = self.table1Index;
                self.currentSelectIndexModel.preIndex3 = self.table1Index;
                
                self.currentSelectIndexModel.index1 = self.table1Index;
                self.currentSelectIndexModel.index2 = self.table2Index;
                self.currentSelectIndexModel.index3 = self.table3Index;
                
                self.currentSelectIndexModel.chooseType = 1;
                
                JNLifeTransModel *model = self.listDataArray[self.table1Index].transItems[self.table2Index];
                self.currentSelectIndexModel.dataModel = model;
                [self dismiss];
                if (self.dismissCallBack) {
                    self.dismissCallBack(self.currentSelectIndexModel);
                }
            }
        }
    }
    if (tableIndex == 3) {
        // 判断用户选择的类型
        if (self.table1Index == 1) {
            // 用户选择为地铁的子类型. 保存当前用户的选择
            self.currentSelectIndexModel.preIndex1 = self.table1Index;
            self.currentSelectIndexModel.preIndex2 = self.table1Index;
            self.currentSelectIndexModel.preIndex3 = self.table1Index;
            
            self.currentSelectIndexModel.index1 = self.table1Index;
            self.currentSelectIndexModel.index2 = self.table2Index;
            self.currentSelectIndexModel.index3 = self.table3Index;
            
            self.currentSelectIndexModel.chooseType = 1;
            
            JNLifeTransModel *model = self.listDataArray[self.table1Index].transItems[self.table2Index].transItems[self.table3Index];
            self.currentSelectIndexModel.dataModel = model;
            [self dismiss];
            if (self.dismissCallBack) {
                self.dismissCallBack(self.currentSelectIndexModel);
            }
        }
    }
}
#pragma mark - lazy
- (UITableView *)tableView1 {
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.sectionHeaderHeight = 0.01;
        _tableView1.sectionFooterHeight = 0.01;
        _tableView1.tableFooterView = [[UIView alloc] init];
        _tableView1.backgroundColor = [UIColor colorWithHexString:@"#F5F6F7"];
        _tableView1.estimatedRowHeight = 0;
        _tableView1.estimatedSectionFooterHeight = 0;
        _tableView1.estimatedSectionHeaderHeight = 0;
        _tableView1.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)){
            _tableView1.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView1;
}
- (UITableView *)tableView2 {
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.sectionHeaderHeight = 0.01;
        _tableView2.sectionFooterHeight = 0.01;
        _tableView2.tableFooterView = [[UIView alloc] init];
        _tableView2.backgroundColor = [UIColor whiteColor];
        _tableView2.estimatedRowHeight = 0;
        _tableView2.estimatedSectionFooterHeight = 0;
        _tableView2.estimatedSectionHeaderHeight = 0;
        _tableView2.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)){
            _tableView2.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView2;
}
- (UITableView *)tableView3 {
    if (!_tableView3) {
        _tableView3 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView3.delegate = self;
        _tableView3.dataSource = self;
        _tableView3.sectionHeaderHeight = 0.01;
        _tableView3.sectionFooterHeight = 0.01;
        _tableView3.tableFooterView = [[UIView alloc] init];
        _tableView3.backgroundColor = [UIColor whiteColor];
        _tableView3.estimatedRowHeight = 0;
        _tableView3.estimatedSectionFooterHeight = 0;
        _tableView3.estimatedSectionHeaderHeight = 0;
        _tableView3.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)){
            _tableView3.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView3;
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
- (NSMutableArray<JNLifeTransModel *> *)listDataArray {
    if (!_listDataArray) {
        _listDataArray = [[NSMutableArray alloc] init];
    }
    return _listDataArray;
}
- (NSMutableArray<JNLifeTransModel *> *)oriArray {
    if (!_oriArray) {
        _oriArray = [[NSMutableArray alloc] init];
    }
    return _oriArray;
}
- (NSArray<JNLifeDistanceModel *> *)distanceArray {
    if (!_distanceArray) {
        JNLifeDistanceModel *model0 = [JNLifeDistanceModel createWithTitle:@"不限" distance:@""];
        JNLifeDistanceModel *model1 = [JNLifeDistanceModel createWithTitle:@"500m" distance:@"0.5"];
        JNLifeDistanceModel *model2 = [JNLifeDistanceModel createWithTitle:@"1km" distance:@"1"];
        JNLifeDistanceModel *model3 = [JNLifeDistanceModel createWithTitle:@"2km" distance:@"2"];
        JNLifeDistanceModel *model4 = [JNLifeDistanceModel createWithTitle:@"3km" distance:@"3"];
        _distanceArray = @[model0,model1,model2,model3,model4];
    }
    return _distanceArray;
}
@end
