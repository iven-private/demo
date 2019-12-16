//
//  LHTextProcess.m
//  Miao
//
//  Created by 余斌 on 16/07/11.
//  Copyright © 2016年 ZNM. All rights reserved.
//

#import "LHTextProcess.h"
#import "ProtectData.h"

@implementation LHTextProcess
{
    NSMutableParagraphStyle * ParaStyle;
    CGFloat  heightFixed;
    
    NSMutableArray * arrChange;
	NSInteger times;
	
//	NSStringDrawingOptions defaultOption;

}

+(CGFloat)widthWithLabel:(UILabel *)lab {
    LHTextProcess * showText = [[LHTextProcess alloc] init];
    showText.textContent = lab.text;
    showText.font = lab.font;
    showText.size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    return showText.size.width;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        arrChange = [NSMutableArray array];
    }
    return self;
}


- (NSString *)filterBlankAndBlankLines:(NSString *)str {
	NSMutableString *Mstr = [NSMutableString string];
	NSArray *arr = [str componentsSeparatedByString:@"\n"];
	for (int i = 0; i < arr.count; i++) {
		NSString *tempStr = (NSString *)arr[i];
		if ([tempStr isEqualToString:@"\n"] || [tempStr isEqualToString:@"\r"]) {
			continue;
		}
		[tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
		[tempStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
		[tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		if (tempStr.length != 0) {
			[Mstr appendString:arr[i]];
			if (i < [arr count] - 1) {
				[Mstr appendString:@"\n"];
			}
		}
	}
	
	for (NSInteger i = Mstr.length - 1; i < Mstr.length; i--) {
		NSString * strLast = [Mstr substringWithRange:NSMakeRange(i, 1)];
		if ([StringValue(strLast) isEqualToString:@"\n"]) {
			[Mstr deleteCharactersInRange:NSMakeRange(i, 1)];
		} else {
			break;
		}
	}
	
	
	return Mstr;
}



-(void)setTextContent:(NSString *)textContent {
    textContent = [self filterBlankAndBlankLines:textContent];
    _textContent = textContent;
}

-(void)setFont:(UIFont *)font {
    _font = font;
}

-(void)setWorkSpace:(NSString *)workSpace {
    _workSpace =workSpace;
}

-(void)setLineSpace:(NSString *)lineSpace {
    _lineSpace =lineSpace;
}

-(void)setSize:(CGSize)size {
    _size = size;
}

-(void)setLineNum:(NSString *)lineNum {
    _lineNum = lineNum;
}

-(void)setOverFlowText:(NSString *)overFlowText {
    _overFlowText = overFlowText;
}


-(void)setOverFlowTextColor:(UIColor *)overFlowTextColor {
    _overFlowTextColor = overFlowTextColor;
}

-(void)setOverFlowTextFont:(UIFont *)overFlowTextFont {
    _overFlowTextFont = overFlowTextFont;
}

-(void)setAlignment:(NSTextAlignment)alignment {
    _alignment = alignment;
}

-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}

-(void)setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent {
    _firstLineHeadIndent = firstLineHeadIndent;
}

-(void)setHeadIndent:(CGFloat)headIndent {
    _headIndent = headIndent;
}

-(void)setLineHeightMultiple:(NSString *)lineHeightMultiple {
	_lineHeightMultiple = lineHeightMultiple;
}

-(void)setTextWithContent:(id)other withValue:(NSString *)content {
    
    
    
}

-(void)setTextWithLocationFrom:(NSInteger)numStart To:(NSInteger)numEnd WithColor:(UIColor *)highColor {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"state"] = @(1); // 1 表示 颜色
    dict[@"from"] = @(numStart);
    dict[@"to"] = @(numEnd);
    dict[@"content"] = highColor;
    
    [arrChange addObject:dict];
}

-(void)setTextWithLocationFrom:(NSInteger)numStart To:(NSInteger)numEnd WithFont:(UIFont *)highFont {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"state"] = @(2); // 2 表示 font
    dict[@"from"] = @(numStart);
    dict[@"to"] = @(numEnd);
    dict[@"content"] = highFont;
    
    [arrChange addObject:dict];
    
}

