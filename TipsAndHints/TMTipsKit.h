//
//  HintAndTipsKit.h
//  Hagtap
//
//  Created by Admin on 1/21/15.
//  Copyright (c) 2015 Ihor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TMTipsKit : NSObject
+ (instancetype)sharedInstance;
/**
 *  Inits Tipskit with tips names. Beware tips in array must be in the same  position as they are in Tip's views in xib file
 *
 *  @param names Tips names are NSString objects and must be in the same  position as they are in Tip's xib file
 *
 *  @warning Beware tips in array must be in the same  position as they are in Tip's xib file
 */
- (void)initWithTipsNames:(NSArray *)names;
/**
 *  sets all tips shouldShow property to YES
 */
- (void)resetTipsStatus;
/**
 *  Returns bool value depends on tips kit inited or not
 *
 *  @return YES if tips kit inited and NO if not
 */
- (BOOL)isTipsKitInited;

- (BOOL)shouldShowTipForItemWithName:(NSString *)name;
- (void)setshouldShowTip:(BOOL)show forItemWithName:(NSString *)name;
/**
 *  Show Tip with specific tip's name in specific view and with subviews styles
 *
 *  @see [initWithViewTag:style:andValue:]
 *
 *  @param tipName      Name of tip
 *  @param tipView      View where tip will be showed
 *  @param showOnlyOnce Should we show this tip only once
 *  @param styles       Subviews styles array of TMViewStyle objects
 */
- (void)showTipWithName:(NSString *)tipName forView:(UIView *)tipView showOnlyOnce:(BOOL)showOnlyOnce andApplyToSubViewsStyles:(NSArray *)styles;
/**
 *  Show Tip with specific tip's name in specific view
 *
 *  @param tipName Name of tip
 *  @param tipView View where tip will be showed
 */
- (void)showTipWithName:(NSString *)tipName forView:(UIView *)tipView;
/**
 *  Show Tip with specific tip's name
 *
 *  @param tipName Name of tip
 */
- (void)showTipWithName:(NSString *)tipName;

@end

//View style
/**
 Style types
 */
typedef enum {
    TMViewStyleTypeBackgroundColor,
    TMViewStyleTypeText,
    TMViewStyleTypeCornerRadius
} TMViewStyleType;

@interface TMViewStyle : NSObject
@property (nonatomic, assign, readonly) NSInteger viewTag;
@property (nonatomic, assign, readonly) TMViewStyleType viewStyleType;
@property (nonatomic, strong, readonly) id styleValue; //string for text,UIColor for color,NSNumber for corner radius
/**
 *  Inits style that will be applied to the subview with specific tag. This tag should be setted in xib file
 *
 *  @param tag   Tag of the subview
 *  @param type  Type of style can be one of TMViewStyleType
 *  @param value Value of style and depends on type: TMViewStyleTypeBackgroundColor - UICoLor, TMViewStyleTypeText - NSString,TMViewStyleTypeCornerRadius - NSNumber
 *
 *  @return TMViewStyle that can be applied to UIView's subview with specific tag
 */
- (instancetype)initWithViewTag:(NSInteger)tag style:(TMViewStyleType)type andValue:(id)value;
@end

@interface UIView (ViewStyles)
/**
 *  Applies to specific subview style
 *
 *  @param viewStyle Style that get subview by tag.
 */
- (void)applyStyleToSubview:(TMViewStyle *)viewStyle;
@end