//
//  BSYLiveIMFaceView.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMFaceView.h"
#import "BSYLiveIMFaceCell.h"
#import "BSYLiveChatViewTheme.h"
#import "BSYLiveChatDefine.h"


#define BSYLiveIMFaceView_Margin 12
#define BSYLiveIMFaceView_LineHeight 0.5
#define BSYLiveIMFaceView_PageHeight 30



@implementation BSYLiveIMFaceGroup
@end


@interface BSYLiveIMFaceView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray<BSYLiveIMFaceGroup *> *faceGroups;
@property (nonatomic, assign) CGFloat faceViewPagePadding;
@property (nonatomic, strong) NSMutableArray *sectionIndexInGroup;
@property (nonatomic, strong) NSMutableArray *pageCountInGroup;
@property (nonatomic, strong) NSMutableArray *groupIndexInSection;
@property (nonatomic, strong) NSMutableDictionary *itemIndexs;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, assign) NSInteger curGroupIndex;
@end

@implementation BSYLiveIMFaceView

- (id)initWithFrame:(CGRect)frame facePagePadding:(CGFloat)facePagePadding
{
    self = [super initWithFrame:frame];
    if(self){
        self.faceViewPagePadding = facePagePadding;
        [self setupViews];
        [self defaultLayout];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = BSYLiveIMFaceView_BgColor;
    self.faceFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.faceFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.faceFlowLayout.minimumLineSpacing = BSYLiveIMFaceView_Margin;
    self.faceFlowLayout.minimumInteritemSpacing = BSYLiveIMFaceView_Margin;
    self.faceFlowLayout.sectionInset = UIEdgeInsetsMake(0,  self.faceViewPagePadding, 0,  self.faceViewPagePadding);

    self.faceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.faceFlowLayout];
    [self.faceCollectionView registerClass:[BSYLiveIMFaceCell class] forCellWithReuseIdentifier:NSStringFromClass([BSYLiveIMFaceCell class])];
    self.faceCollectionView.collectionViewLayout = _faceFlowLayout;
    self.faceCollectionView.pagingEnabled = YES;
    self.faceCollectionView.delegate = self;
    self.faceCollectionView.dataSource = self;
    self.faceCollectionView.showsHorizontalScrollIndicator = NO;
    self.faceCollectionView.showsVerticalScrollIndicator = NO;
    self.faceCollectionView.backgroundColor = self.backgroundColor;
    self.faceCollectionView.alwaysBounceHorizontal = YES;
    [self addSubview:self.faceCollectionView];
    
    if (@available(iOS 11.0, *)) {
          self.faceCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    

    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = BSYLiveIMFaceView_LineViewBgColor;
    [self addSubview:_lineView];

    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPageIndicatorTintColor = BSYLiveIMFaceView_pageControlColor;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];;
    [self addSubview:self.pageControl];
}

- (void)defaultLayout
{
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, BSYLiveIMFaceView_LineHeight);
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - BSYLiveIMFaceView_PageHeight-(IPHONE_MARGIN_BOTTOM/3.0), self.frame.size.width, BSYLiveIMFaceView_PageHeight);
    self.faceCollectionView.frame = CGRectMake(0, _lineView.frame.origin.y + _lineView.frame.size.height + BSYLiveIMFaceView_Margin, self.frame.size.width, self.frame.size.height - _pageControl.frame.size.height - _lineView.frame.size.height - 2 * BSYLiveIMFaceView_Margin-(IPHONE_MARGIN_BOTTOM/3.0));
}


//- (void)setIMFaceViewPagePadding:(CGFloat)padding
//{
//    self.faceViewPagePadding = padding;
//    self.faceFlowLayout.sectionInset = UIEdgeInsetsMake(0,  self.faceViewPagePadding, 0,  self.faceViewPagePadding);
//    self.faceCollectionView.collectionViewLayout = self.faceFlowLayout;
//    [self.faceCollectionView reloadData];
//}

