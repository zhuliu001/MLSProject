//
//  US2ConditionRange.m
//  US2FormValidator
//
//  Copyright (C) 2012 ustwo™
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  

#import "US2ConditionRange.h"

@interface US2ConditionRange ()
@property(nonatomic, assign) NSInteger stringLength;
@end

@implementation US2ConditionRange


@synthesize range = _range;


- (id)init
{
    self = [super init];
    if (self)
    {
        _range = NSMakeRange(0, 0);
    }
    
    return self;
}


#pragma mark - Violation check

- (BOOL)check:(NSString *)string
{
        self.currentCheckString = string.copy;
    BOOL success = NO;
    self.stringLength = string.length;
    
    if (0 == _range.location
        && 0 == _range.length)
        success = YES;
    
    if (nil == string)
        string = [NSString string];
    
    if(string.length >= _range.location && string.length <= _range.length)
    {
        success = YES;
    }
    
    return success;
}

- (BOOL)shouldAllowViolation
{
    return self.stringLength <= self.range.length;
}
- (NSString *)violationResultString
{
        NSInteger stringLength = (self.range.length);
        if (self.currentCheckString.length > stringLength)
        {
                self.currentCheckString = [self.currentCheckString substringWithRange:NSMakeRange(0, stringLength)];
        }
        return self.currentCheckString;
}
#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{    
    return  [NSString stringWithFormat:US2LocalizedString(@"US2KeyConditionViolationRange", nil),_range.location,_range.length];
}


@end