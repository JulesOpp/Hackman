//
//  AppView.m
//  PacMan
//
//  Created by Jules on 4/17/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AppView.h"

@implementation AppView

int posX;
int posY;
int dir;
int numCount;

int posXGhost1;
int posYGhost1;

int posXGhost2;
int posYGhost2;

int posXGhost3;
int posYGhost3;

int posXGhost4;
int posYGhost4;

bool pBool;
bool uberMode;

int grid[50][50];
int dots[50][50];

NSTimer* uber;


NSMutableArray* boxes;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        srand([[NSDate date] timeIntervalSince1970]);
        
        [self initialize];
    }

    return self;
}

-(void) initialize {
    posX = 24;
    posY = 22;
    dir = 1;
    pBool = true;
    numCount = 0;
    uberMode = false;
    
    posXGhost1 = 25;
    posYGhost1 = 25;
    
    posXGhost2 = 24;
    posYGhost2 = 25;
    
    posXGhost3 = 24;
    posYGhost3 = 24;
    
    posXGhost4 = 25;
    posYGhost4 = 24;
    
    boxes = [[NSMutableArray alloc] init];
    
    int min = 0;
    int max = 49;
    
    for (int i=0; i<50; i++)
        for (int j=0; j<50; j++) {
            grid[i][j] = 0;
            dots[i][j] = 0;
        }
    
    for (int i=0; i<50; i++) {
        grid[min][i] = 1;
        grid[max][i] = 1;
        grid[i][min] = 1;
        grid[i][max] = 1;
    }
    
    // TELEPORTER
    grid[0][24] = 0;
    grid[0][25] = 0;
    grid[49][24] = 0;
    grid[49][25] = 0;
    grid[24][0] = 0;
    grid[25][0] = 0;
    grid[24][49] = 0;
    grid[25][49] = 0;
    
    // first true = vertical, second true = horizontal
    [self addToGrid:10 :2 :2 :false :true];
    [self addToGrid:2 :4 :1 :false :true];
    [self addToGrid:3 :6 :3 :true :false];
    [self addToGrid:7 :4 :4 :true :false];
    [self addToGrid:2 :6 :2 :false :true];
    [self addToGrid:6 :7 :6 :false :true];
    [self addToGrid:2 :8 :4 :true :false];
    [self addToGrid:6 :2 :13 :false :true];
    [self addToGrid:3 :2 :20 :false :true];
    [self addToGrid:2 :2 :24 :false :true];
    [self addToGrid:5 :24 :3 :true :false];
    [self addToGrid:4 :4 :12 :false :true];
    [self addToGrid:2 :10 :4 :true :false];
    [self addToGrid:5 :2 :8 :true :false];
    [self addToGrid:5 :12 :4 :false :true];
    [self addToGrid:2 :6 :9 :true :false];
    [self addToGrid:1 :8 :11 :true :false];
    [self addToGrid:5 :9 :8 :false :true];
    [self addToGrid:10 :17 :4 :true :false];
    [self addToGrid:3 :6 :15 :false :true];
    [self addToGrid:2 :13 :6 :true :false];
    [self addToGrid:2 :15 :8 :true :false];
    [self addToGrid:1 :14 :9 :true :false];
    [self addToGrid:4 :4 :19 :false :true];
    [self addToGrid:4 :22 :5 :true :false];
    [self addToGrid:2 :6 :19 :false :true];
    [self addToGrid:5 :19 :7 :true :false];
    [self addToGrid:3 :21 :8 :true :false];
    [self addToGrid:1 :24 :9 :true :false];
    [self addToGrid:2 :11 :23 :false :true];
    [self addToGrid:4 :21 :12 :true :false];
    [self addToGrid:6 :11 :10 :false :true];
    [self addToGrid:3 :19 :13 :true :false];
    [self addToGrid:4 :15 :15 :false :true];
    [self addToGrid:4 :13 :12 :false :true];
    [self addToGrid:4 :10 :12 :true :false];
    [self addToGrid:1 :22 :14 :true :false];
    [self addToGrid:1 :24 :13 :true :false];
    [self addToGrid:5 :14 :2 :false :true];
    [self addToGrid:7 :8 :14 :true :false];
    [self addToGrid:2 :15 :12 :false :true];
    [self addToGrid:11 :17 :10 :false :true];
    [self addToGrid:6 :2 :16 :true :false];
    [self addToGrid:3 :16 :4 :false :true];
    [self addToGrid:5 :6 :17 :true :false];
    [self addToGrid:3 :4 :18 :true :false];
    [self addToGrid:7 :22 :4 :false :true];
    [self addToGrid:2 :10 :19 :true :false];
    [self addToGrid:7 :19 :11 :false :true];
    [self addToGrid:4 :19 :19 :true :false];
    [self addToGrid:4 :22 :17 :true :false];
    [self addToGrid:2 :23 :16 :true :false];
    [self addToGrid:2 :19 :24 :false :true];
    [self addToGrid:1 :21 :19 :true :false];
    [self addToGrid:1 :20 :21 :true :false];
    [self addToGrid:4 :21 :12 :false :true];
    [self addToGrid:4 :17 :20 :true :false];
    [self addToGrid:3 :23 :14 :false :true];
    [self addToGrid:1 :10 :23 :true :false];
    [self addToGrid:2 :2 :23 :true :false];
    [self addToGrid:6 :24 :3 :false :true];
    [self addToGrid:2 :12 :23 :true :false];
    
    for (int i=0; i<6; i++) {
        grid[i+22][23] = 1;
    }
    for (int i=0; i<3; i++) {
        grid[22][24+i] = 1;
        grid[49-22][24+i] = 1;
    }
    grid[23][26] = 1;
    grid[26][26] = 1;
    
    
    for (int i=0; i<50; i++)
        for (int j=0; j<50; j++)
            if (grid[i][j] == 0)
                dots[i][j] = 1;
    dots[0][24] = 0;
    dots[0][25] = 0;
    dots[49][24] = 0;
    dots[49][25] = 0;
    dots[24][0] = 0;
    dots[25][0] = 0;
    dots[24][49] = 0;
    dots[25][49] = 0;
    
    dots[1][48] = 2;
    dots[1][1] = 2;
    dots[48][1] = 2;
    dots[48][48] = 2;
    
    dots[16][7] = 2;
    dots[49-16][7] = 2;
    dots[16][49-7] = 2;
    dots[49-16][49-7] = 2;
    
    dots[16][20] = 2;
    dots[49-16][20] = 2;
    dots[16][49-20] = 2;
    dots[49-16][49-20] = 2;
}

