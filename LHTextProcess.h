//
//  LHTextProcess.h
//  Miao
//
//  Created by 余斌 on 16/07/11.
//  Copyright © 2016年 ZNM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface LHTextProcess : NSObject

#pragma mark - 处理前需要设置的参数
/**
 *  文字内容
 */
@property (nonatomic,copy)NSString * textContent;
/**
 *  字体和大小 默认字体格式：系统默认 默认字体大小：15
 */
@property (nonatomic,assign)NSTextAlignment alignment;
/**
 *  字间距 默认间距：2
 */
@property (nonatomic,strong)UIFont * font;
/**
 *  默認顏色 黑色
 */
@property (nonatomic,strong)UIColor * textColor;
/**
 *  段间距 默认间距：2
 */
@property (nonatomic,strong)NSString * workSpace;
/**
 *  行间距 默认间距：2
 */
@property (nonatomic,strong)NSString * lineSpace;
/**
 *  首行缩进
 */
@property (nonatomic,assign)CGFloat firstLineHeadIndent;
/**
 *  缩进
 */
@property (nonatomic,assign)CGFloat headIndent;
/**
 *  文字显示的行数
 */
@property (nonatomic,strong)NSString * lineNum;

/**
 *  溢出末尾显示的内容 默认为: ...
 */
@property (nonatomic,strong)NSString * overFlowText;
/**
 *  溢出末尾显示的内容 需要添加下划线
 */
@property (nonatomic,assign)BOOL overFlowDownLine;
/**
 *  溢出 font 系统默认 默认字体大小：15
 */
@property (nonatomic,strong)UIFont * overFlowTextFont;
/**
 *  溢出内容的颜色
 */
@property (nonatomic,strong)UIColor * overFlowTextColor;
/**
 *  限制的区域尺寸。 必须要设置的
 */
@property (nonatomic,assign)CGSize size;
/**
 *  设置行高
 */
@property (nonatomic,strong)NSString *lineHeightMultiple;

/**
 *  设置特殊的颜色
 */
-(void)setTextWithLocationFrom:(NSInteger)numStart To:(NSInteger)numEnd WithColor:(UIColor *)highColor;
/**
 *  设置特殊的字體大小
 */
-(void)setTextWithLocationFrom:(NSInteger)numStart To:(NSInteger)numEnd WithFont:(UIFont *)highFont;
/**
 *	设置
 */
-(void)setTextWithLocationFrom:(NSInteger)numStart To:(NSInteger)numEnd WithOther:(id)other;

/**
 *	通过文字内容进行更改文字属性
 */
-(void)setTextWithContent:(id)other withValue:(NSString *)content;
/**
 *	移除所有的设置
 */
-(void)removeALlTextSet;

/**
 *  去计算 调用之前需要设置好以上的参数
 */
-(void)toCalculateText;

/**************************************************************************

 注意：UILabel 设置TextColor方法，请在 执行 -(void)toCalculateText; 方法之前设置。
 
 ***************************************************************************/



#pragma mark - 处理后的数据
/**
 *  文字内容 富文本格式
 */
@property (nonatomic,strong)NSMutableAttributedString * textContentAttri;
/**
 *  文字内容 的高度
 */
@property (nonatomic,assign)CGFloat textHeight;
/**
 *  文字内容 的宽度
 */
@property (nonatomic,assign)CGFloat textWidth;
#pragma mark ------------------------------------------------------------------------
/**
 *  返回 文字内容 总的行数
 */
@property (nonatomic,assign)NSInteger textLineNum;
@property (nonatomic,assign)NSInteger numberLines;
/**
 *  文字内容 富文本格式, 【仅仅在设置了显示的行数，并且溢出情况下才会有值】
 */
@property (nonatomic,strong)NSMutableAttributedString * textContentAttriAll;
/**
 *  返回 文字内容 高度  【仅仅在设置了显示的行数，并且溢出情况下才会有值】
 */
@property (nonatomic,assign)CGFloat textAllHeight;


/**
 *  计算文字的size
 */
+(CGFloat)widthWithLabel:(UILabel *)lab;


@end
