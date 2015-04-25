//
//  DBMovie.m
//  DoubanMovie
//
//  Created by itugo on 15/4/24.
//  Copyright (c) 2015年 itugo. All rights reserved.
//

#import "DBMovie.h"

#pragma mark - DBMovie
@implementation DBMovie

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"alt"            : @"alt",
              @"altTitle"       : @"alt_title",
              @"movieID"        : @"id",
              @"imageURL"       : @"image",
              @"mobileLinkURL"  : @"mobile_link",
              @"summary"        : @"summary",
              @"title"          : @"title",
              @"attrs"          : @"attrs",
              @"authors"        : @"author",
              @"rating"         : @"rating",
              @"tags"           : @"tags",
              };
}

+ (NSValueTransformer *)altJSONTransformer {
    return [MTLValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [MTLValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


+ (NSValueTransformer *)mobileLinkURLJSONTransformer {
    return [MTLValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

// class transformer
+ (NSValueTransformer *)attrsJSONTransformer {

    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {

        DBMovieAttrs * attrsModel = [MTLJSONAdapter modelOfClass:[DBMovieAttrs class] fromJSONDictionary:value error:nil];

        return attrsModel;
    }];
}

+ (NSValueTransformer *)authorsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * authorsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DBMovieAuthor * authorItem = [MTLJSONAdapter modelOfClass:[DBMovieAuthor class] fromJSONDictionary:obj error:nil];
            [authorsArray addObject:authorItem];
        }];
        
        return authorsArray;
    }];
}

+ (NSValueTransformer *)ratingJSONTransformer {
    __block NSError * e;
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        DBMovieRating * ratingItem = [MTLJSONAdapter modelOfClass:[DBMovieRating class] fromJSONDictionary:value error:&e];
        
        return ratingItem;
    }];
}

+ (NSValueTransformer *)tagsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DBMovieTag * tagItem = [MTLJSONAdapter modelOfClass:[DBMovieTag class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

#pragma mark DBMovieTag

@implementation DBMovieTag

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"count" : @"count",
             @"name"  : @"name"};
}

@end

#pragma mark DBMovieRating

@implementation DBMovieRating

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"numRaters" : @"numRaters",
             @"average" : @"average",
             @"min" : @"min",
             @"max" : @"max",
             };
}

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];
}

@end

#pragma mark DBMovieAuthor

@implementation DBMovieAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name" : @"name"};
}

@end

#pragma mark DBMovieAttrs

@implementation DBMovieAttrs

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieDuration" : @"movie_duration",
             @"country" : @"country",
             @"cast" : @"cast",
             @"director" : @"director",
             @"language" : @"language",
             @"movieType" : @"movie_type",
             @"pubdate" : @"pubdate",
             @"title" : @"title",
             @"website" : @"website",
             @"writer" : @"writer",
             @"year" : @"year",
             };
}

+ (NSValueTransformer *)JSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * attrArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [attrArray addObject:obj];
        }];
        
        return attrArray;
    }];
}

@end
