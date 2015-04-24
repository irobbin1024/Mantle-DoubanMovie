//
//  DBMovie.m
//  DoubanMovie
//
//  Created by itugo on 15/4/24.
//  Copyright (c) 2015年 itugo. All rights reserved.
//

#import "DBMovie.h"

@implementation DBMovie

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"alt"            : @"",
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
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * ratingArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DBMovieRating * ratingItem = [MTLJSONAdapter modelOfClass:[DBMovieRating class] fromJSONDictionary:obj error:nil];
            [ratingArray addObject:ratingItem];
        }];
        
        return ratingArray;
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
