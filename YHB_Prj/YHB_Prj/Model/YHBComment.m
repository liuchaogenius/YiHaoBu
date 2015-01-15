//
//  YHBComment.m
//
//  Created by   on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBComment.h"


NSString *const kYHBCommentAvatar = @"avatar";
NSString *const kYHBCommentAddtime = @"addtime";
NSString *const kYHBCommentUserid = @"userid";
NSString *const kYHBCommentAdddate = @"adddate";
NSString *const kYHBCommentTruename = @"truename";
NSString *const kYHBCommentItemid = @"itemid";
NSString *const kYHBCommentComment = @"comment";


@interface YHBComment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBComment

@synthesize avatar = _avatar;
@synthesize addtime = _addtime;
@synthesize userid = _userid;
@synthesize adddate = _adddate;
@synthesize truename = _truename;
@synthesize itemid = _itemid;
@synthesize comment = _comment;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.avatar = [self objectOrNilForKey:kYHBCommentAvatar fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kYHBCommentAddtime fromDictionary:dict];
            self.userid = [[self objectOrNilForKey:kYHBCommentUserid fromDictionary:dict] doubleValue];
            self.adddate = [self objectOrNilForKey:kYHBCommentAdddate fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBCommentTruename fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBCommentItemid fromDictionary:dict] doubleValue];
            self.comment = [self objectOrNilForKey:kYHBCommentComment fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.avatar forKey:kYHBCommentAvatar];
    [mutableDict setValue:self.addtime forKey:kYHBCommentAddtime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBCommentUserid];
    [mutableDict setValue:self.adddate forKey:kYHBCommentAdddate];
    [mutableDict setValue:self.truename forKey:kYHBCommentTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBCommentItemid];
    [mutableDict setValue:self.comment forKey:kYHBCommentComment];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.avatar = [aDecoder decodeObjectForKey:kYHBCommentAvatar];
    self.addtime = [aDecoder decodeObjectForKey:kYHBCommentAddtime];
    self.userid = [aDecoder decodeDoubleForKey:kYHBCommentUserid];
    self.adddate = [aDecoder decodeObjectForKey:kYHBCommentAdddate];
    self.truename = [aDecoder decodeObjectForKey:kYHBCommentTruename];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBCommentItemid];
    self.comment = [aDecoder decodeObjectForKey:kYHBCommentComment];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_avatar forKey:kYHBCommentAvatar];
    [aCoder encodeObject:_addtime forKey:kYHBCommentAddtime];
    [aCoder encodeDouble:_userid forKey:kYHBCommentUserid];
    [aCoder encodeObject:_adddate forKey:kYHBCommentAdddate];
    [aCoder encodeObject:_truename forKey:kYHBCommentTruename];
    [aCoder encodeDouble:_itemid forKey:kYHBCommentItemid];
    [aCoder encodeObject:_comment forKey:kYHBCommentComment];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBComment *copy = [[YHBComment alloc] init];
    
    if (copy) {

        copy.avatar = [self.avatar copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.userid = self.userid;
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.comment = [self.comment copyWithZone:zone];
    }
    
    return copy;
}


@end
