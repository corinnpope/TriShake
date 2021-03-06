//
//  TableHeaderView.m
//  TriShake


#import "TableHeaderView.h"

@interface TableHeaderView()
{
    UILabel* label;
}
@end

@implementation TableHeaderView

- (id)initWithText:(NSString*)text
{
    UIImage* img = [UIImage imageNamed:@"rss_icon.png"];
    if ((self = [super initWithImage:img])) {
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(20,10,200,30)];
        label.textColor = [UIColor blackColor];
        label.shadowColor = [UIColor grayColor];
        label.shadowOffset = CGSizeMake(1, 1);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = text;
        label.numberOfLines = 2;
        [self addSubview:label];
    }
    return self;
}

- (void)setText:(NSString*)text
{
    label.text = text;
}

@end
