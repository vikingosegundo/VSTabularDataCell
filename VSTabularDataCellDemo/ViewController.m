//
//  ViewController.m
//  VSTabularDataCellDemo
//
//  Created by Manuel Meyer on 21.06.12.
//  Copyright (c) 2012 Pepe. All rights reserved.
//

#import "ViewController.h"
#import "VSTabularCell.h"

@interface ViewController ()<VSTabularCellDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    VSTabularCell *cell = (VSTabularCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[VSTabularCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.delegate = self;        
    }  
        
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    VSTabularCell *c = (VSTabularCell *)cell;
    c.indexPath = indexPath;

    UILabel *firstView = (UILabel *)[c viewForColumn:0 forLine:0];
    [firstView setFont:[UIFont boldSystemFontOfSize:[firstView.font pointSize]]];
    
    
    int i = indexPath.row % 3;
    if (i == 0)
        [(UILabel *)[c viewForColumn:0 forLine:1] setTextAlignment:UITextAlignmentLeft];
    else if(i == 1)
        [(UILabel *)[c viewForColumn:0 forLine:1] setTextAlignment:UITextAlignmentCenter];
    else 
        [(UILabel *)[c viewForColumn:0 forLine:1] setTextAlignment:UITextAlignmentRight];
    
    static UIColor *green;
    green = [UIColor greenColor];
    [(UILabel *)[c viewForColumn:3 forLine:0] setBackgroundColor:green];
    
    
}


-(NSUInteger)numberOfLinesForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 2;
}

-(NSUInteger)numberOfColumsForLine:(NSUInteger)lineIdx forCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (lineIdx == 0) {
        return 4;
    }
    return 1;
    
}

-(NSString *)textForColumn:(NSUInteger)columnIdx ofLine:(NSUInteger)lineIdx forCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (lineIdx == 0) {
        if (columnIdx == 0)
            return [NSString stringWithFormat:@"%d", lineIdx];
        if (columnIdx == 1)
            return [NSString stringWithFormat:@"%d", indexPath.row];
        return @"";
    }
    return [NSString stringWithFormat:@"%@", [NSDate date]];
}

-(UIColor *)backgroundColorForColumn:(NSUInteger)columnIdx ofLine:(NSUInteger)lineIdx forCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (lineIdx == 0) {
        if(columnIdx%2 == 0){
            static UIColor *cyan;
            cyan = [UIColor redColor];
            return cyan;
        } else {
            static UIColor *yellow;
            yellow = [UIColor yellowColor];
            return yellow;
        }
    } else {
        static UIColor *orange;
        orange = [UIColor orangeColor];
        return orange;
    }
    
    return nil;
}

@end
