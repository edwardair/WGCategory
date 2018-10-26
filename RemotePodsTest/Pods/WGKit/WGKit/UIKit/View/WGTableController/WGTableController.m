//
//  WGTableController.m
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "WGTableController.h"
#import "WGDefines.h"
#import "NSArray+NSIndexPath.h"
#import "UITableView+WGAutoLayout.h"
#import "UITableViewCell+WGAutoLayout.h"
#import "NSArray+NSIndexPath.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark - Subject
@interface WGTableSubject:NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *wg_tableView;
@property (nonatomic,strong) NSMutableArray *wg_dataSource;/**< @[] if not used*/
@property (nonatomic,strong) NSMutableArray *wg_cells;/**< 通过以下定义方法增加cell*/

/**
 *  安全获取某个section，如果section之前的不存在，则会创建空section
 */
- (NSMutableArray *(^)(NSInteger))sectionAtIndex;
@end

@implementation WGTableSubject
#pragma mark -
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aSelector = anInvocation.selector;
    if (isInstanceSelectorConformsToProtocol(@protocol(UITableViewDelegate), aSelector)
        || isInstanceSelectorConformsToProtocol(@protocol(UITableViewDataSource), aSelector)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wnonnull"
        [anInvocation invokeWithTarget:nil];
#pragma clang diagnostic pop
    }else{
        [anInvocation invoke];
    }
}
//MARK:
//- (void)doesNotRecognizeSelector:(SEL)aSelector{
//    if (isInstanceSelectorConformsToProtocol(@protocol(UITableViewDelegate), aSelector)
//        || isInstanceSelectorConformsToProtocol(@protocol(UITableViewDataSource), aSelector)) {
//        
//    }else{
//        [super doesNotRecognizeSelector:aSelector];
//    }
//    NSLog(@"%s>>>>>%@",__FUNCTION__,NSStringFromSelector(aSelector));
//}

#pragma mark - Datasource
- (NSMutableArray *(^)(NSInteger))sectionAtIndex{
    return ^ NSMutableArray *(NSInteger section){
        NSInteger existSectionCount = self.wg_cells.count;
        //当添加的section超出现有section数组，则添加中间空sections，以备后续填充
        if (section>=existSectionCount) {
            [self.wg_tableView beginUpdates];
            NSInteger willAddCount = section-existSectionCount+1;//+1为偏差值
            for (NSInteger i = 0; i < willAddCount; i++) {
                [self.wg_cells addObject:@[].mutableCopy];
            }
            NSRange willAddSectionRange = NSMakeRange(existSectionCount, willAddCount);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:willAddSectionRange];
            [self.wg_tableView insertSections:indexSet
                             withRowAnimation:UITableViewRowAnimationNone];
            [self.wg_tableView endUpdates];
        }
        return self.wg_cells[section];
    };
}

#pragma mark - getter
- (NSMutableArray *)wg_dataSource{
    if (!_wg_dataSource) {
        _wg_dataSource = [[NSMutableArray alloc]init];
    }
    return _wg_dataSource;
}
- (NSMutableArray *)wg_cells{
    if (!_wg_cells) {
        _wg_cells = [[NSMutableArray alloc]init];
        [_wg_cells addObject:@[].mutableCopy];//默认始终至少有一个section
    }
    return _wg_cells;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.wg_cells.count;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *theSection = self.wg_cells[section];
    return theSection.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return 0;
    }
    if (!cell.didUpdateHeight) {
        cell.bounds = CGRectMake(0, 0, tableView.wg_width, cell.wg_height);
        [cell layoutIfNeeded];
        //需要再次强制刷新一次
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
    }
    return cell.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *theSection = self.sectionAtIndex(indexPath.section);
    UITableViewCell *cell = theSection[indexPath.row];
    return cell ?: [UITableViewCell new];
}

@end


#pragma mark - Controller
@interface WGTableController ()
@property (nonatomic,strong) NSMutableDictionary *registedSelectors;
@property (nonatomic,strong) WGTableSubject *subject;
+ (void)replaceSelector:(SEL)selector;
@end

@implementation WGTableController
+ (void)load{
    //由于tableView:cellForRowAtIndexPath:方法的特殊性，不添加此方法，程序会奔溃
    //将tableView:cellForRowAtIndexPath:修改为_objc_msgForward，强制程序处理消息转发流程
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self replaceSelector:@selector(numberOfSectionsInTableView:)];
        [self replaceSelector:@selector(tableView:numberOfRowsInSection:)];
        [self replaceSelector:@selector(tableView:heightForRowAtIndexPath:)];
        [self replaceSelector:@selector(tableView:cellForRowAtIndexPath:)];
    });
}
- (instancetype)initWithTable:(UITableView *)tableView delegate:(id )delegate;{
    CouldInitialized_Init

    _registedSelectors = @{}.mutableCopy;
    
    _delegate = delegate;
    
    self.subject.wg_tableView = tableView;

    self.subject.wg_tableView.delegate = (id)self;
    self.subject.wg_tableView.dataSource = (id)self;
    
    return self;
}

