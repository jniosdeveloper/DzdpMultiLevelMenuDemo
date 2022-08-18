//
//  ViewController.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "ViewController.h"
#import "JNLifeChooseView.h"
#import "JNTypeShowView.h"
#import "JNLifeMenuView.h"
#import "JNLifeTransSelectModel.h"
#import "JNLifeModuleDataManager.h"
#import "JNTransShowView.h"

@interface ViewController ()
@property (nonatomic, strong) JNLifeChooseView *topChooseView;
@property (nonatomic, strong) JNTypeShowView *typeShowView;
@property (nonatomic, strong) JNLifeMenuView *currentView;
@property (nonatomic, strong) JNTransShowView *transShowView;
// 选中的类型
@property (nonatomic, strong) JNLifeShopCategoryModel *selectTypeModel;
// 选中的距离或地铁
@property (nonatomic, strong) JNLifeTransSelectModel *selectTransModel;
// 门店分类
@property (nonatomic, strong) NSString *categoryCode;
// 距离
@property (nonatomic, strong) NSString *distance;
// 0全部类型 1距离/地铁
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIView *maskView;
// 当前菜单是否有展示项
@property (nonatomic, assign) BOOL menuShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = JNRandomColor;
    [self configUI];
}
- (void)configUI {
    self.currentIndex = -1;
    JNLifeShopCategoryModel *model = [[JNLifeShopCategoryModel alloc] init];
    model.categoryName = @"全部类型";
    model.categoryCode = @"";
    model.select = YES;
    self.selectTypeModel = model;
    
    self.selectTransModel = [[JNLifeTransSelectModel alloc] init];
    
    [self.view addSubview:self.topChooseView];
    [self.topChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(kNavHeight - 16.0);
        make.left.mas_equalTo(self.view.mas_left).offset(16.0);
        make.right.mas_equalTo(self.view.mas_right).offset(-16.0);
        make.height.mas_equalTo(40.0);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.topChooseView.typeButtonCallBack = ^ {
        [weakSelf _dealTyleLogic];
    };
    self.topChooseView.transButtonCallBack = ^ {
        [weakSelf _dealTransLogic];
    };
    
}

- (void)tapAction {
    [self _maskDismiss];
    [self.currentView dismiss];
    [self.currentView menuBgDismissTapAction];
    [self _destroyView];
    self.menuShow = NO;
    [self _dealTransViewLogic];
}

- (void)_dealTyleLogic {
    self.currentIndex = 0;
    
    if (self.currentView) {
        [self _maskDismiss];
        [self.currentView dismiss];
        self.menuShow = NO;
        [self _dealTransViewLogic];
        if ([self.currentView isKindOfClass:JNTypeShowView.class]) {
            [self _destroyView];
        } else {
            [self showShopList:(JNLifeMenuView *)self.typeShowView];
        }
    } else {
        [self showShopList:(JNLifeMenuView *)self.typeShowView];
    }
    [self.typeShowView updateSelectState:self.selectTypeModel];
    
}
- (void)_dealTransLogic {
    self.currentIndex = 1;
    
    if (self.currentView) {
        [self _maskDismiss];
        [self.currentView dismiss];
        self.menuShow = NO;
        [self _dealTransViewLogic];
        
        if ([self.currentView isKindOfClass:JNTransShowView.class]) {
            [self _destroyView];
        } else {
            [self showShopList:(JNTransShowView *)self.transShowView];
        }
    } else {
        [self showShopList:(JNLifeMenuView *)self.transShowView];
    }
    [self.transShowView updateSelectState:self.selectTransModel];
}
- (void)showShopList:(JNLifeMenuView *)menuView {
    self.menuShow = YES;
    
    self.currentView = menuView;
    [self _maskShow];
    [self.view insertSubview:self.currentView aboveSubview:self.maskView];
    [self.view insertSubview:self.topChooseView aboveSubview:self.currentView];
    [self.currentView show];
}
- (void)_maskShow {
    [self.maskView.layer removeAllAnimations];
    [self.view addSubview:self.maskView];
    self.maskView.alpha = 0.f;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.f;
    } completion:nil];
    
}
- (void)_maskDismiss {
    [self.maskView.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.f;
    } completion:^(BOOL finished) {
        if (!finished) {
            return;
        }
        [self.maskView removeFromSuperview];
    }];
    
    // 让距离/站点菜单栏数据重置
    [self.transShowView menuBgDismissTapAction];
}
- (void)_dealTransViewLogic {
    [self.topChooseView buttonArrowImageStyle:self.currentIndex listSpread:self.menuShow];
    if (self.currentIndex == 0) {
        [self.topChooseView buttonTitleWithIndex:self.currentIndex title:self.selectTypeModel.categoryName];
    }
    if (self.currentIndex == 1) {
        [self.topChooseView buttonTitleWithIndex:self.currentIndex title:self.selectTransModel.dataModel.title];
    }
}
- (void)_destroyView {
    self.currentView = nil;
}
- (JNLifeChooseView *)topChooseView{
    if (!_topChooseView) {
        _topChooseView = JNLifeChooseView.instanceFromNib;
    }
    return _topChooseView;
}
- (JNTypeShowView *)typeShowView {
    if (!_typeShowView) {
        CGFloat originY = CGRectGetMaxY(self.topChooseView.frame);
        NSMutableArray<JNLifeShopCategoryModel *> *arrayM = [NSMutableArray array];
        [arrayM addObject:self.selectTypeModel];
        [arrayM addObjectsFromArray:[JNLifeModuleDataManager getShopCategoryData]];
        _typeShowView = [[JNTypeShowView alloc] initWithMenuOriginY:originY dataSource:arrayM];
        __weak typeof(self) weakSelf = self;
        _typeShowView.dismissCallBack = ^(JNLifeShopCategoryModel *selectModel) {
            weakSelf.selectTypeModel = selectModel;
            weakSelf.categoryCode = selectModel.categoryCode;
            [weakSelf _maskDismiss];
            [weakSelf _destroyView];
            weakSelf.menuShow = NO;
            [weakSelf _dealTransViewLogic];
        };
        [_typeShowView updateSelectState:self.selectTypeModel];
    }
    return _typeShowView;
}
- (JNTransShowView *)transShowView {
    if (!_transShowView) {
        CGFloat originY = CGRectGetMaxY(self.topChooseView.frame);
        _transShowView = [[JNTransShowView alloc] initWithMenuOriginY:originY];
        __weak typeof(self) weakSelf = self;
        _transShowView.dismissCallBack = ^(JNLifeTransSelectModel *selectModel) {
            weakSelf.selectTransModel = selectModel;
            [weakSelf _maskDismiss];
            [weakSelf _destroyView];
            weakSelf.menuShow = NO;
            [weakSelf _dealTransViewLogic];
        };
    }
    return _transShowView;
}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.frame = self.view.bounds;
        _maskView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
       [_maskView addGestureRecognizer:tapGesturRecognizer];
    }
    return _maskView;
}
@end
