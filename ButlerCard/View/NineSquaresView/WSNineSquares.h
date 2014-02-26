//
//  WSNineSquares.h
//  FlyingCodes WifiSwitch
//
//  Created by johnny tang on 8/19/13.
//  Copyright (c) 2013 GZTech Electronics (Shenzhen) Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSNineSquaresCell.h"

@class WSNineSquares;
//_______________________________________________________________________________________________________________
/*! 
 @protocol WSNineSquaresDelegate
 @abstract 委托协议
 */
@protocol WSNineSquaresDelegate <NSObject>
@optional
/*!
 @abstract 处理添加按钮点击时调用的委托方法，表示将要添加新的Cell.
 @param    nineSquares WSNineSquares实例对象.
 @return   添加Cell成功返回YES, 失败返回NO.
 */
- (BOOL)nineSquaresWillAddCell:(WSNineSquares *)nineSquares;

/*!
 @abstract 处理删除按钮点击时调用的委托方法，表示将要删除一个Cell.
 @param    nineSquares WSNineSquares实例对象.
 @param    cell        将要删除的Cell.
 @return   删除Cell成功返回YES,失败返回NO.
 */
- (BOOL)nineSquares:(WSNineSquares *)nineSquares willDeleteCell:(WSNineSquaresCell *)cell;

/*!
 @abstract 处理点击某个Cell时调用的委托方法.
 @param    nineSquares WSNineSquares实例对象.
 @param    cell        点击的Cell.
 */
- (void)nineSquares:(WSNineSquares *)nineSquares cellClicked:(WSNineSquaresCell *)cell;

/*!
 @abstract 处理移动Cell位置时调用的委托方法.
 @param    nineSquares WSNineSquares实例对象.
 @param    sourceIndex 原位置索引号.
 @param    proposedDestinationIndex 目标位置索引号.
 */
- (NSInteger)nineSquares:(WSNineSquares *)nineSquares targetIndexForMoveFromCellAtIndex:(NSInteger)sourceIndex toProposedIndex:(NSInteger)proposedDestinationIndex;
@end

//_______________________________________________________________________________________________________________
/*!
 @protocol WSNineSquaresDataSource
 @abstract 数据源协议
 */
@protocol WSNineSquaresDataSource <NSObject>
@required
/*!
 @abstract 获取单元格个数.
 @param    nineSquares WSNineSquares实例对象.
 @return   单元格个数.
 */
- (NSInteger)numberOfCellsInNineSquares:(WSNineSquares *)nineSquares;

/*!
 @abstract 初始化单元格内容.
 @param    nineSquares WSNineSquares实例对象.
 @param    cell        需要被初始化的单元格.
 @param    index       单元格索引号.
 @return   初始化后的单元格.
 @discussion 此方法主要用于设置单元格名称和背景图片.
 */
- (WSNineSquaresCell *)nineSquares:(WSNineSquares *)nineSquares initCell:(WSNineSquaresCell *)cell atIndex:(NSInteger)index;
@end

//_______________________________________________________________________________________________________________
/*!
 @abstract 九宫格视图.
 @discussion 本工程用于主界面中每个房间的开关实现和控制.
 */
@interface WSNineSquares : UIScrollView
/*! @brief 单元格总数 */
@property (assign, readonly, nonatomic) NSUInteger cellsCount;

/*! @brief 委托协议，nil表示不实现委托协议. */
@property (assign, nonatomic) id<WSNineSquaresDelegate> nineSquaresDelegate;

/*! @brief 数据源协议，数据源协议为视图显示的数据来源，必须实现. */
@property (assign, nonatomic) id<WSNineSquaresDataSource> nineSquaresDateSource;

/*!
 @brief 重新加载视图所有数据.
 */
- (void)reloadData;
@end