// Length, x start, y start, horizontal symettry, vertical symettry
-(void)addToGrid: (int) n: (int) x: (int) y: (bool)bx: (bool)by {
    int max = 49;
    
    if (bx) for (int i=0; i<n; i++) {
        grid[x][i+y] = 1;
        grid[max-x][i+y] = 1;
        grid[x][max-y-i] = 1;
        grid[max-x][max-y-i] = 1;
    }
    
    if (by) for (int i=0; i<n; i++) {
        grid[max-y-i][max-x] = 1;
        grid[max-y-i][x] = 1;
        grid[i+y][max-x] = 1;
        grid[i+y][x] = 1;

    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Draw background
    [self drawBackground];
    
    // Draw pacman
    [self drawChar];
    
    // Draw ghosts
    [self drawGhost];
    
    NSString *numCounter = [NSString stringWithFormat:@"Points: %d",numCount];
    [numCounter drawInRect:NSMakeRect(400, 500, 100, 20) withAttributes:nil];
    
}

-(void) drawGhost {
    // Ghost 1
    [[NSColor blueColor] setFill];
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost1*10, posYGhost1*10, 10, 10));
    
    [[NSColor whiteColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost1*10+3, posYGhost1*10+6, 2, 2));
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost1*10+6, posYGhost1*10+6, 2, 2));

    
    // Ghost 2
    [[NSColor purpleColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost2*10, posYGhost2*10, 10, 10));
    
    [[NSColor whiteColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost2*10+3, posYGhost2*10+6, 2, 2));
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost2*10+6, posYGhost2*10+6, 2, 2));

    // Ghost 3
    [[NSColor magentaColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost3*10, posYGhost3*10, 10, 10));
    
    [[NSColor whiteColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost3*10+3, posYGhost3*10+6, 2, 2));
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost3*10+6, posYGhost3*10+6, 2, 2));

    // Ghost 4
    [[NSColor orangeColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost4*10, posYGhost4*10, 10, 10));
    
    [[NSColor whiteColor] setFill];
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost4*10+3, posYGhost4*10+6, 2, 2));
    CGContextFillEllipseInRect(context, CGRectMake(posXGhost4*10+6, posYGhost4*10+6, 2, 2));
}

