//
//  ViewController.m
//  CoreDataProgramming
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


@implementation ViewController

@synthesize textAndroidMarks,textIOSMarks,textName,textRollno;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
    
    if (![self isValidMarks:textAndroidMarks.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Data" message:@"Android marks not valid"  delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    if (![self isValidMarks:textIOSMarks.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Data" message:@"IOSmarks not valid"  delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    if (![self isValidName]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Data" message:@" not valid"  delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    //access ManagedObjectContext(it is AppDelegate)
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *objContext = [appDelegate managedObjectContext];
    
    //create a new empty entity for student in object context
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Sudent" inManagedObjectContext:objContext];
    
    //set atrribute values in empty object
    [obj setValue:textName.text forKey:@"name"];
    
    NSNumber *numRoll = [NSNumber numberWithInt:[textRollno.text intValue]];
    [obj setValue:numRoll forKey:@"rollno"];
    
    NSNumber *numios = [NSNumber numberWithInt:[textIOSMarks.text intValue]];
    [obj setValue:numios forKey:@"ios_marks"];
    
    NSNumber *numandroid = [NSNumber numberWithInt:[textAndroidMarks.text intValue]];
    [obj setValue:numandroid forKey:@"android_marks"];

    //save object context
    NSError *error;
    BOOL result = [objContext save:&error];
    NSLog(@"Result: %d,Error:%@",result,error);
    
    if (result == true) {
        textRollno.text =@"";
        textName.text = @"";
        textIOSMarks.text =@"";
        textAndroidMarks.text =@"";
    }
}

-(BOOL)isValidMarks:(NSString *)marks
{
    NSString *strregX =@"[0-9]{1,2}";
    NSError *error;
    NSRegularExpression *regX = [[NSRegularExpression alloc]initWithPattern:strregX options:NSRegularExpressionCaseInsensitive error:&error];
    
    long n = [regX numberOfMatchesInString:marks options:0 range:NSMakeRange(0,marks.length)];
    
    if (n==0) {
        return true;
    }
    else
    {
        return false;
    }
    
}

-(BOOL)isValidName
{
    NSString *strRegN = @"[a-zA-Z]{3,20}";
    NSError *err;
    NSRegularExpression *regN = [[NSRegularExpression alloc]initWithPattern:strRegN options:NSRegularExpressionCaseInsensitive error:&err];
    long n = [regN numberOfMatchesInString:textName.text options:0 range:NSMakeRange(0,textName.text.length)];
    
    if (n==0) {
        return true;
    }
    else
    {
        return false;
    }
}

@end
