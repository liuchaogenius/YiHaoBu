//
//  YHBComment.m
//
//  Created by   on 15/1/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBComment.h"


NSString *const kYHBCommentAddtime = @"addtime";
NSString *const kYHBCommentAvatar = @"avatar";
NSString *const kYHBCommentUserid = @"userid";
NSString *const kYHBCommentComment = @"comment";
NSString *const kYHBCommentTruename = @"truename";
NSString *const kYHBCommentItemid = @"itemid";
NSString *const kYHBCommentAdddate = @"adddate";


@interface YHBComment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBComment

@synthesize addtime = _addtime;
@synthesize avatar = _avatar;
@synthesize userid = _userid;
@synthesize comment = _comment;
@synthesize truename = _truename;
@synthesize itemid = _itemid;
@synthesize adddate = _adddate;


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
            self.addtime = [self objectOrNilForKey:kYHBCommentAddtime fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kYHBCommentAvatar fromDictionary:dict];
            self.userid = [[self objectOrNilForKey:kYHBCommentUserid fromDictionary:dict] doubleValue];
            self.comment = [self objectOrNilForKey:kYHBCommentComment fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBCommentTruename fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBCommentItemid fromDictionary:dict] doubleValue];
            self.adddate = [self objectOrNilForKey:kYHBCommentAdddate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addtime forKey:kYHBCommentAddtime];
    [mutableDict setValue:self.avatar forKey:kYHBCommentAvatar];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBCommentUserid];
    [mutableDict setValue:self.comment forKey:kYHBCommentComment];
    [mutableDict setValue:self.truename forKey:kYHBCommentTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBCommentItemid];
    [mutableDict setValue:self.adddate forKey:kYHBCommentAdddate];
    
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

    self.addtime = [aDecoder decodeObjectForKey:kYHBCommentAddtime];
    self.avatar = [aDecoder decodeObjectForKey:kYHBCommentAvatar];
    self.userid = [aDecoder decodeDoubleForKey:kYHBCommentUserid];
    self.comment = [aDecoder decodeObjectForKey:kYHBCommentComment];
    self.truename = [aDecoder decodeObjectForKey:kYHBCommentTruename];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBCommentItemid];
    self.adddate = [aDecoder decodeObjectForKey:kYHBCommentAdddate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addtime forKey:kYHBCommentAddtime];
    [aCoder encodeObject:_avatar forKey:kYHBCommentAvatar];
    [aCoder encodeDouble:_userid forKey:kYHBCommentUserid];
    [aCoder encodeObject:_comment forKey:kYHBCommentComment];
    [aCoder encodeObject:_truename forKey:kYHBCommentTruename];
    [aCoder encodeDouble:_itemid forKey:kYHBCommentItemid];
    [aCoder encodeObject:_adddate forKey:kYHBCommentAdddate];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBComment *copy = [[YHBComment alloc] init];
    
    if (copy) {

        copy.addtime = [self.addtime copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.userid = self.userid;
        copy.comment = [self.comment copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.adddate = [self.adddate copyWithZone:zone];
    }
    
    return copy;
}


@end
