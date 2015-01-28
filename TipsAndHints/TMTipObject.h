//
//  EMHintObject.h
//  Hagtap
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ihor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TMTipObject : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign) BOOL shoudShow;
@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithName:(NSString *)tipName shouldShow:(BOOL)show andIndex:(NSInteger)index;
- (instancetype)initWithName:(NSString *)tipName andIndex:(NSInteger)index;
@end