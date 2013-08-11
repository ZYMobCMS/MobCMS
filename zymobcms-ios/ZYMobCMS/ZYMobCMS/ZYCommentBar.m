//
//  ZYCommentBar.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYCommentBar.h"

@implementation ZYCommentBar
@synthesize articleId;
@synthesize lastInputString;
@synthesize favBtn;
@synthesize isFavorited;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        backgroundView = [[UIImageView alloc]init];
        backgroundView.backgroundColor = [UIColor darkGrayColor];
        backgroundView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        [self addSubview:backgroundView];
        [backgroundView release];
        
        inputBackView = [[UIImageView alloc]init];
        inputBackView.frame = CGRectMake(1,0,self.frame.size.width-108*2/6-2,106*2/6);
        inputBackView.image = [UIImage imageNamed:@"input.png"];
        [self addSubview:inputBackView];
        [inputBackView release];
        
        inputTextView = [[UITextView alloc]init];
        inputTextView.frame = CGRectMake(2,2,self.frame.size.width-108*2/6-4,frame.size.height-4);
        inputTextView.delegate = self;
        inputTextView.backgroundColor = [UIColor clearColor];
        [self addSubview:inputTextView];
        [inputTextView release];
        
        favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        favBtn.frame = CGRectMake(self.frame.size.width-108*2/6-1,0,108*2/6,106*2/6);
        [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
        [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_yes.png"] forState:UIControlStateDisabled];        [favBtn addTarget:self action:@selector(sendCommentOrFavAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:favBtn];
        
        inputTagView = [[UIImageView alloc]init];
        inputTagView.frame = CGRectMake(2,0,60*4/5,50*4/5);
        inputTagView.image = [UIImage imageNamed:@"contentview_commentbutton.png"];
        [self addSubview:inputTagView];
        [inputTagView release];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeKeyboardDidHiden:) name:UIKeyboardDidHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeKeyboardWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withBeginAction:(inputBeginAction)bAction withEndAction:(inputEndAction)eAction
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        backgroundView = [[UIImageView alloc]init];
        backgroundView.backgroundColor = [UIColor darkGrayColor];
        backgroundView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        [self addSubview:backgroundView];
        [backgroundView release];
        
        inputBackView = [[UIImageView alloc]init];
        inputBackView.frame = CGRectMake(1,0,self.frame.size.width-108*2/6-2,106*2/6);
        inputBackView.image = [UIImage imageNamed:@"input.png"];
        [self addSubview:inputBackView];
        [inputBackView release];
        
        inputTextView = [[UITextView alloc]init];
        inputTextView.frame = CGRectMake(26,2,self.frame.size.width-108*2/6-26,frame.size.height-4);
        inputTextView.delegate = self;
        inputTextView.backgroundColor = [UIColor clearColor];
        inputTextView.textColor = [UIColor lightGrayColor];
        inputTextView.text = @"写跟贴";
        [self addSubview:inputTextView];
        [inputTextView release];
        
        favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        favBtn.frame = CGRectMake(self.frame.size.width-108*2/6-1,0,108*2/6,106*2/6);
        [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
        favBtn.adjustsImageWhenDisabled = NO;
        [favBtn addTarget:self action:@selector(sendCommentOrFavAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:favBtn];
        
        inputTagView = [[UIImageView alloc]init];
        inputTagView.frame = CGRectMake(2,0,60*4/6,50*4/6);
        inputTagView.image = [UIImage imageNamed:@"contentview_commentbutton.png"];
        [self addSubview:inputTagView];
        [inputTagView release];
        
        _beginAction = [bAction copy];
        _endAction = [eAction copy];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeKeyboardDidHiden:) name:UIKeyboardDidHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeKeyboardWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    if (_beginAction) {
        [_beginAction release];
    }
    if (_endAction) {
        [_endAction release];
    }
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_beginAction) {
        _beginAction();
        inputTagView.hidden = YES;
        inputTextView.text = self.lastInputString;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_endAction) {
        _endAction();
        inputTagView.hidden = NO;
        self.lastInputString = inputTextView.text;
    }
}