-(void)setTextWithLocationFrom:(NSInteger)numStart To:(NSInteger)numEnd WithOther:(id)other {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"state"] = @(3); // 3 表示 NSUnderlineStyleAttributeName
    dict[@"from"] = @(numStart);
    dict[@"to"] = @(numEnd);
    dict[@"content"] = [NSNumber numberWithInteger:NSUnderlineStyleSingle];
    
    [arrChange addObject:dict];
    
}


-(void)removeALlTextSet {
    [arrChange removeAllObjects];
}


-(void)toCalculateText {
    
    times = 0;
    
    if (_textContent == nil) {
        _textContent = @"";
    }
    if (_overFlowText == nil) {
        _overFlowText = @"...";
    }
    
    if (_overFlowTextColor == nil) {
        if (_textColor == nil) {
            _overFlowTextColor = [UIColor blackColor];
        } else {
            _overFlowTextColor = _textColor;
        }
    }
    
    if (_font == nil) {
        _font = [UIFont systemFontOfSize:15.f];
    }
    
    if (_overFlowTextFont == nil) {
        _overFlowTextFont = _font;
    }
    
    if (_alignment == 0) {
        _alignment = NSTextAlignmentLeft;
    }
    
    NSInteger fontSize = _font.pointSize;
    
    if (_workSpace == nil) {
        
        if (fontSize == 11) {
            _workSpace = @"3";
        } else if (fontSize == 12) {
            _workSpace = @"4";
        } else if (fontSize == 13) {
            _workSpace = @"4";
        } else if (fontSize == 14) {
            _workSpace = @"5";
        } else if (fontSize == 15) {
            _workSpace = @"5";
        } else if (fontSize == 16) {
            _workSpace = @"6";
        } else if (fontSize == 18) {
            _workSpace = @"7";
        } else {
            _workSpace = @"2";
        }
    }
    if (_lineSpace == nil) {
        
        if (fontSize == 11) {
            _lineSpace = @"3";
        } else if (fontSize == 12) {
            _lineSpace = @"4";
        } else if (fontSize == 13) {
            _lineSpace = @"4";
        } else if (fontSize == 14) {
            _lineSpace = @"5";
        } else if (fontSize == 15) {
            _lineSpace = @"5";
        } else if (fontSize == 16) {
            _lineSpace = @"6";
        } else if (fontSize == 18) {
            _lineSpace = @"7";
        } else {
            _lineSpace = @"2";
        }
    }
    
    if ([_textContent isEqualToString:@""]) {
        _textContentAttri = [[NSMutableAttributedString alloc] initWithString:@""];
        _textWidth = 0.f;
        _textHeight = 0.f;
        _numberLines = 1;
        _textLineNum = 1;
        
        return;
    }
	
//	NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
//
//	defaultOption = (NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin);

	
    ParaStyle = [[NSMutableParagraphStyle alloc]init];
    ParaStyle.lineSpacing = [_lineSpace integerValue];
    ParaStyle.paragraphSpacing = [_workSpace integerValue];
    ParaStyle.alignment = _alignment;
    ParaStyle.headIndent = _headIndent;
    ParaStyle.firstLineHeadIndent = _firstLineHeadIndent;
	
	if (![StringValue(_lineHeightMultiple) isEqualToString:@""]) { // 设置有行高
		ParaStyle.lineHeightMultiple = [StringValue(_lineHeightMultiple) floatValue];//行高比例调整达到垂直居中
	}

	
    [self showNextProcess];
}

