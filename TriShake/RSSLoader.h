//
//  RSSLoader.h
//  TriShake
//
//  Created by Corinn Pope on 2/28/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void (^RSSLoaderCompleteBlock)(NSString* title, NSArray* results);

@interface RSSLoader : NSObject

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c;

@end

