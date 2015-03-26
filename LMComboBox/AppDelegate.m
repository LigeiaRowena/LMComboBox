//
//  AppDelegate.m
//  LMComboBox
//
//  Created by Felix Deimel on 29.05.13.
//  Copyright (c) 2013 Lemon Mojo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize comboBox;
@synthesize comboBoxArrayController;

- (void)dealloc {
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Set up Items for the Combo Box
    
    NSDictionary* sepa1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], @"isSeparator",
                           @"Apple Products", @"title",
                           nil];
    
    NSDictionary* item1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO], @"isSeparator",
                           @"MacBook Pro", @"title",
                           nil];
    
    NSDictionary* item2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO], @"isSeparator",
                           @"iMac", @"title",
                           nil];
    
    NSDictionary* item3 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO], @"isSeparator",
                           @"iPhone", @"title",
                           nil];
    
    NSDictionary* item4 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO], @"isSeparator",
                           @"iPad", @"title",
                           nil];
    
    NSDictionary* sepa2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], @"isSeparator",
                           @"Google Products", @"title",
                           nil];
    
    NSDictionary* item5 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO], @"isSeparator",
                           @"Nexus 7", @"title",
                           nil];
    
    NSDictionary* item6 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO], @"isSeparator",
                           @"Chromebook Pixel", @"title",
                           nil];
    
    NSMutableArray* items = [NSMutableArray arrayWithObjects:sepa1, item1, item2, item3, item4, sepa2, item5, item6, nil];
    
    self.comboBoxArrayController.content = items;
    
    // This class is also the delegate for the Combo Box's Table View
    comboBox.tableViewDelegate = self;
}

- (IBAction)buttonRemoveSelectedItem_action:(id)sender {
    NSInteger selIdx = [self.comboBox indexOfSelectedItem];
    
    if (selIdx == NSNotFound ||
        selIdx < 0) {
        return;
    }
    
    [self.comboBoxArrayController removeObjectAtArrangedObjectIndex:selIdx];
    [self.comboBox setStringValue:@""];
}

- (NSDictionary*)itemAtIndex:(NSInteger)index {
    // Return an item from a specific position in the Array Controller
    
    [comboBoxArrayController setSelectionIndex:index];
    return (NSDictionary*)[comboBoxArrayController selection];
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    // Making customizations to the drawing
    
    NSDictionary* item = [self itemAtIndex:rowIndex];
    
    BOOL isSeparator = [[item valueForKey:@"isSeparator"] boolValue];
    
    NSTextFieldCell* txtCell = (NSTextFieldCell*)aCell;
    NSString* cellStr = [txtCell stringValue];
    
    [txtCell setEnabled:!isSeparator];
    [txtCell setSelectable:!isSeparator];
    
    if (isSeparator) {
        NSMutableParagraphStyle *paragraphStyle;
        
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setAlignment:NSCenterTextAlignment];
        
        NSAttributedString* txtA = [[NSAttributedString alloc] initWithString:cellStr attributes:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithFloat:0.20], NSObliquenessAttributeName,
                                     paragraphStyle, NSParagraphStyleAttributeName,
                                     nil]];
        
        [txtCell setAttributedStringValue:txtA];
    }
}

// You have to implement this if you want to be able to modify (add/remove items) the content of the ComboBox
- (void)_numberOfRowsDidChangeInComboBoxTableView:(NSTableView *)aTableView {
    
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex {
    // Separator items should not be selectable
    
    return ![[[self itemAtIndex:rowIndex] valueForKey:@"isSeparator"] boolValue];
}

@end