- (void)switchToInputState
{
    inputBackView.frame = CGRectMake(1,0,self.frame.size.width-108*3/6-2,106*2/6);
    inputTextView.frame = CGRectMake(2,8,self.frame.size.width-108*3/6-4,self.frame.size.height-8);
    favBtn.frame = CGRectMake(self.frame.size.width-108*3/6-1,0,108*3/6,106*2/6);
    [favBtn setBackgroundImage:[UIImage imageNamed:@"send_comment.png"] forState:UIControlStateNormal];
    [favBtn setTitle:@"发表" forState:UIControlStateNormal];
    [favBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    inputTagView.hidden = YES;
    inputTextView.textColor = [UIColor blackColor];
    isSendComment = YES;
    favBtn.enabled = YES;
}

- (void)switchToNormalState
{
    inputBackView.frame = CGRectMake(1,0,self.frame.size.width-108*2/6-2,106*2/6);
    inputTextView.frame = CGRectMake(26,2,self.frame.size.width-108*2/6-4-26,self.frame.size.height-4);
    favBtn.frame = CGRectMake(self.frame.size.width-108*2/6-1,0,108*2/6,106*2/6);
    if (self.isFavorited) {
        [self setDisableFavorite];
    }else{
        [self setEnableFavorite];
    }
    [favBtn setTitle:@"" forState:UIControlStateNormal];
    inputTagView.hidden = NO;
    inputTextView.textColor = [UIColor lightGrayColor];
    inputTextView.text = @"写跟贴";
    isSendComment = NO;
}

- (void)observeKeyboardWillShow:(NSNotification*)noti
{
    NSDictionary* info = [noti userInfo];
    CGSize ekbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self switchToInputState];
    [BFAnimationHelper animatedMoveView:self duration:0.3 newFrame:CGRectMake(0,self.superview.frame.size.height-ekbSize.height-self.frame.size.height,self.frame.size.width,self.frame.size.height)];

}

- (void)observeKeyboardDidHiden:(NSNotification*)noti
{
    [self switchToNormalState];
    [BFAnimationHelper animatedMoveView:self duration:0.3 newFrame:CGRectMake(0,self.superview.frame.size.height-self.frame.size.height,self.frame.size.width,self.frame.size.height)];    
}

- (void)observeKeyboardWillChange:(NSNotification*)noti
{
    NSDictionary* info = [noti userInfo];
    CGSize ekbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [BFAnimationHelper animatedMoveView:self duration:0.3 newFrame:CGRectMake(0,self.superview.frame.size.height-ekbSize.height-self.frame.size.height,self.frame.size.width,self.frame.size.height)];

}

- (void)sendCommentOrFavAction
{
    if (!self.articleId) {
        [self commentReset];
        return;
    }
    
    if (isSendComment) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:inputTextView.text forKey:@"content"];
        [params setObject:self.articleId forKey:@"articleId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCommentArticle withParams:params withHelperDelegate:self withSuccessRequestMethod:@"sendCommentSuccess:" withFaildRequestMethod:@"sendCommentFaild:"];
        
        
    }else{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.articleId forKey:@"articleId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoriteArticle withParams:params withHelperDelegate:self withSuccessRequestMethod:@"sendFavoriteSuccess:" withFaildRequestMethod:@"sendFavoriteFaild:"];
        
    }
}

- (void)setEnableFavorite
{
    [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
    [favBtn setEnabled:YES];
}

- (void)setDisableFavorite
{
    [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_yes.png"] forState:UIControlStateNormal];
    [favBtn setEnabled:NO];
}

- (void)sendCommentSuccess:(NSDictionary*)result
{
    BOOL status = [[result objectForKey:@"status"]boolValue];
    if (status) {
        NSLog(@"commentSuccess");
        self.lastInputString = @"";
        [self commentReset];
        
    }else{
    }
}

- (void)sendCommentFaild:(NSDictionary*)result
{
    
}

- (void)sendFavoriteSuccess:(NSDictionary*)result
{
    BOOL status = [[result objectForKey:@"status"]boolValue];
    if (status) {
        NSLog(@"favoriteSuccess");
        self.isFavorited = YES;
        [self setDisableFavorite];
    }else{
        self.isFavorited = NO;
        [self setEnableFavorite];
    }
    
}

- (void)sendFavoriteFaild:(NSDictionary*)result
{
    self.isFavorited = NO;
    [self setEnableFavorite];
}

- (void)commentReset
{
    [inputTextView resignFirstResponder];
}

@end
