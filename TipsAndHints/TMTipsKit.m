//
//  HintAndTipsKit.m
//  Hagtap
//
//  Created by Admin on 1/21/15.
//  Copyright (c) 2015 Ihor. All rights reserved.
//

#import "TMTipsKit.h"

#import "TMTipObject.h"
#import <QuartzCore/QuartzCore.h>

#define TipsItemInDefaults @"TipsAndHints"
#define TipsViewsXibName @"TipsViews"

@interface TMTipsKit ()
{}
@end

@implementation TMTipsKit
- (instancetype)init {
    self = [super init];
    if (self)
    {}
    return self;
}
+ (instancetype)sharedInstance {
    static TMTipsKit *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TMTipsKit alloc] init];
    });
    return _sharedInstance;
}
- (void)initWithTipsNames:(NSArray *)names {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:TipsItemInDefaults])
    {
        NSLog(@"Warning!\nTips objects are alredy inited\nYou should init tip objects only once.");
        return;
    }
    
    NSMutableDictionary *toolTipDictionary = [@{} mutableCopy];
    for (NSInteger index = 0; index < names.count; ++index) {
        NSString *name = [names objectAtIndex:index];
        TMTipObject *newTipObject = [[TMTipObject alloc]initWithName:name andIndex:index];
        [self addTipObject:newTipObject toDictionary:toolTipDictionary forName:name];
    }
    [defaults setObject:toolTipDictionary forKey:TipsItemInDefaults];
    [defaults synchronize];
}
- (void)addTipObject:(TMTipObject *)emHintObject toDictionary:(NSMutableDictionary *)toolTipDictionary forName:(NSString *)name {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:emHintObject];
    [toolTipDictionary setObject:encodedObject forKey:name];
}
- (void)resetTipsStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *toolTipDictionary = [[defaults objectForKey:TipsItemInDefaults] mutableCopy];
    NSArray *tipNames = toolTipDictionary.allKeys;
    for(NSString *tipName in tipNames)
    {
        TMTipObject *tipObject = (TMTipObject *)[NSKeyedUnarchiver unarchiveObjectWithData:[toolTipDictionary objectForKey:tipName]]
        ;
        tipObject.shoudShow = YES;
        [self addTipObject:tipObject toDictionary:toolTipDictionary forName:tipName];
    }
    [defaults setObject:toolTipDictionary forKey:TipsItemInDefaults];
    [defaults synchronize];
}
- (BOOL)isTipsKitInited
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:TipsItemInDefaults] != nil;
}
- (BOOL)shouldShowTipForItemWithName:(NSString *)name {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *toolTipDictionary = [defaults objectForKey:TipsItemInDefaults];
    if ([toolTipDictionary objectForKey:name])
    {
        TMTipObject *tipObject = (TMTipObject *)[NSKeyedUnarchiver unarchiveObjectWithData:[toolTipDictionary objectForKey:name]]
        ;
        return tipObject.shoudShow;
    }
    return NO;
}
- (void)setshouldShowTip:(BOOL)show forItemWithName:(NSString *)name {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *toolTipDictionary = [[defaults objectForKey:TipsItemInDefaults] mutableCopy];
    if ([toolTipDictionary objectForKey:name])
    {
        TMTipObject *tipObject = (TMTipObject *)[NSKeyedUnarchiver unarchiveObjectWithData:[toolTipDictionary objectForKey:name]];
        
        tipObject.shoudShow = show;
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:tipObject];
        [toolTipDictionary setObject:encodedObject forKey:name];
        [defaults setObject:toolTipDictionary forKey:TipsItemInDefaults];
        [defaults synchronize];
    }
}
- (void)showTipWithName:(NSString *)tipName forView:(UIView *)tipView showOnlyOnce:(BOOL)showOnlyOnce andApplyToSubViewsStyles:(NSArray *)styles;

