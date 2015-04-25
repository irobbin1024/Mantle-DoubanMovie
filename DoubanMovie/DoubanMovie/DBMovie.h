//
//  DBMovie.h
//  DoubanMovie
//
//  Created by itugo on 15/4/24.
//  Copyright (c) 2015年 itugo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import <UIKit/UIKit.h>



// MovieAttrs
@interface DBMovieAttrs: MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray * cast;
@property (nonatomic, strong) NSArray * country;
@property (nonatomic, strong) NSArray * director;
@property (nonatomic, strong) NSArray * language;
@property (nonatomic, strong) NSArray * movieDuration;
@property (nonatomic, strong) NSArray * movieType;
@property (nonatomic, strong) NSArray * pubdate;
@property (nonatomic, strong) NSArray * title;
@property (nonatomic, strong) NSArray * website;
@property (nonatomic, strong) NSArray * writer;
@property (nonatomic, strong) NSArray * year;

@end

// MovieAuthor
@interface DBMovieAuthor: MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * name;

@end

// MovieRating
@interface DBMovieRating: MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber * average;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, assign) NSInteger numRaters;

@end

// MovieTag
@interface DBMovieTag: MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString * name;

@end

// Main
@interface DBMovie: MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSURL * alt;
@property (nonatomic, strong) NSString * altTitle;
@property (nonatomic, strong) NSString * movieID;
@property (nonatomic, strong) NSURL * imageURL;
@property (nonatomic, strong) NSURL * mobileLinkURL;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * title;

// ==== MovieAttrs
@property (nonatomic, strong) DBMovieAttrs * attrs;
// ==== DBMovieAuthor
@property (nonatomic, strong) NSArray * authors;
// ==== MovieRating
@property (nonatomic, strong) DBMovieRating * rating;
// ==== MovieTag
@property (nonatomic, strong) NSArray * tags;



@end