-(void)showNextProcess {
    
    NSInteger lines = [_lineNum integerValue];
    NSArray *contentLinesText = [self getLinesArrayOfStringWithContent:_textContent];
    _numberLines = contentLinesText.count;
    _textLineNum = contentLinesText.count;
    
    if (lines > 0) {
        // 设置了行数限制
        if (contentLinesText.count > lines) {
            // 内容过多处理
            NSString * strNeed = @"";
            for (NSInteger i = 0; i < lines; i++) {
                NSString * strOne = contentLinesText[i];
                if ([strNeed isEqualToString:@""]) {
                    strNeed = strOne;
                } else {
                    strNeed = [NSString stringWithFormat:@"%@%@",strNeed,strOne];
                }
            }
            
            if ([_overFlowText isEqualToString:@""]) {
                strNeed = strNeed;
            } else {
                strNeed = [NSString stringWithFormat:@"%@%@",strNeed,_overFlowText];
            }
            
            [self curViewLineNumberLimitToCalculateText:strNeed];//当前设置的行数的设置
            [self curViewToCalculateTextAll]; // 总的设置
            
        } else {
            [self curViewDefaultToCalculateText];
        }
    } else {
        [self curViewDefaultToCalculateText];
    }
}

#pragma mark - 有行数限制的计算
-(void)curViewLineNumberLimitToCalculateText:(NSString *)strConntent {
    
    NSInteger lines = [_lineNum integerValue];
    
    NSString * strLastContent = strConntent;
    if ([_overFlowText isEqualToString:@""]) {
        strLastContent = [NSString stringWithFormat:@"%@",[strLastContent substringToIndex:strConntent.length - 1]];
    } else {
		NSInteger num = strConntent.length - 1 - _overFlowText.length;
		if (num > 0) {
			strLastContent = [NSString stringWithFormat:@"%@%@",[strLastContent substringToIndex:num],_overFlowText];
		}
    }
    
    NSArray *contentLinesText = [self getLinesArrayOfStringWithContent:strLastContent];
    
    if (contentLinesText.count > lines && times < 50) {
        // 超过的行数
        times ++;
		
		NSInteger num = strConntent.length - 1 - _overFlowText.length;
		if (num > 0) {
			strLastContent = [NSString stringWithFormat:@"%@%@",[strConntent substringToIndex:strConntent.length-1-_overFlowText.length],_overFlowText];
			[self curViewLineNumberLimitToCalculateText:strLastContent];
		}
    } else {
        // 未超过行数
        NSMutableAttributedString * titleAttri002 = [[NSMutableAttributedString alloc] initWithString:strLastContent];
        [titleAttri002 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      ParaStyle, NSParagraphStyleAttributeName ,
                                      _font,NSFontAttributeName,
                                      _textColor,NSForegroundColorAttributeName,
                                      [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
                                      nil] range:NSMakeRange(0, [strLastContent length])];
        
        for (NSDictionary * dict in arrChange) {
            NSInteger arrStare = [dict[@"state"] integerValue];
            if (arrStare == 1) {
                NSInteger arrFrom = [dict[@"from"] integerValue];
                NSInteger arrTo = [dict[@"to"] integerValue];
                UIColor * colorChange = (UIColor *)dict[@"content"];
                if (strLastContent.length > arrFrom + arrTo-1) {
                    [titleAttri002 addAttribute:NSForegroundColorAttributeName value:colorChange range:NSMakeRange(arrFrom, arrTo)];
                }
            } else if (arrStare == 2) {
                NSInteger arrFrom = [dict[@"from"] integerValue];
                NSInteger arrTo = [dict[@"to"] integerValue];
                UIFont * fontChange = (UIFont *)dict[@"content"];
                if (fontChange == nil) {
                    fontChange = [UIFont systemFontOfSize:15.f];
                }
                if (strLastContent.length > arrFrom + arrTo -1) {
                    [titleAttri002 addAttribute:NSFontAttributeName value:fontChange range:NSMakeRange(arrFrom, arrTo)];
                }
            } else if (arrStare == 3) {
                NSInteger arrFrom = [dict[@"from"] integerValue];
                NSInteger arrTo = [dict[@"to"] integerValue];
                id value = (id)dict[@"content"];
                
                if (strLastContent.length > arrFrom + arrTo -1) {
                    [titleAttri002 addAttribute:NSUnderlineStyleAttributeName value:value range:NSMakeRange(arrFrom, arrTo)];
                }
            }
        }
		
        if (_overFlowText.length > 0) {
			
			if (_overFlowDownLine) { // 溢出的部分添加下划线
				[titleAttri002 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange((strLastContent.length - 2), 2)];
				[titleAttri002 addAttribute:NSForegroundColorAttributeName value:_overFlowTextColor range:NSMakeRange((strLastContent.length - 2), 2)];
				[titleAttri002 addAttribute:NSFontAttributeName value:_overFlowTextFont range:NSMakeRange((strLastContent.length - 2), 2)];
			} else {
				NSInteger startChange = strLastContent.length-_overFlowText.length;
				NSInteger endChange = _overFlowText.length;
				[titleAttri002 addAttribute:NSForegroundColorAttributeName value:_overFlowTextColor range:NSMakeRange(startChange, endChange)];
				[titleAttri002 addAttribute:NSFontAttributeName value:_overFlowTextFont range:NSMakeRange(startChange, endChange)];
			}
        }
		
		CGRect titleRect002 = [titleAttri002 boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
		
        _textContentAttri = titleAttri002;
        _textWidth = titleRect002.size.width;
        _textHeight = titleRect002.size.height;
    }
}

-(void)curViewToCalculateTextAll {
    
    NSMutableAttributedString * titleAttri000 = [[NSMutableAttributedString alloc] initWithString:_textContent];
    [titleAttri000 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  ParaStyle, NSParagraphStyleAttributeName ,
                                  _font,NSFontAttributeName,
                                  _textColor,NSForegroundColorAttributeName,
                                  [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
                                  nil] range:NSMakeRange(0, [_textContent length])];
	
	
	for (NSDictionary * dict in arrChange) {
        NSInteger arrStare = [dict[@"state"] integerValue];
        if (arrStare == 1) {
            NSInteger arrFrom = [dict[@"from"] integerValue];
            NSInteger arrTo = [dict[@"to"] integerValue];
            UIColor * colorChange = (UIColor *)dict[@"content"];
            if (_textContent.length > arrFrom + arrTo - 1) {
                [titleAttri000 addAttribute:NSForegroundColorAttributeName value:colorChange range:NSMakeRange(arrFrom, arrTo)];
            }
            
        } else if (arrStare == 2) {
            
            NSInteger arrFrom = [dict[@"from"] integerValue];
            NSInteger arrTo = [dict[@"to"] integerValue];
            UIFont * fontChange = (UIFont *)dict[@"content"];
            if (fontChange == nil) {
                fontChange = [UIFont systemFontOfSize:15.f];
            }
            if (_textContent.length > arrFrom + arrTo - 1) {
                [titleAttri000 addAttribute:NSFontAttributeName value:fontChange range:NSMakeRange(arrFrom, arrTo)];
            }
        } else if (arrStare == 3) {
            NSInteger arrFrom = [dict[@"from"] integerValue];
            NSInteger arrTo = [dict[@"to"] integerValue];
            id value = (id)dict[@"content"];
            
            if (_textContent.length > arrFrom + arrTo -1) {
                [titleAttri000 addAttribute:NSUnderlineStyleAttributeName value:value range:NSMakeRange(arrFrom, arrTo)];
            }
        }
    }
	
	CGRect titleRect000 = [titleAttri000 boundingRectWithSize:_size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    _textAllHeight = titleRect000.size.height;
    _textContentAttriAll = titleAttri000;
}

#pragma mark - 默认的计算
-(void)curViewDefaultToCalculateText {
    NSMutableAttributedString * titleAttri001 = [[NSMutableAttributedString alloc] initWithString:_textContent];
    
    [titleAttri001 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  ParaStyle, NSParagraphStyleAttributeName ,
                                  _font,NSFontAttributeName,
                                  _textColor,NSForegroundColorAttributeName,
                                  [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
                                  nil] range:NSMakeRange(0, [_textContent length])];
	
	
    for (NSDictionary * dict in arrChange) {
        NSInteger arrStare = [dict[@"state"] integerValue];
        if (arrStare == 1) {
            NSInteger arrFrom = [dict[@"from"] integerValue];
            NSInteger arrTo = [dict[@"to"] integerValue];
            UIColor * colorChange = (UIColor *)dict[@"content"];
            
            if (_textContent.length > arrFrom + arrTo - 1) {
                [titleAttri001 addAttribute:NSForegroundColorAttributeName value:colorChange range:NSMakeRange(arrFrom, arrTo)];
            }
        } else if (arrStare == 2) {
            
            NSInteger arrFrom = [dict[@"from"] integerValue];
            NSInteger arrTo = [dict[@"to"] integerValue];
            UIFont * fontChange = (UIFont *)dict[@"content"];
            if (fontChange == nil) {
                fontChange = [UIFont systemFontOfSize:15.f];
            }
            if (_textContent.length > arrFrom + arrTo - 1) {
                [titleAttri001 addAttribute:NSFontAttributeName value:fontChange range:NSMakeRange(arrFrom, arrTo)];
            }
        } else if (arrStare == 3) {
            NSInteger arrFrom = [dict[@"from"] integerValue];
            NSInteger arrTo = [dict[@"to"] integerValue];
            id value = (id)dict[@"content"];
            
            if (_textContent.length > arrFrom + arrTo -1) {
                [titleAttri001 addAttribute:NSUnderlineStyleAttributeName value:value range:NSMakeRange(arrFrom, arrTo)];
            }
        }
    }
	
	CGRect titleRect001 = [titleAttri001 boundingRectWithSize:_size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    _textContentAttri = titleAttri001;
    _textWidth = titleRect001.size.width;
    _textHeight = titleRect001.size.height;
    _textAllHeight = titleRect001.size.height;
} 


-(NSArray *)getLinesArrayOfStringWithContent:(NSString *)content
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];

    [attStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                           ParaStyle, NSParagraphStyleAttributeName ,
                           _font,NSFontAttributeName,
                           _textColor,NSForegroundColorAttributeName,
                           [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
                           nil] range:NSMakeRange(0, [content length])];

    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,_size.width,MAXFLOAT));

    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [content length]), path, NULL);

    //    CFArrayRef lines = CTFrameGetLines(frame);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];

    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);

        NSString *lineString = [content substringWithRange:range];
        [linesArray addObject:lineString];
    }
    CFRelease(frameSetter);
    CFRelease(frame);
    CGPathRelease(path);
    return (NSArray *)linesArray;
}



-(NSArray *)__getLinesArrayOfStringWithContent:(NSString *)content
{
	NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
	
	[attStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
						   ParaStyle, NSParagraphStyleAttributeName ,
						   _font,NSFontAttributeName,
						   _textColor,NSForegroundColorAttributeName,
						   [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
						   nil] range:NSMakeRange(0, [content length])];
	
	CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, CGRectMake(0,0,_size.width,MAXFLOAT));
	
	CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
	
	//    CFArrayRef lines = CTFrameGetLines(frame);
	NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
	NSMutableArray *linesArray = [[NSMutableArray alloc] init];
	
	for (id line in lines)
	{
		CTLineRef lineRef = (__bridge CTLineRef )line;
		CFRange lineRange = CTLineGetStringRange(lineRef);
		NSRange range = NSMakeRange(lineRange.location, lineRange.length);
		
		NSString *lineString = [content substringWithRange:range];
		[linesArray addObject:lineString];
	}
	
	CGPathRelease(path);
	CFRelease(frameSetter);
	CFRelease(frame);
	return (NSArray *)linesArray;
}


@end