- (WGTableSubject *)subject{
    if (!_subject) {
        _subject = [[WGTableSubject alloc]init];
    }
    return _subject;
}

#pragma mark - 将UITableViewDelegate UITableViewDataSource 的协议方法替换为_objc_msgForward，以便系统转发消息
+ (void)replaceSelector:(SEL )selector{
    Method targetMethod = class_getInstanceMethod(self, selector);
    if (!targetMethod) {
        //方法不存在，默认无操作
        char* (^objc_m_d)(Protocol *, BOOL , BOOL ) = ^ char* (Protocol *protocol, BOOL isRequiredMethod, BOOL isInstanceMethod){
            struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, isRequiredMethod, isInstanceMethod);
            return methodDescription.types;
        };
        char *typeEncoding = objc_m_d(@protocol(UITableViewDataSource),NO,YES);
        if (typeEncoding==NULL) {
            typeEncoding = objc_m_d(@protocol(UITableViewDataSource),YES,YES);
        }
        if (typeEncoding==NULL) {
            typeEncoding = objc_m_d(@protocol(UITableViewDelegate),NO,YES);
        }
        if (typeEncoding==NULL) {
            typeEncoding = objc_m_d(@protocol(UITableViewDelegate),YES,YES);
        }
        if (typeEncoding==NULL) {
            NSAssert(NO, @"未找到typeEncoding");
        }
        class_addMethod(self, selector, _objc_msgForward, typeEncoding);
        
    }else if(method_getImplementation(targetMethod) != _objc_msgForward){
        //如已存在，则替换为_objc_msgForward，强制系统调用forwardInvocation实现消息转发
        class_replaceMethod(self, selector, _objc_msgForward, method_getTypeEncoding(targetMethod));
    }
}

@end


#pragma mark - Category
@implementation WGTableController (DataSource)
- (NSMutableArray *(^)(NSInteger))sectionAtIndex{
    return self.subject.sectionAtIndex;
}

#pragma mark - add
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger)section {
    [self addCells:cells atSection:section animation:UITableViewRowAnimationNone];
}
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger)section
       animation:(UITableViewRowAnimation)animation {
    NSMutableArray *theSection = self.sectionAtIndex(section);
    
    NSInteger row = theSection.count;
    [theSection addObjectsFromArray:cells];
    
    NSArray<NSIndexPath *> *indexes =
    [NSArray indexPathsFromRow:row inSection:section length:cells.count];
    
    [self.subject.wg_tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
}

#pragma mark - insert
- (void)insertCells:(NSArray<UITableViewCell *> *)cells
              atRow:(NSInteger)row
          inSection:(NSInteger)section {
  [self insertCells:cells
          atRow:row
          inSection:section
          animation:UITableViewRowAnimationLeft];
}
- (void)insertCells:(NSArray<UITableViewCell *> *)cells
              atRow:(NSInteger)row
          inSection:(NSInteger)section
          animation:(UITableViewRowAnimation)animation {
    NSMutableArray *theSection = self.sectionAtIndex(section);
    [theSection insertObjects:cells atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row, cells.count)]];
    NSArray *indexes = [NSArray indexPathsFromRow:row
                                        inSection:section
                                           length:cells.count];
    [self.subject.wg_tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
}


