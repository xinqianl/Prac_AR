//
//  TestViewController.m
//  SquareCam 
//
//  Created by Xinqian Li on 8/14/16.
//
//

#import "TestViewController.h"
#import "UIImage+animatedGIF.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Body";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(helper)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Try clothes" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 250.0, 160.0, 40.0);
    [self.view addSubview:button];
    [self helper];
    [self performBackgroundTask];
    // Do any additional setup after loading the view.
    
}
- (void)performBackgroundTask
{
    dispatch_queue_t serverDelaySimulationThread = dispatch_queue_create("com.xxx.serverDelay", nil);
    dispatch_async(serverDelaySimulationThread, ^{
        while (true) {
            
            [NSThread sleepForTimeInterval:1.0];
            [self query];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            }
                           );
        }
    });
    
}
- (void) query{
    
    NSString *link = @"http://ec2-52-90-252-226.compute-1.amazonaws.com/job";
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:link];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            
                                                            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                            
                                                            self.idNum = [[jsonResponse valueForKey:@"itemId"] intValue];
                                                            NSString *action= [jsonResponse valueForKey:@"action"];
                                                            NSString *part = [jsonResponse valueForKey:@"part"];
                                                            NSLog(part);
                                                            NSLog(action);
                                                            NSLog(@"%li", self.idNum);
                                                            
                                                            if([action isEqualToString:@"toShow"]){
                                                                if([part isEqualToString:@"Up"]){
                                                                    if(self.idNum == 1){
                                                                        [self.imgView1 setFrame:CGRectMake(100, 150, 177, 224)];
                                                                        self.imgView1.image = [UIImage imageNamed:@"polo.png"];
                                                                    }
                                                                    
                                                                    if(self.idNum == 2){
                                                                        [self.imgView1 setFrame:CGRectMake(100, 150, 177, 224)];
                                                                        self.imgView1.image = [UIImage imageNamed:@"polo2.png"];
                                                                    }
                                                                    if(self.idNum == 3){
                                                                        [self.imgView1 setFrame:CGRectMake(100, 150, 177, 224)];
                                                                        self.imgView1.image = [UIImage imageNamed:@"polo3.png"];
                                                                    }
                                                                    if(self.idNum==5){
                                                                        [self.imgView1 setFrame:CGRectMake(88, 150, 200, 200)];
                                                                        self.imgView1.image = [UIImage imageNamed:@"polo4.png"];
                                                                        
                                                                    }
                                                                }
                                                                if([part isEqualToString:@"Down"]){
                                                                    if(self.idNum == 4){
                                                                        self.imgView2.image = [UIImage imageNamed:@"shorts.png"];
                                                                    }
                                                                }
                                                            }
                                                            if([action isEqualToString:@"toRemove"]){
                                                                if([part isEqualToString:@"Up"]){
                                                                    
                                                                    self.imgView1.image = nil;
                                                                    
                                                                }
                                                                if([part isEqualToString:@"Down"]){
                                                                    
                                                                    self.imgView2.image= nil;
                                                                    
                                                                }
                                                            }
                                                            [imagePickerController setCameraOverlayView:self.imgView];
                                                            
                                                            //                                                             [self presentModalViewController:imagePickerController animated:YES];
                                                            
                                                        }
                                                        
                                                    }];
    
    [dataTask resume];
}
- (void) helper{
    if (popoverController)
        return;
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    
    imagePickerController.mediaTypes = [NSArray arrayWithObject:@"public.image"];
    
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;


    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 600)];
    
    self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(126, 320, 120, 130)];
    self.imgView2.image = nil;
    
    
    self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(88, 150, 200, 200)];
    self.imgView1.image = nil;
    
// green/purple done
//    [self.imgView1 setFrame:CGRectMake(150, 170, 254, 324)];
//    self.imgView1.image = [UIImage imageNamed:@"green.png"];
    
    [self.imgView1 setFrame:CGRectMake(150, 210, 287, 319)];
    self.imgView1.image = [UIImage imageNamed:@"indian.png"];
    
//    blue shorts done
//    self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 400, 183, 209)];
//    self.imgView2.image = [UIImage imageNamed:@"shorts.png"];
    
    self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(210, 470, 170, 170)];
    self.imgView2.image = [UIImage imageNamed:@"jeans.png"];
//    
//    self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 120, 130, 160)];
//    self.imgView3.image = [UIImage imageNamed:@"polo_girl1.png"];
//    self.imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 230, 160, 120)];
//    self.imgView4.image = [UIImage imageNamed:@"skirt1.png"];
    
//        self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 120, 165, 260)];
//        self.imgView3.image = [UIImage imageNamed:@"dress2.png"];
    
//    self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 120, 145, 323)];
//    self.imgView3.image = [UIImage imageNamed:@"dress3.png"];

    
    
    [self.imgView addSubview:self.imgView2];
    [self.imgView addSubview:self.imgView1];
    
    
//    [self.imgView addSubview:self.imgView3];
//    [self.imgView addSubview:self.imgView4];
    
    
//***** add gif
//    UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://i63.tinypic.com/5a4yeo.gif"]];
//    UIImageView *test = [[UIImageView alloc] initWithFrame:CGRectMake(0, 730, 800, 300)];
//    test.image = mygif;
//    [self.imgView addSubview:test];
    
    [imagePickerController setCameraOverlayView:self.imgView];
    
    [self presentModalViewController:imagePickerController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
