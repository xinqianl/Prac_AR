//
//  TestViewController.m
//  SquareCam
//
//  Created by Xinqian Li on 8/14/16.
//
//

#import "TwoViewController.h"
#import "UIImage+animatedGIF.h"
@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = YES;
//    self.title = @"Body";
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
    self.flag = YES;
    // Do any additional setup after loading the view.
    
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    self.flag = NO;
//    [super viewWillAppear:animated];
//}

//-(void)viewDidDisappear:(BOOL)animated{
//    self.flag = NO;
//}
- (void)performBackgroundTask
{
    dispatch_queue_t serverDelaySimulationThread = dispatch_queue_create("com.xxx.serverDelay", nil);
    dispatch_async(serverDelaySimulationThread, ^{
        while (self.flag) {
            
            [NSThread sleepForTimeInterval:0.2];
            [self query];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            }
                           );
        }
    });
    
}
- (void) query{
    
    NSString *link = @"http://ec2-184-72-73-84.compute-1.amazonaws.com/job";
    
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
//                                                            NSString *part = [jsonResponse valueForKey:@"part"];
//                                                            NSLog(part);
                                                            NSLog(@"action %@", action);
                                                            NSLog(@"%li", self.idNum);
                                                            
                                                            if([action isEqualToString:@"toShow"]){
                                                                
                                                                    if(self.idNum == 10){
                                                                        [self.imgView1 setFrame:CGRectMake(75, 315, 268, 324)];
                                                                        self.imgView1.image = [UIImage imageNamed:@"green.png"];
                                                                        [self.imgView2 setFrame:CGRectMake(120, 535, 176, 231)];
                                                                        self.imgView2.image = [UIImage imageNamed:@"shorts3.png"];
                                                                        [self.imgView3 setFrame:CGRectMake(350, 350, 267, 427)];
                                                                        self.imgView3.image = [UIImage imageNamed:@"dress1.png"];

                                                                    }
                                                                    
                                                                    if(self.idNum == 11){
                                                                        UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://i63.tinypic.com/5a4yeo.gif"]];
                                                                        [self.test setFrame:CGRectMake(0, 830, 800, 300)];
                                                                        self.test.image = mygif;
                                                                        
                                                                    }
                                                                
                                                               
                                                            }
                                                            
                                                            [imagePickerController setCameraOverlayView:self.imgView];
                                                            
                                                            //[self presentModalViewController:imagePickerController animated:YES];
                                                            
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
    
    self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(110, 500, 187, 230)];
    self.imgView2.image = nil;
    
    
    self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(88, 150, 200, 200)];
    self.imgView1.image = nil;
    
    self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(350, 310, 270, 455)];
    self.imgView3.image = nil;
    
    
    [self.imgView addSubview:self.imgView2];
    [self.imgView addSubview:self.imgView1];
    [self.imgView addSubview:self.imgView3];
    
    self.test = [[UIImageView alloc] initWithFrame:CGRectMake(0, 830, 800, 300)];
//    UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://i63.tinypic.com/5a4yeo.gif"]];
//    [self.test setFrame:CGRectMake(0, 830, 800, 300)];
//    self.test.image = mygif;

    [self.imgView addSubview:self.test];
    
    [imagePickerController setCameraOverlayView:self.imgView];
    [self presentModalViewController:imagePickerController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
