//
//  TestViewController.h
//  SquareCam 
//
//  Created by Xinqian Li on 8/14/16.
//
//

#import <UIKit/UIKit.h>

@interface BodyViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>
{
    UIPopoverController *popoverController;
    UIImagePickerController *imagePickerController;
}

@property int idNum;
@property UIImageView *imgView;
@property UIImageView *imgView1;
@property UIImageView *imgView2;
@property UIImageView *imgView3;
@property UIImageView *imgView4;
@end