-(void) drawChar {
    if (!uberMode)
        [[NSColor yellowColor] setFill];
    else
        [[NSColor whiteColor] setFill];
    
    // Yellow circle
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];    
    CGContextFillEllipseInRect(context, CGRectMake(posX*10, posY*10, 10, 10));
    
    // Black eye
    [[NSColor blackColor] setFill];
    switch (dir) {
        case 0:
            CGContextFillEllipseInRect(context, CGRectMake(posX*10+3, posY*10+3, 2, 2));
            break;
        case 1:
            CGContextFillEllipseInRect(context, CGRectMake(posX*10+3, posY*10+6, 2, 2));
            break;
        case 2:
            CGContextFillEllipseInRect(context, CGRectMake(posX*10+6, posY*10+6, 2, 2));
            break;
        case 3:
            CGContextFillEllipseInRect(context, CGRectMake(posX*10+6, posY*10+6, 2, 2));
            break;
        default:
            break;
    }
    
    // Black mouth
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, posX*10+5, posY*10+5);
    
    switch (dir) {
        case 0:
            CGContextAddArc(context, posX*10+5, posY*10+5, 5, M_PI / 4, 3*M_PI/4, 0);
            break;
        case 1:
            CGContextAddArc(context, posX*10+5, posY*10+5, 5, -M_PI / 4, M_PI/4, 0);
            break;
        case 2:
            CGContextAddArc(context, posX*10+5, posY*10+5, 5, -3*M_PI / 4, -M_PI/4, 0);
            break;
        case 3:
            CGContextAddArc(context, posX*10+5, posY*10+5, 5, 3*M_PI / 4, -3*M_PI/4, 0);
            break;
        default:
            break;
    }
    CGContextMoveToPoint(context, posX*10+8, posY*10+8);
    CGContextAddLineToPoint(context, posX*10+5, posY*10+5);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextStrokePath(context);
    CGContextFillPath(context);
}

-(void) drawBackground {
    [[NSColor blackColor] setFill];
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];    
    for (int i=0; i<50; i++)
        for (int j=0; j<50; j++) {
            if (grid[i][j] == 1) {
                [[NSColor blackColor] setFill];
                NSRectFill(CGRectMake(i*10, j*10, 10, 10));
            }
            if (dots[i][j] == 1) {
                [[NSColor redColor] setFill];
                CGContextFillEllipseInRect(context, CGRectMake(i*10+3, j*10+3, 4, 4));
            }
            else if (dots[i][j] == 2) {
                [[NSColor redColor] setFill];
                CGContextFillEllipseInRect(context, CGRectMake(i*10+2, j*10+2, 6, 6));
            }
        }
}

-(BOOL) acceptsFirstResponder{ return YES; }
-(BOOL) becomeFirstResponder { return YES; }
-(BOOL) resignFirstResponder { return YES; }

