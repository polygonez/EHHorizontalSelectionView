//
//  EHHorizontalViewCell.m
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import "EHHorizontalViewCell.h"

@implementation EHHorizontalViewCell



- (void)awakeFromNib {
    [self createSelectedView];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [[self class] loadStyles];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[self class] loadStyles];
        
        UILabel * l = [[UILabel alloc] init];
        [self addSubview:l];
        self.titleLabel = l;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        UIView * sView = [[UIView alloc] init];
        [self addSubview:sView];
        self.selectedView = sView;
        self.selectedView.backgroundColor = [UIColor clearColor];
        
        UIView * colView = [[UIView alloc] init];
        [self.selectedView addSubview:colView];
        self.coloredView = colView;
        self.coloredView.backgroundColor = [[self class] tintColor];
        
        [self createSelectedView];
        
        [self insertSubview:self.selectedView belowSubview:self.titleLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [[self class] loadStyles];
    }
    return self;
}

+ (void)loadStyles
{
    @synchronized (_EHHorisontalSelectionStyles) {
        
        if (_EHHorisontalSelectionStyles == nil)
        {
            _EHHorisontalSelectionStyles = [[NSMutableDictionary alloc] init];
        }
        if ([_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] == nil)
        {
            [_EHHorisontalSelectionStyles setObject:[[self class] styles] forKey:[[self class] reuseIdentifier]];
        }
    }
}

+ (NSMutableDictionary *)styles
{
    return [@{ @"tintColor" : [UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1],
              @"font" : [UIFont fontWithName:@"HelveticaNeue" size:18.0],
              @"fontMedium" : [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0],
              @"cellGap" : @(_EHDefaultGap * 4),
              @"needCentred" : @(YES)
              } mutableCopy];
}

+ (void)checkStyles
{
    if ([_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] == nil)
    {
        [[self class] loadStyles];
    }
}


+ (NSString * _Nonnull)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (BOOL)useDynamicSize
{
    return YES;
}


+ (void)updateTintColor:(UIColor *)color
{
    [[self class] checkStyles];
    
    [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] setObject:color forKey:@"tintColor"];
}

+ (void)updateFont:(UIFont *)font
{
    [[self class] checkStyles];
    
    [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] setObject:font forKey:@"font"];
}

+ (void)updateFontMedium:(UIFont *)font
{
    [[self class] checkStyles];
    
    [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] setObject:font forKey:@"fontMedium"];
}

+ (void)updateCellGap:(float)gap
{
    [[self class] checkStyles];
    
    [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] setObject:@(gap) forKey:@"cellGap"];
}

+ (void)updateNeedCentered:(BOOL)needCentered
{
    [[self class] checkStyles];
    
    [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] setObject:@(needCentered) forKey:@"needCentered"];
}

+ (UIColor *)tintColor
{
    [[self class] checkStyles];
    
    return [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] objectForKey:@"tintColor"];
}

+ (UIFont *)font
{
    [[self class] checkStyles];
    
    return [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] objectForKey:@"font"];
}

+ (UIFont *)fontMedium
{
    [[self class] checkStyles];
    
    return [[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] objectForKey:@"fontMedium"];
}

+ (float)cellGap
{
    [[self class] checkStyles];
    
    return [[[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] objectForKey:@"cellGap"] floatValue];
}

+ (BOOL)needCentred
{
    [[self class] checkStyles];
    
    return [[[_EHHorisontalSelectionStyles objectForKey:[[self class] reuseIdentifier]] objectForKey:@"needCentred"] boolValue];
}



- (void)setSelectedCell:(BOOL)selected fromCellRect:(CGRect)rect
{
    if (selected)
    {
        self.selectedView.hidden = NO;
        
        [UIView animateWithDuration:!CGRectIsNull(rect) ? 0.3 : 0.0 animations:^{
            self.titleLabel.font = [[self class] fontMedium];
            self.titleLabel.alpha = 1.0;
        }];
        
    }
    else
    {
        self.selectedView.hidden = YES;
        [UIView animateWithDuration:!CGRectIsNull(rect) ? 0.3 : 0.0 animations:^{
            self.titleLabel.font = [[self class] font];
            self.titleLabel.alpha = .5;
        }];
        
    }
}

- (UIView *)createSelectedView
{
    return self.selectedView;
}

- (void)highlight:(BOOL)highlighted
{
    self.titleLabel.alpha = highlighted ? 0.3 : 0.5;
}

- (void)setTitleLabelText:(NSString *)text
{
    self.titleLabel.text = text;
}

- (void)setSelectedCell:(BOOL)selected
{
    [self setSelectedCell:selected fromCellRect:CGRectNull];
}

@end
