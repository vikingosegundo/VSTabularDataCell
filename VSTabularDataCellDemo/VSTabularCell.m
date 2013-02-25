//
//  GFFlexibleTabularCell.m
//  Gastrofix
//
//  Created by Manuel Meyer on 19.06.12.
//  Copyright (c) 2012 Gastrofix. All rights reserved.
//

#import "VSTabularCell.h"

@interface VSTabularCell ()
@property (nonatomic, strong) NSMutableDictionary *labelsForLines;

@end

@implementation VSTabularCell{
    BOOL isDirty;
}
@synthesize delegate = delagte_;
@synthesize indexPath = indexPath_;
@synthesize labelsForLines = labelsForLines_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        isDirty = YES;
        labelsForLines_ = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//-(void)setDelegate:(id<GFFlexibleTabularCellDeleate>)delegate
//{
//    delagte_ = delegate;
//}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    indexPath_ = indexPath;
    isDirty = YES;
    [self setNeedsLayout];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!isDirty)
        return;
    isDirty = NO;
    NSUInteger numberOfLines = [self.delegate numberOfLinesForCellAtIndexPath:self.indexPath];
    CGFloat yPosition = 0;
    for (int i = 0; i < numberOfLines; i++) {
        
        CGFloat lineHeight;
        
        if ([self.delegate respondsToSelector:@selector(heightOfLine:forCellAtIndexPath:)]) {
            lineHeight = [self.delegate heightOfLine:i forCellAtIndexPath: self.indexPath];
        } else {
            lineHeight = self.frame.size.height/ numberOfLines;
        }
        NSNumber *numberI = [NSNumber numberWithInt:i];
        CGFloat xPosition = 0.0;
        NSUInteger numberOfColumnsInLine = [self.delegate numberOfColumsForLine:i forCellAtIndexPath:self.indexPath];
        for (int j = 0; j < numberOfColumnsInLine; j++) {
            CGFloat columnWidth;
            if ([self.delegate respondsToSelector:@selector(widthOfColumn:ofLine:forCellAtIndexPath:)]) {
                columnWidth = [self.delegate widthOfColumn:j ofLine:i forCellAtIndexPath:self.indexPath];
            } else {
                columnWidth = self.frame.size.width / [self.delegate numberOfColumsForLine:i forCellAtIndexPath:self.indexPath];
            }
            
            NSString *text = nil;
            if ([self.delegate respondsToSelector:@selector(textForColumn:ofLine:forCellAtIndexPath:)]) {
                text = [self.delegate textForColumn:j ofLine:i forCellAtIndexPath:self.indexPath];
            }
            
           
            NSNumber *numberJ = [NSNumber numberWithInt:j];
            UILabel *label= nil;
            if ([self.labelsForLines objectForKey:numberI]) {
                if([[self.labelsForLines objectForKey:numberI] objectForKey:numberJ]){
                    label = [[self.labelsForLines objectForKey:numberI] objectForKey:numberJ];
                    //                        [label setFrame:CGRectMake( xPosition, yPosition ,columnWidth, lineHeight)];
                } 
            } else {
                [self.labelsForLines setObject:[NSMutableDictionary dictionary] forKey:numberI];

            }
            
            if(!label){
                label = [[UILabel alloc] initWithFrame:CGRectMake( xPosition, yPosition ,columnWidth, lineHeight)];
                NSMutableDictionary *labelsForLine = [[self labelsForLines] objectForKey:numberI];
                [labelsForLine setObject:label forKey:numberJ];
                
            }
            
            
            if ([self.delegate respondsToSelector:@selector(backgroundColorForColumn:ofLine:forCellAtIndexPath:)]) {
                UIColor *color;
                if ((color = [self.delegate backgroundColorForColumn:j ofLine:i forCellAtIndexPath:self.indexPath])) {
                    label.backgroundColor = color;
                }
                
            }
            
            label.text = text;
            [self.contentView addSubview:label];  
            xPosition += columnWidth;

            
            
            
        }
        yPosition += lineHeight;
    }
    
}

-(UIView *)viewForColumn:(NSUInteger)columnIdx forLine:(NSUInteger)lineIdx
{
    return [[self.labelsForLines objectForKey:[NSNumber numberWithInteger:lineIdx]] objectForKey:[NSNumber numberWithInteger:columnIdx]];
}

@end
