## Mantle的使用

##要实现的功能

我要举得例子来自豆瓣电影，根据某电影ID从豆瓣上把数据抓取出来，通过Mantle格式化为我们需要的Model。

豆瓣电影获取到后是一串JSON，类似下面：

```json
{
	"alt": "http://movie.douban.com/movie/4212172",
	"alt_title": "12生肖",
	"attrs": {
		"cast": [
			"成龙 Jackie Chan",
			"权相宇 Sang-woo Kwone",
			"廖凡 Fan Liao",
			"姚星彤 Xingtong Yao",
			"张蓝心 Lanxin Zhang",
			"白露娜 Laura Weissbecker",
			"刘承俊 Sung-jun Yoo",
			"吴彦祖 Daniel Wu",
			"舒淇 Qi Shu",
			"李宗盛 Jonathan Lee",
			"陈柏霖 Bo-lin Chen",
			"卢惠光 Ken Lo",
			"浅野长英",
			"白冰 Bing Bai",
			"林鹏 Peng Lin"
		],
		"country": [
			"中国大陆",
			"香港"
		],
		"director": [
			"成龙 Jackie Chan"
		],
		"language": [
			"英语",
			"汉语普通话",
			"粤语",
			"法语",
			"西班牙语"
		],
		"movie_duration": [
			"122分钟"
		],
		"movie_type": [
			"喜剧",
			"动作",
			"冒险"
		],
		"pubdate": [
			"2012-12-12(香港国际电影节)",
			"2012-12-20(中国大陆/香港)"
		],
		"title": [
			"十二生肖"
		],
		"website": [
			"hbpictures.ayomovie.com/12shengxiao"
		],
		"writer": [
			"成龙 Jackie Chan",
			"唐季礼 Stanley Tong",
			"邓景生 Edward Tang",
			"陈勋奇 Frankie Chan"
		],
		"year": [
			"2012"
		]
	},
	"author": [
		{
			"name": "成龙 Jackie Chan"
		}
	],
	"id": "http://api.douban.com/movie/4212172",
	"image": "http://img3.douban.com/view/movie_poster_cover/ipst/public/p1826580562.jpg",
	"mobile_link": "http://m.douban.com/movie/subject/4212172/",
	"rating": {
		"average": "6.7",
		"max": 10,
		"min": 0,
		"numRaters": 159114
	},
	"summary": "当年英法联军火烧圆明园，致使大批珍贵文物流落海外，其中四尊十二生肖兽首最引人关注，不仅惹出国内外的广泛争论，更有收藏家开出天价竞拍这几尊珍品。当然，其间不乏奸邪的文物贩子，试图通过偷盗的手段获取宝贝。以此为契机，正在度假的国际大盗JC（成龙 饰）隆重登场。JC背后有一支 Simon（权相宇 饰）、David（廖凡 饰）、Bonnie（张蓝心 饰）等人共同组成的超专业团队，他们一同远赴巴黎，寻求国宝鉴定专家Coco（姚星彤 饰）的帮助。经过周密细致的准备，JC等人一步步逼近重兵把守的兽首，而围绕珍宝不可避免爆发连番惊险火爆的打斗与追逐。
在这一过程中，JC似曾被利益和金钱泯灭的爱国之心渐渐苏醒……",
	"tags": [
		{
			"count": 34460,
			"name": "动作"
		},
		{
			"count": 22094,
			"name": "喜剧"
		},
		{
			"count": 14424,
			"name": "香港"
		},
		{
			"count": 9839,
			"name": "冒险"
		},
		{
			"count": 8222,
			"name": "2012"
		},
		{
			"count": 7660,
			"name": "搞笑"
		},
		{
			"count": 3214,
			"name": "3D"
		},
		{
			"count": 2524,
			"name": "中国大陆"
		}
	],
	"title": "十二生肖"
}

```objc

这个JSON数据可以说是非常复杂的，考虑到了各种情况。数值部分有整数、浮点数、字符串。JSON里面还嵌套有多个Dictionary和Array。

我们要转换的Model定义如下：

```
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
```

观察`DBMovie`中的`imageURL`属性，是一个`NSURL`对象。这边有点奇怪，JSON中是不包含特殊数据类型的啊。JSON里面确实没有`NSURL`，但是我们实际使用的时候肯定是用`NSURL`，所以为了方便起见，我们会在Model化的时候进行一个转换。而且，通过Mantle这个强大的工具，我们可以很方便的进行这个工作。

`MovieAttrs`、`DBMovieAuthor`、`MovieRating`、`MovieTag`都是类对象，都是通过对二级JSON对象的转换得到的。转换方法同`NSURL`类似。

##核心类

Mantle的核心类有3个：

* MTLModel
* MTLJSONAdapter
* MTLJSONSerializing

### MTLModel
`MTLModel`是所有Model的父类，提供了一些默认的行为来处理对象的初始化和归档操作，同时可以获取到对象所有属性的键值集合

### MTLJSONAdapter
用于在MTLModel对象和JSON字典之间进行相互转换，相当于是一个适配器

### MTLJSONSerializing
需要与JSON字典进行相互转换的MTLModel的子类都需要实现该协议，以方便MTLJSONApadter对象进行转换

## 实现DBMovie

1 首先根据JSON数据定义写好头文件中的property.

```objc
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
```
2 写好Model字段同JSON字段的映射

```objc
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
```

3 写好特殊字段的处理方法回调函数
回调方法是根据特殊字段名称来命名的，例如imageURL这个字段，它的函数名为：`imageURLJSONTransformer`

```objc
+ (NSValueTransformer *)imageURLJSONTransformer {
    return [MTLValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
```

上面的例子使用了内置的转换功能`MTLURLValueTransformerName`，实际上还有一个内置的转换功能`MTLBooleanValueTransformerName`。

除此之外，如果你要转换一个你自己写的类，那么就应该是用自定义转换，比如我们要转换attrs，它在Model中被映射为`DBMovieAttrs`类型。

```objc
+ (NSValueTransformer *)attrsJSONTransformer {

    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {

        DBMovieAttrs * attrsModel = [MTLJSONAdapter modelOfClass:[DBMovieAttrs class] fromJSONDictionary:value error:nil];

        return attrsModel;
    }];
}
```

使用Mantle内置的转换函数`+ (instancetype)transformerUsingForwardBlock:(MTLValueTransformerBlock)transformation`

回调中的value是传递过来的值，一般是一个Dictionary或者Array。返回一个对象，在这边是`DBMovieAttrs`的对象

4 写好JSON 中`null`值字段的处理方法回调
在JSON中，如果一个字段没有值，那么值是`null`，我们在程序中需要特殊处理它，幸运的是Mantle已经为我们考虑好了。你只需要添加一个处理回调函数，即可万无一失。

```objc
- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];  // For NSInteger/CGFloat/BOOL
}
```

你可以根据key来设置不同的默认值。非常方便。

## 写在后面
具体的实现代码可以到这边查看
[https://github.com/irobbin1024/Mantle-DoubanMovie](https://github.com/irobbin1024/Mantle-DoubanMovie)