{
    if (tipView == nil || tipName.length == 0)
    {
        NSLog(@"Error showing tip");
        return;
    }
    
    if ([self shouldShowTipForItemWithName:tipName])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *toolTipDictionary = [defaults objectForKey:TipsItemInDefaults];
        TMTipObject *tipObject = (TMTipObject *)[NSKeyedUnarchiver unarchiveObjectWithData:[toolTipDictionary objectForKey:tipName]];
        //calculate text hint position
        CGRect viewsFrame;
        viewsFrame.origin =  [tipView.superview convertPoint:tipView.frame.origin toView:nil];
        viewsFrame.size = tipView.frame.size;
        
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *path = [mainBundle pathForResource:TipsViewsXibName ofType:@"nib"]; // file is called crapXib.xib
        
        NSAssert(path.length != 0, @"Error showing tip!\n Did you foget add to project file %@.xib,\nwhere tips view are contained?", TipsViewsXibName);
        
        NSArray *viewsArray = [mainBundle loadNibNamed:TipsViewsXibName owner:self options:nil];
        NSAssert(tipObject.index <= viewsArray.count, @"Error showing tip!\n Did you foget add tip's view to %@.xib,\nwhere tips view are contained?", TipsViewsXibName);
        
        UIView *rootView = [viewsArray objectAtIndex:tipObject.index];
        
        [rootView setFrame:tipView.bounds];
        
        for (TMViewStyle *style in styles) {
            [rootView applyStyleToSubview:style];
        }
        
        [tipView addSubview:rootView];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [rootView addGestureRecognizer:singleFingerTap];
    }
    
    
    if (showOnlyOnce)
    {
        [[TMTipsKit sharedInstance] setshouldShowTip:NO forItemWithName:tipName];
    }
}
- (void)showTipWithName:(NSString *)tipName {
    [self showTipWithName:tipName forView:[[UIApplication sharedApplication].delegate window]];
}
- (void)showTipWithName:(NSString *)tipName forView:(UIView *)tipView {
    [self showTipWithName:tipName forView:tipView showOnlyOnce:YES andApplyToSubViewsStyles:@[]];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [recognizer.view removeFromSuperview];
}
@end



@implementation TMViewStyle

- (instancetype)initWithViewTag:(NSInteger)tag style:(TMViewStyleType)type andValue:(id)value {
    self = [super init];
    if (self)
    {
        _viewTag = tag;
        _viewStyleType = type;
        _styleValue = nil;
        switch (_viewStyleType) {
            case TMViewStyleTypeBackgroundColor:
            {
                if ([value isKindOfClass:[UIColor class]])
                {
                    _styleValue = value;
                }
            }
                break;
                
            case TMViewStyleTypeText:
            {
                if ([value isKindOfClass:[NSString class]])
                {
                    _styleValue = value;
                }
            }
                break;
                
            case TMViewStyleTypeCornerRadius:
            {
                if ([value isKindOfClass:[NSNumber class]])
                {
                    _styleValue = value;
                }
            }
                break;
                
            default:
                _styleValue = nil;
                break;
        }
    }
    return self;
}
@end

@implementation UIView (ViewStyles)

- (void)applyStyleToSubview:(TMViewStyle *)viewStyle {
    if (viewStyle.styleValue == nil)
    {
        NSLog(@"Can't apply nil value");
        return;
    }
    UIView *subview = [self viewWithTag:viewStyle.viewTag];
    if (subview == nil)
    {
        NSLog(@"Can't apply style to nil view");
        return;
    }
    
    
    switch (viewStyle.viewStyleType) {
        case TMViewStyleTypeBackgroundColor:
        {
            [subview setBackgroundColor:viewStyle.styleValue];
        }
            break;
            
        case TMViewStyleTypeText:
        {
            if ([subview respondsToSelector:@selector(setText:)])
            {
                [((UILabel *)subview)setText:viewStyle.styleValue];
            }
            else {
                NSLog(@"Can't set text:%@\nTo view:%@", viewStyle.styleValue, subview);
            }
        }
            break;
            
        case TMViewStyleTypeCornerRadius:
        {
            subview.layer.cornerRadius = [viewStyle.styleValue floatValue];
            subview.clipsToBounds = YES;
        }
            break;
    }
}
@end