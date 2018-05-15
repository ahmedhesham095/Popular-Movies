//
//  ReviewDetail.h
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/11/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewDetail : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *txtReview;
@property NSString* review;

@end
