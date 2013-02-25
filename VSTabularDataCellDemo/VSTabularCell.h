//
//  GFFlexibleTabularCell.h
//  Gastrofix
//
//  Created by Manuel Meyer on 19.06.12.
//

#import <UIKit/UIKit.h>

@class VSTabularCell;

@protocol VSTabularCellDelegate <NSObject>
-(NSUInteger)numberOfLinesForCellAtIndexPath: (NSIndexPath *) indexPath;
-(NSUInteger)numberOfColumsForLine:(NSUInteger)number forCellAtIndexPath: (NSIndexPath*) indexPath;

@optional
-(CGFloat)heightOfLine:(NSUInteger)lineIdx forCellAtIndexPath: (NSIndexPath*) indexPath;
-(CGFloat)widthOfColumn:(NSUInteger)columnIdx ofLine:(NSUInteger)lineIdx forCellAtIndexPath: (NSIndexPath *) indexPath;
-(void)viewForColumn:(NSUInteger)columnIdx ofLine:(NSUInteger)lineIdx forCellAtIndexPath: (NSIndexPath *) indexPath;
-(NSString *)textForColumn:(NSUInteger)columnIdx ofLine:(NSUInteger)lineIdx forCellAtIndexPath: (NSIndexPath *) indexPath;
-(UIColor *)backgroundColorForColumn:(NSUInteger)columnIdx ofLine:(NSUInteger)lineIdx forCellAtIndexPath: (NSIndexPath *) indexPath;

@end


@interface VSTabularCell : UITableViewCell
@property (nonatomic,assign) id<VSTabularCellDelegate> delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;

-(UIView *)viewForColumn:(NSUInteger)columnIdx forLine:(NSUInteger)lineIdx;

@end
