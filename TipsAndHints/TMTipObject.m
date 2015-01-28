//
//  EMHintObject.m
//  Hagtap
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ihor. All rights reserved.
//

#import "TMTipObject.h"

@implementation TMTipObject
- (instancetype)initWithName:(NSString *)tipName shouldShow:(BOOL)show andIndex:(NSInteger)index {
    self = [super init];
    if (self)
    {
        _name = tipName;
        _shoudShow = show;
        _index = index;
    }
    return self;
}
- (instancetype)initWithName:(NSString *)tipName andIndex:(NSInteger)index {
    return [self initWithName:tipName shouldShow:YES andIndex:index];
}
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init]))
    {
        //decode properties, other class vars
        _name = [decoder decodeObjectForKey:@"name"];
        _shoudShow = [[decoder decodeObjectForKey:@"shoudShow"] boolValue];
        _index = [[decoder decodeObjectForKey:@"index"] integerValue];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:[NSNumber numberWithBool:_shoudShow] forKey:@"shoudShow"];
    [encoder encodeObject:[NSNumber numberWithInteger:_index] forKey:@"index"];
}
@end