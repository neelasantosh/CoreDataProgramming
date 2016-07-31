//
//  ViewController.h
//  CoreDataProgramming
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textRollno;
@property (strong, nonatomic) IBOutlet UITextField *textName;

@property (strong, nonatomic) IBOutlet UITextField *textIOSMarks;
@property (strong, nonatomic) IBOutlet UITextField *textAndroidMarks;
- (IBAction)submit:(id)sender;

//check marks are valid or nor
-(BOOL)isValidMarks:(NSString *)marks;
-(BOOL)isValidName;

@end

