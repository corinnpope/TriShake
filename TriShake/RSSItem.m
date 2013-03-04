//
//  RSSItem.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSItem.h"
#import "GTMNSString+HTML.h"

@implementation RSSItem

-(NSAttributedString*)cellMessage
{
    if (_cellMessage!=nil) return _cellMessage;
    
    NSDictionary* boldStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]};
    
    NSMutableAttributedString* articleAbstract = [[NSMutableAttributedString alloc] initWithString:self.title];
    
    [articleAbstract setAttributes:boldStyle
                             range:NSMakeRange(0, self.title.length)];
    
    [articleAbstract appendAttributedString:
     [[NSAttributedString alloc] initWithString:@"\n\n"]
     ];

    _cellMessage = articleAbstract;
    return _cellMessage;
    
}

@end