#pragma mark - delete
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes {
    [self deleteCellsAtIndexes:indexes animation:UITableViewRowAnimationNone];
}
/**
 *  indexex中可能存在不同section的NSIndexPath数据，需要区分
 */
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes
                   animation:(UITableViewRowAnimation)animation {
    NSMutableDictionary *cells = @{}.mutableCopy;
    
    NSString *(^sectionKey)(NSIndexPath *) = ^NSString *(NSIndexPath *indexPath){
        return [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    };
    NSString *theSectionKey = @"section";
    NSString *cellsInTheSectionKey = @"cells";
    
    for (NSIndexPath *indexPath in indexes) {
        NSString *key = sectionKey(indexPath);
        NSMutableDictionary *sectionDic = cells[key];
        NSMutableArray *theSection = sectionDic[theSectionKey];
        NSMutableArray *willRemoveCellsInTheSection = sectionDic[cellsInTheSectionKey];
        
        if (!sectionDic) {
            sectionDic = @{}.mutableCopy;
            [cells setObject:sectionDic forKey:key];
            theSection = self.sectionAtIndex(indexPath.section);;
            [sectionDic setObject:theSection forKey:theSectionKey];
            willRemoveCellsInTheSection = @[].mutableCopy;
            [sectionDic setObject:willRemoveCellsInTheSection forKey:cellsInTheSectionKey];
        }
        if (indexPath.row < theSection.count) {
            [willRemoveCellsInTheSection addObject:theSection[indexPath.row]];
        }
    }
    //将遍历出的cell从各自的section中移除
    for (NSString *key in cells.allKeys) {
        NSMutableDictionary *sectionDic = cells[key];
        NSMutableArray *theSection = sectionDic[theSectionKey];
        NSMutableArray *willRemoveCellsInTheSection = sectionDic[cellsInTheSectionKey];
        [theSection removeObjectsInArray:willRemoveCellsInTheSection];
    }
    //刷新tableView
    [self.subject.wg_tableView deleteRowsAtIndexPaths:indexes withRowAnimation:animation];
}


#pragma mark - reload
- (void)updateHeightOfAllCells{
    NSArray<NSIndexPath *> *indexPaths = [NSArray indexPathsFromAllSections:self.subject.wg_cells];
    [self updateHeightAtIndexes:indexPaths];
}
- (void)updateHeightAtIndexes:(NSArray<NSIndexPath *> *)indexes {
    if (indexes.count==0) {
        return;
    }
    NSArray *cells = [NSArray cellsForIndexPaths:indexes in:self.subject.wg_cells];
    [cells makeObjectsPerformSelector:@selector(setNeedUpdateHeight)];

    void(^reload)() = ^(){
        [self.subject.wg_tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
        //MARK: 必须多调用一次，UI才会正确刷新，如果用reload，则只需一遍即可，但动画很生硬，不知道是否是系统BUG
        [self.subject.wg_tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
    };
    reload();
}

@end


#pragma mark - Replace
//MODEL
@interface WGSelectorModel : NSObject
@property (nonatomic,assign) BOOL enable;
@property (nonatomic,assign) SEL origSelector;//需要修改的WGTableView的方法名
@property (nonatomic,assign) SEL newSelector;//修改后需要调用的WGTableView的方法名
@end
@implementation WGSelectorModel
@end

//--------------------------------------
@implementation WGTableController (Replace)
#pragma mark - over wirte
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *key = NSStringFromSelector(aSelector);
    WGSelectorModel *model = _registedSelectors[key];
    if ([model enable] && [_delegate respondsToSelector:model.newSelector]) {
        if (model.origSelector==model.newSelector) {
            return _delegate;
        }else{
            return nil;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aSelector = [anInvocation selector];
    NSString *key = NSStringFromSelector(aSelector);
    WGSelectorModel *model = _registedSelectors[key];
    if ([model enable] && [_delegate respondsToSelector:model.newSelector]) {
        anInvocation.selector = model.newSelector;
        [anInvocation invokeWithTarget:_delegate];
    }else{
        [anInvocation invokeWithTarget:self.subject];
    }
}

#pragma mark - replace
- (void)wg_replaceSelector:(SEL)selector{
    [self wg_replaceSelector:selector withNewSelector:selector];
}
- (void)wg_replaceSelector:(SEL)selector withNewSelector:(SEL)newSelector{
    if (!_delegate) {
        NSAssert(NO, @"delegate不存在，无法转发委托消息");
        return;
    }
    BOOL isDelegate_ = isInstanceSelectorConformsToProtocol(@protocol(UITableViewDelegate), selector);
    BOOL isDataSource_ = isInstanceSelectorConformsToProtocol(@protocol(UITableViewDataSource), selector);
    if (!(isDelegate_ || isDataSource_)) {
        NSAssert(NO, @"仅支持@[UITableViewDelegate,UITableViewDataSource]协议转发");
        return;
    }
    //保存需要修改的方法名
    NSString *key = NSStringFromSelector(selector);
    WGSelectorModel *model = [[WGSelectorModel alloc]init];
    model.enable = YES;
    model.origSelector = selector;
    model.newSelector = newSelector;
    [_registedSelectors setObject:model forKey:key];
    
    [[self class] replaceSelector:selector];
    
    //方法修改后，需要重置delegate，否则部分API不会走，猜测是UITableView做了缓存导致的
    if (isDelegate_) self.subject.wg_tableView.delegate = (id)self;
    else self.subject.wg_tableView.dataSource = (id)self;
}

@end