-(void)refresh {
    if (!pBool) {
        // Move PacMan
        switch (dir) {
            case 0:
                if ([self checkPos:posX :posY+1] == 1)
                    posY++;
                break;
            case 1:
                if ([self checkPos:posX+1 :posY] == 1)
                    posX++;
                break;
            case 2:
                if ([self checkPos:posX :posY-1] == 1)
                    posY--;
                break;
            case 3:
                if ([self checkPos:posX-1 :posY] == 1)
                    posX--;
                break;
            default:
                break;
        }
        
        
        // Random move for Ghost 1
        bool temp = true;
        while (temp) {
            switch (rand()%4) {
                case 0:
                    if ([self checkPos:posXGhost1 :posYGhost1+1] == 1) {
                        posYGhost1++;
                        temp = false;
                    }
                    break;
                case 1:
                    if ([self checkPos:posXGhost1+1 :posYGhost1] == 1) {
                        posXGhost1++;
                        temp = false;
                    }
                    break;
                case 2:
                    if ([self checkPos:posXGhost1 :posYGhost1-1] == 1) {
                        posYGhost1--;
                        temp = false;
                    }
                    break;
                case 3:
                    if ([self checkPos:posXGhost1-1 :posYGhost1] == 1) {
                        posXGhost1--;
                        temp = false;
                    }
                    break;
                default:
                    break;
            }
        }
    }
    
    if (dots[posX][posY] == 1) {
        dots[posX][posY] = 0;
        numCount++;
    }
    else if (dots[posX][posY] == 2) {
        dots[posX][posY] = 0;
        numCount += 5;
        uberMode = true;
        
        [uber invalidate];
        uber = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(noUber) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:uber forMode:NSRunLoopCommonModes];

    }
    
    if (posX == posXGhost1 && posY == posYGhost1) {
        if (uberMode == false) {
            pBool = true;
            [self initialize];
        }
        else {
            posXGhost1 = 25;
            posYGhost1 = 25;
        }
    }
    if (posX == posXGhost2 && posY == posYGhost2) {
        if (uberMode == false) {
            pBool = true;
            [self initialize];
        }
        else {
            posXGhost2 = 24;
            posYGhost2 = 25;
        }
    }
    if (posX == posXGhost3 && posY == posYGhost3) {
        if (uberMode == false) {
            pBool = true;
            [self initialize];
        }
        else {
            posXGhost3 = 24;
            posYGhost3 = 24;
        }
    }
    if (posX == posXGhost4 && posY == posYGhost4) {
        if (uberMode == false) {
            pBool = true;
            [self initialize];
        }
        else {
            posXGhost4 = 25;
            posYGhost4 = 24;
        }
    }
    
    [self checkTelep];
    
    [self setNeedsDisplay:true];
}

-(void) noUber {
    uberMode = false;
}

-(int) checkPos: (int) x: (int) y {
    if (grid[x][y] == 1 || x>49 || y >49)
        return 0;

    return 1;
}

-(void) checkTelep {
    int x = posX;
    int y = posY;
    
    if (x == 0 && (y == 24 || y == 25)) {
        posX = 49;
        dir = 3;
    }
    else if (x == 49 && (y == 24 || y == 25)) {
        posX = 0;
        dir = 1;
    }
    else if (y == 0 && (x == 24 || x == 25)) {
        posY = 49;
        dir = 2;
    }
    else if (y == 49 && (x == 24 || x == 25)) {
        posY = 0;
        dir = 0;
    }
    
}

- (void)keyDown:(NSEvent*)event {
    switch( [event keyCode] ) {
        case 126:       // up arrow
            if ([self checkPos: posX: posY+1] == 1) {
                //posY++;
                dir = 0;
            }
            break;
        case 125:       // down arrow
            if ([self checkPos:posX :posY-1] == 1) {
                //posY--;
                dir = 2;
            }
            break;
        case 124:       // right arrow
            if ([self checkPos:posX+1 :posY] == 1) {
                //posX++;
                dir = 1;
            }
            break;
        case 123:       // left arrow
            if ([self checkPos:posX-1 :posY] == 1) {
                //posX--;
                dir = 3;
            }
            break;
        case 0x0F:        // R
            //[self restart];
            break;
        default:
            break;
    }
    
    pBool = false;
    
    [self display];
}

- (void)mouseDown:(NSEvent *)theEvent {

    
    NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    //posX = (int)point.x/10;
    //posY = (int)point.y/10;
    NSLog(@"%f %f",point.x, point.y);
    [self display];
}

@end