- (void)setData:(NSMutableArray<BSYLiveIMFaceGroup *> *)data
{
    self.faceGroups = data;
    [self defaultLayout];

    _sectionIndexInGroup = [NSMutableArray array];
    _groupIndexInSection = [NSMutableArray array];
    _itemIndexs = [NSMutableDictionary dictionary];
    _pageCountInGroup = [NSMutableArray array];

    NSInteger sectionIndex = 0;
    for (NSInteger groupIndex = 0; groupIndex < _faceGroups.count; ++groupIndex) {
        BSYLiveIMFaceGroup *group = _faceGroups[groupIndex];
        [_sectionIndexInGroup addObject:@(sectionIndex)];
        int itemCount = group.rowCount * group.itemCountPerRow;
        int sectionCount = ceil(group.faces.count * 1.0 / (itemCount  - (group.needBackDelete ? 1 : 0)));
        [_pageCountInGroup addObject:@(sectionCount)];
        for (int sectionIndex = 0; sectionIndex < sectionCount; ++sectionIndex) {
            [_groupIndexInSection addObject:@(groupIndex)];
        }
        sectionIndex += sectionCount;
    }
    _sectionCount = sectionIndex;


    for (NSInteger curSection = 0; curSection < _sectionCount; ++curSection) {
        NSNumber *groupIndex = _groupIndexInSection[curSection];
        NSNumber *groupSectionIndex = _sectionIndexInGroup[groupIndex.integerValue];
        BSYLiveIMFaceGroup *face = _faceGroups[groupIndex.integerValue];
        NSInteger itemCount = face.rowCount * face.itemCountPerRow - face.needBackDelete;
        NSInteger groupSection = curSection - groupSectionIndex.integerValue;
        for (NSInteger itemIndex = 0; itemIndex < itemCount; ++itemIndex) {
            // transpose line/row
            NSInteger row = itemIndex % face.rowCount;
            NSInteger column = itemIndex / face.rowCount;
            NSInteger reIndex = face.itemCountPerRow * row + column + groupSection * itemCount;
            [_itemIndexs setObject:@(reIndex) forKey:[NSIndexPath indexPathForRow:itemIndex inSection:curSection]];
        }
    }

    _curGroupIndex = 0;
    if(_pageCountInGroup.count != 0){
        _pageControl.numberOfPages = [_pageCountInGroup[0] intValue];
    }
    [_faceCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int groupIndex = [_groupIndexInSection[section] intValue];
    BSYLiveIMFaceGroup *group = _faceGroups[groupIndex];
    return group.rowCount * group.itemCountPerRow;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSYLiveIMFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BSYLiveIMFaceCell class]) forIndexPath:indexPath];
    int groupIndex = [_groupIndexInSection[indexPath.section] intValue];
    BSYLiveIMFaceGroup *group = _faceGroups[groupIndex];
    int itemCount = group.rowCount * group.itemCountPerRow;
    if(indexPath.row == itemCount - 1 && group.needBackDelete){
        BSYLiveIMFaceCellData *data = [[BSYLiveIMFaceCellData alloc] init];
        data.path = BSYLiveIMMessageFace(@"del_normal");
        [cell setData:data];
    }
    else{
        NSNumber *index = [_itemIndexs objectForKey:indexPath];
        if(index.integerValue < group.faces.count) {
            BSYLiveIMFaceCellData *data = group.faces[index.integerValue];
            [cell setData:data];
        }
        else{
            [cell setData:nil];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int groupIndex = [_groupIndexInSection[indexPath.section] intValue];
    BSYLiveIMFaceGroup *faces = _faceGroups[groupIndex];
    int itemCount = faces.rowCount * faces.itemCountPerRow;
    if(indexPath.row == itemCount - 1 && faces.needBackDelete){
        if(_delegate && [_delegate respondsToSelector:@selector(faceViewDidBackDelete:)]){
            [_delegate faceViewDidBackDelete:self];
        }
    }
    else{
        NSNumber *index = [_itemIndexs objectForKey:indexPath];
        if(index.integerValue < faces.faces.count){
            if(_delegate && [_delegate respondsToSelector:@selector(faceView:didSelectItemAtIndexPath:)]){
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index.integerValue inSection:groupIndex];
                [_delegate faceView:self didSelectItemAtIndexPath:indexPath];
            }
        }
        else{

        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int groupIndex = [_groupIndexInSection[indexPath.section] intValue];
    BSYLiveIMFaceGroup *group = _faceGroups[groupIndex];
    CGFloat width = (self.frame.size.width -  self.faceViewPagePadding * 2 - BSYLiveIMFaceView_Margin * (group.itemCountPerRow - 1)) / group.itemCountPerRow;
    CGFloat height = (collectionView.frame.size.height -  BSYLiveIMFaceView_Margin * (group.rowCount - 1)) / group.rowCount;
    return CGSizeMake(width, height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger curSection = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSNumber *groupIndex = _groupIndexInSection[curSection];
    NSNumber *startSection = _sectionIndexInGroup[groupIndex.integerValue];
    NSNumber *pageCount = _pageCountInGroup[groupIndex.integerValue];
    if(_curGroupIndex != groupIndex.integerValue){
        _curGroupIndex = groupIndex.integerValue;
        _pageControl.numberOfPages = pageCount.integerValue;
//        if(_delegate && [_delegate respondsToSelector:@selector(faceView:scrollToFaceGroupIndex:)]){
//            [_delegate faceView:self scrollToFaceGroupIndex:_curGroupIndex];
//        }
    }
    _pageControl.currentPage = curSection - startSection.integerValue;
}


@end
