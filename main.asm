.data

#Bitmap Display Setup:
#Unit width in pixels      ---> 8
#Unit Height in pixels     ---> 8
#Display Height in pixels  ---> 512
#Display Height in pixes   ---> 256
#Base address for display  ---> 0x10008000 ($gp)

xDir:           .word 1      #ball horizontal direction (1=right,-1=left)
ySpeed:         .word -1     #frames between vertical moves (smaller=faster y)
yDir:           .word -1     #ball vertical direction (1=down,-1=up)
p1Score:        .word 0      #player 1 score counter
p2Score:        .word 0      #player 2 score counter
aiCounter:      .word 0      #AI wait counter before paddle move
aiSpeed:        .word 0      #AI speed value (reloads aiCounter)
difficulty:     .word 4      #difficulty used to set aiSpeed after first hit
color1:         .word 0x000C2340   #Auburn navy (left paddle color)
color2:         .word 0x00DC143C   #Alabama crimson (right paddle color)
ballColor:      .word 0x895959     #ball color
bgColor:        .word 0x4CA450     #field background green
titleBG:        .word 0x000A5F0A   #title screen background
accentColor:    .word 0x00ffffff   #white used for lines/text
gameMode:       .word 0           #1=single player (AI), 2=two player
white:          .word 0x00ffffff   #white alias
orange:         .word 0x00E87722   #orange accent for field
yellow:         .word 0x00FFFF00   #yellow for goal posts
paddleHeight:   .word 10          #paddle height in pixels (changes with mode)
ballFrameSkip:  .word 1           #used to slow ball in 2P mode (skip frames)

.text

NewGame:
    lw  $a0, titleBG 
    jal ClearScreen           #clear screen to title background

    #DrawFieldStripesForTitleScreen
Lines:
    #DrawOrangeStripePair
    li $a0, 0
    li $a1, 13 
    lw $a2, orange
    li $a3, 70
    jal HorizontalLine        #horizontal stripe at y=13

    li $a1, 14
    jal HorizontalLine        #second stripe just below

    #DrawWhiteStripePair
    li $a0, 0
    li $a1, 15
    lw $a2, accentColor
    li $a3, 70
    jal HorizontalLine        #white stripe at y=15
        
    li $a1, 16 
    jal HorizontalLine        #white stripe at y=16

    #DrawTeamColorStripes
    li $a0, 0
    li $a1, 17
    lw $a2, color1
    li $a3, 63
    jal HorizontalLine        #Auburn stripe at y=17
        
    li $a1, 18
    jal HorizontalLine        #Auburn stripe at y=18

FieldGoals:
#FieldGoalLeft:small yellow goal on left side
    li $a0, 2
    li $a1, 6
    lw $a2, yellow
    li $a3, 8
    jal HorizontalLine        #top bar of left goal
    
    li $a0, 2
    li $a1, 1
    lw $a2, yellow
    li $a3, 5
    jal VerticalLine          #left vertical of left goal
    
    li $a0, 8
    li $a1, 1
    lw $a2, yellow
    li $a3, 5
    jal VerticalLine          #right vertical of left goal
    
    li $a0, 5
    li $a1, 6
    lw $a2, yellow
    li $a3, 10
    jal VerticalLine          #center post of left goal
    
#FieldGoalRight:mirrored yellow goal on right side
    li $a0, 52
    li $a1, 6
    lw $a2, yellow
    li $a3, 58
    jal HorizontalLine        #top bar of right goal
        
    li $a0, 52
    li $a1, 1
    lw $a2, yellow
    li $a3, 5
    jal VerticalLine          #left vertical of right goal
    
    li $a0, 58
    li $a1, 1
    lw $a2, yellow
    li $a3, 5
    jal VerticalLine          #right vertical of right goal
        
    li $a0, 55
    li $a1, 6
    lw $a2, yellow
    li $a3, 10
    jal VerticalLine          #center post of right goal

#DrawTitleText:"BEAT BAMA" in pixels
DrawTitle: #BeatBamaTitle

#a0=x position, a1=y position, a2=color, a3=end coordinate (for lines)

    #DrawBInBEAT
    li $a0, 12
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #left stroke of B
    
    li $a1, 5
    li $a3, 13
    jal HorizontalLine        #top bar
    
    li $a1, 7
    li $a3, 14
    jal HorizontalLine        #middle bar
    
    li $a1, 9
    li $a3, 13
    jal HorizontalLine        #bottom bar
    
    li $a0, 14
    li $a1, 6
    jal Pixel                 #curve pixel
    li $a1, 8
    jal Pixel                 #curve pixel
    
    #DrawEInBEAT
    li $a0, 16
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #E spine
    
    li $a0, 17
    li $a1, 9
    jal Pixel                 #bottom arm
    li $a0, 18
    jal Pixel
    
    li $a0, 17
    li $a1, 7
    jal Pixel                 #middle arm
    
    li $a0, 17
    li $a1, 5
    jal Pixel                 #top arm
    li $a0, 18
    jal Pixel
    
    #DrawAInBEAT
    li $a0, 20
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #left stroke of A
    
    li $a0, 22
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #right stroke of A
    
    li $a0, 21
    li $a1, 7
    jal Pixel                 #cross bar
    li $a0, 21
    li $a1, 5
    jal Pixel                 #top pixel
    
    #DrawTInBEAT
    li $a0, 25
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #stem of T
    
    li $a0, 24
    li $a1, 5
    jal Pixel                 #left of top bar
    li $a0, 26
    li $a1, 5
    jal Pixel                 #right of top bar
    
    #DrawBInBAMA
    li $a0, 31
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #left stroke of B
    
    li $a0, 32
    li $a1, 5
    jal Pixel                 #top curve
    li $a0, 33
    li $a1, 6
    jal Pixel
    li $a0, 33
    li $a1, 7
    jal Pixel
    li $a0, 32
    li $a1, 7
    jal Pixel
    li $a0, 33
    li $a1, 8
    jal Pixel
    li $a0, 32
    li $a1, 9
    jal Pixel
    
    #DrawAInBAMA
    li $a0, 35
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #left stroke
    
    li $a0, 36
    li $a1, 5
    jal Pixel                 #top cross
    li $a1, 7
    jal Pixel                 #middle cross
    
    li $a0, 37
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #right stroke
    
    #DrawMInBAMA
    li $a0, 39
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #left stroke of M
    
    li $a0, 40
    li $a1, 6
    jal Pixel                 #diagonal up
    li $a0, 41
    li $a1, 7
    jal Pixel
    li $a0, 42
    li $a1, 6
    jal Pixel
    
    li $a0, 43
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #right stroke of M
    
    #DrawFinalAInBAMA
    li $a0, 45
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #left stroke
    
    li $a0, 46
    li $a1, 5
    jal Pixel                 #top cross
    li $a1, 7
    jal Pixel                 #middle cross
    
    li $a0, 47
    li $a1, 5
    lw $a2, white
    li $a3, 9
    jal VerticalLine          #right stroke

#DrawModeInstructions:"1-MAIN" and "2-CATCH"
DrawInstructions:
    #DrawDigit1ForMainMode
    li $a0, 3
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #vertical stroke for "1"

    #DrawHyphenAfter1
    li $a0, 5
    li $a1, 26
    jal Pixel
    li $a0, 6
    li $a1, 26
    jal Pixel

    #DrawWordMAIN
    #M
    li $a0, 8
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #left stroke M

    li $a0, 9
    li $a1, 25
    jal Pixel
    li $a0, 10
    li $a1, 26
    jal Pixel
    li $a0, 11
    li $a1, 25
    jal Pixel                 #diagonal part

    li $a0, 12
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #right stroke M

    #A
    li $a0, 14
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #left stroke A
    
    li $a0, 15
    li $a1, 24
    jal Pixel                 #top cross
    li $a0, 15
    li $a1, 26
    jal Pixel                 #middle cross
    
    li $a0, 16
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #right stroke A

    #I
    li $a0, 18
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #letter I

    #N
    li $a0, 20
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #left stroke N
    
    li $a0, 21
    li $a1, 25
    jal Pixel
    li $a0, 22
    li $a1, 26
    jal Pixel                 #diagonal
    
    li $a0, 23
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #right stroke N

    #DrawDigit2ForCatchMode
    li $a0, 34
    li $a1, 24
    jal Pixel                 #top row of "2"
    li $a0, 35
    li $a1, 24
    jal Pixel
    li $a0, 36
    li $a1, 24
    jal Pixel
    
    li $a0, 36
    li $a1, 25
    jal Pixel                 #right curve
    
    li $a0, 34
    li $a1, 26
    jal Pixel                 #middle row left->right
    li $a0, 35
    li $a1, 26
    jal Pixel
    li $a0, 36
    li $a1, 26
    jal Pixel
    
    li $a0, 34
    li $a1, 27
    jal Pixel                 #left tail
    
    li $a0, 34
    li $a1, 28
    jal Pixel                 #bottom row of "2"
    li $a0, 35
    li $a1, 28
    jal Pixel
    li $a0, 36
    li $a1, 28
    jal Pixel
    
    #DashAfter2
    li $a0, 38
    li $a1, 26
    jal Pixel
    li $a0, 39
    li $a1, 26
    jal Pixel
    
    #DrawWordCATCH
    #C
    li $a0, 41
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #vertical stroke C
    
    li $a0, 42
    li $a1, 28
    jal Pixel
    li $a0, 43
    li $a1, 28
    jal Pixel                 #bottom stroke
    
    li $a0, 42
    li $a1, 24
    jal Pixel
    li $a0, 43
    li $a1, 24
    jal Pixel                 #top stroke
    
    #A
    li $a0, 45
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #left stroke A
    
    li $a0, 46
    li $a1, 24
    jal Pixel                 #top cross
    li $a0, 46
    li $a1, 26
    jal Pixel                 #middle cross
    
    li $a0, 47
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #right stroke A
    
    #T
    li $a0, 50
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #stem T
    
    li $a0, 49
    li $a1, 24
    jal Pixel                 #left top
    li $a0, 51
    li $a1, 24
    jal Pixel                 #right top
    
    #C
    li $a0, 53
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #vertical stroke C

    li $a0, 54
    li $a1, 24
    jal Pixel
    li $a0, 55
    li $a1, 24
    jal Pixel                 #top edge
    
    li $a0, 54
    li $a1, 28
    jal Pixel
    li $a0, 55
    li $a1, 28
    jal Pixel                 #bottom edge
    
    #H
    li $a0, 57
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #left stroke H
    
    li $a0, 58
    li $a1, 26
    jal Pixel                 #middle bar
    
    li $a0, 59
    li $a1, 24
    lw $a2, white
    li $a3, 28
    jal VerticalLine          #right stroke H

        
#WaitForPlayerToChooseGameMode:keyboard '1' or '2'
SelectMode:
    lw $t1, 0xFFFF0004        #read last key pressed
    beq $t1, 0x31, Set1Player #if '1' pressed
    beq $t1, 0x32, Set2Player #if '2' pressed
        
    li $a0, 250
    li $v0, 32                #sleep ~250ms to avoid busy loop
    syscall
        
    j SelectMode              #retry reading key
        
Set1Player:
    li $t1, 1                 #store single-player mode
    j StartGame

Set2Player:
    li $t1, 2                 #store two-player mode

StartGame:
    sw $zero, 0xFFFF0000      #clear keypress ready flag
    sw $t1, gameMode          #save selected game mode
        

######################
#NEW ROUND / SETUP
######################
#Registers used in main loop:
#$s0=p1 movement direction (encoded)
#$s1=p2/AI movement direction
#$s2=ball x velocity (sign gives left/right)
#$s3=ySpeed countdown (frames until vertical move)
#$s4=p1 paddle top y
#$s5=p2 paddle top y
#$s6=ball x coordinate
#$s7=ball y coordinate
NewRound:
    #ResetRoundVariables
    li $t0, 1
    li $t1, -1
    sw $t0, ySpeed            #reset vertical speed counter
    sw $t1, yDir              #ball initially moving up
    sw $zero, aiSpeed         #AI disabled until first hit
    sw $zero, aiCounter       #clear AI timer
        
    li $s0, 0                 #no movement for p1
    li $s1, 0                 #no movement for p2/AI
    lw $s2, xDir              #load x direction (1 or -1)
    lw $s3, ySpeed            #initial y counter
    li $s4, 13                #center p1 paddle vertically
    li $s5, 13                #center p2 paddle vertically
    li $s6, 32                #center ball horizontally
    li $s7, 0                 #ball starts near top
    
    #SetPaddleHeightBasedOnMode
    lw  $t0, gameMode
    bne $t0, 2, SetNormalPaddle   #only enlarge paddles in 2P

    li  $t1, 14               #taller paddles in 2-player
    sw  $t1, paddleHeight
    j   DoneSetPaddle

SetNormalPaddle:
    li  $t1, 10               #default paddle height (1P mode)
    sw  $t1, paddleHeight

DoneSetPaddle:
    li  $t2, 1                #reset ball frame skip (2P timing)
    sw  $t2, ballFrameSkip

    lw $a0, bgColor
    jal ClearScreen           #clear screen to field green

    #DrawFullFieldWithYardLines:used as background
    jal DrawYardLines
        
    #DrawScoresOnField:left then right
    lw $a2, p1Score
    li $a3, 1                 #score column left
    jal DrawScore

    lw $a2, p2Score
    li $a3, 54                #score column right
    jal DrawScore
        
    #DrawInitialPaddles
    li $a0, 7                 #left paddle x
    move $a1, $s4             #p1 top y
    lw $a2, color1
    jal DrawPaddle
        
    li $a0, 55                #right paddle x
    move $a1, $s5             #p2 top y
    lw $a2, color2
    jal DrawPaddle

    #PreRoundDelay1Second
    li $a0, 1000
    li $v0, 32                #sleep ~1 second
    syscall

######################
#MAIN GAME LOOP
######################
GameLoop:
    #In2PlayerMode:slow ball by skipping frames
    lw  $t0, gameMode
    bne $t0, 2, DoBallNow      #if not 2P, update ball every frame

    lw   $t1, ballFrameSkip
    addi $t1, $t1, -1
    sw   $t1, ballFrameSkip    #store decremented counter
    bgtz $t1, SkipBall         #if >0, skip ball movement this frame
    li   $t1, 1                #reset to 1: move ball every other frame
    sw   $t1, ballFrameSkip

DoBallNow:
    move $a0, $s6              #ball x
    move $a1, $s7              #ball y
    jal  CheckCollisions       #check scoring/walls/paddles
    jal  MoveBall              #move ball and redraw
    j    UpdatePaddles         #then update paddles

SkipBall:
    #Whenskippingball:only paddles/input move
    j    UpdatePaddles

UpdatePaddles:
    #UpdateP1Paddle:uses s0 direction from input
    li  $a0, 7          #left paddle x
    move $a1, $s4       #current p1 top y
    lw   $a2, color1    #p1 color
    move $a3, $s0       #movement direction
    jal  DrawPaddle     #updates position and draws
    move $s4, $a1       #save new y position
    move $s0, $a3       #save updated direction (may be zeroed)

    #PrepForP2OrAIUpdate
    li  $a0, 55         #right paddle x
    move $a1, $s5       #current p2 top y
    lw   $a2, color2    #p2 color

UpdateAI:
    lw $t1, gameMode
    bne $t1, 1, UpdatePlayer2   #if not 1P, skip AI and use player2
        
    lw $t0, aiCounter           #AI delay counter
    addi $t0, $t0, -1
    sw $t0, aiCounter
    bgt $t0, 0, UpdatePlayer2   #wait until counter hits 0
        
    lw $t0, aiSpeed             #reload AI delay from difficulty
    sw $t0, aiCounter
    addi $t1, $s5, 2            #paddle middle y (p2 top + 2)
    blt $t1, $s7, MoveAIDown    #if middle above ball -> move down
    li  $s1, 0x01000000         #otherwise move up
    j UpdatePlayer2

MoveAIDown: 
    li $s1, 0x02000000          #AI move down
        
UpdatePlayer2:
    move $a3, $s1               #movement direction for p2/AI
    jal DrawPaddle              #update and redraw paddle
    move $s5, $a1               #save new y
    move $s1, $a3               #save direction (may be zeroed)
        
        
######################
#INPUT HANDLING (DEBOUNCED)
######################
WaitForInput:    
    li $t0, 2           #outer loop iterations (~2*10ms)

InputLoop:
    blez $t0, EndWait
    li $a0, 10
    li $v0, 32          #sleep ~10ms
    syscall
        
    addi $t0, $t0, -1
        
    lw $t1, 0xFFFF0000  #check if key pressed (key ready flag)
    blez $t1, InputLoop #no key yet, keep waiting
                
    jal HandleInput     #update s0/s1 based on key
    sw $zero, 0xFFFF0000#clear key ready flag
    j InputLoop         #keep reading keys during this wait
        
EndWait:        
    j GameLoop          #start next frame
        
######################
#DRAW PADDLE
######################
#Input:
# $a0=paddle x, $a1=paddle top y
# $a2=paddle color, $a3=direction (0x01xx=up,0x02xx=down,0=no move)
#Output:
# $a1=new top y, $a3=possibly reset to 0
DrawPaddle:
    beq $a3, 0x02000000, MoveDown   #if direction=down
    bne $a3, 0x01000000, NoMove     #if not up, no move
    
MoveUp:
    #EraseBottomPixelBeforeMovingUp
    move $t2, $a2          #save paddle color
    move $t1, $a1          #save original top y
    lw   $t0, paddleHeight
    addi $t0, $t0, -1
    addu $a1, $a1, $t0     #a1=bottom y (top + height-1)

    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  GetFieldColor     #get background at (a0,a1)
    move $a2, $v0
    jal  Pixel             #restore background pixel
    lw   $ra, 0($sp)
    addi $sp, $sp, 4

    move $a1, $t1          #restore top y
    move $a2, $t2          #restore paddle color
           
    #MoveUpIfNotAtTop
    beq $a1, 0, NoMove     #if already at y=0, can't move up
    addi $a1, $a1, -1      #top y-- (move paddle up)
    j DrawPaddlePixels
        
MoveDown:
    #EraseTopPixelBeforeMovingDown
    move $t1, $a2          #save paddle color

    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  GetFieldColor     #get background at (a0,a1) top pixel
    move $a2, $v0
    jal  Pixel             #restore background
    lw   $ra, 0($sp)
    addi $sp, $sp, 4

    move $a2, $t1          #restore paddle color
           
    #MoveDownIfNotPastBottom
    #ScreenHeight=32 rows; last valid top = 32 - paddleHeight
    lw  $t0, paddleHeight
    li  $t1, 32
    sub $t1, $t1, $t0      #t1=max valid top y
    beq $a1, $t1, NoMove   #if at bottom limit, don't move
    addi $a1, $a1, 1       #top y++ (move paddle down)
    j DrawPaddlePixels    

NoMove:
    li $a3, 0               #stop movement; direction=0

DrawPaddlePixels:
    lw $t0, paddleHeight    #draw paddleHeight pixels tall
PaddleLoop:
    subi $t0, $t0, 1
    addu $t1, $a1, $t0      #current y = top + offset
        
    #Convert(x,y)to VRAM address:addr=(y*64+x)*4+gp
    sll $t1, $t1, 6         #y * 64
    addu $v0, $a0, $t1
    sll $v0, $v0, 2
    addu $v0, $v0, $gp
        
    sw $a2, ($v0)           #store paddle color
    beqz $t0, PaddleDone
    j PaddleLoop
        
PaddleDone:        
    jr $ra

######################
#DRAW SCORE
######################
#Dots layout:score up to 10 using two rows
#Input: $a2=score (0-10), $a3=leftmost x column
DrawScore:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s2, 4($sp)
    sw $a2, 8($sp)
           
    move $s2, $a2           #work copy of score
    lw $a2, ballColor       #scores use ball color
    ble $s2, 5, ScoreRow1   #<=5 dots only in first row
           
ScoreRow2:              #second row (scores 6-10)
    sub $t1, $s2, 6         #index from 0
    sll $t1, $t1, 1         #*2 (spacing)
    add $a0, $t1, $a3       #x position in second row
    li $a1, 3               #y row of second line
    jal Pixel
    addi $s2, $s2, -1
    bge $s2, 6, ScoreRow2   #loop until score==6
           
ScoreRow1:              #first row (scores 1-5)
    beq $s2, $zero, ScoreDone
    sub $t1, $s2, 1         #index from 0
    sll $t1, $t1, 1         #*2 spacing
    add $a0, $t1, $a3       #x position first row
    li $a1, 1               #y row of first line
    jal Pixel
    addi $s2, $s2, -1
    j ScoreRow1
    
ScoreDone:
    lw $ra, 0($sp)
    lw $s2, 4($sp)
    lw $a2, 8($sp)
    addi $sp, $sp, 12
    jr $ra
        
######################
#MOVE BALL
######################
#Input: $a0=old x, $a1=old y (ball position)
#Uses: $s2=x velocity, $s3=y counter, ySpeed,yDir globals
MoveBall:        
    #EraseOldBallPixelUsingBackground
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    #a0,a1 still contain old ball position
    jal  GetFieldColor       #v0=background color at old spot
    move $a2, $v0
    jal  Pixel               #restore background pixel

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
           
    #UpdateXPosition: s6 += s2
    add $s6, $s6, $s2        #move ball horizontally
           
    #UpdateYPositionUsingCountdown
    addi $s3, $s3, -1        #countdown until next vertical step
    bgt  $s3, 0, SkipY       #if >0, don't move vertically yet
           
UpdateY:
    lw $t0, yDir             #load vertical direction (+1/-1)
    add $s7, $s7, $t0        #apply vertical move
    lw $s3, ySpeed           #reset vertical countdown
        
SkipY:
    #DrawNewBallAtUpdatedPosition
    move $a0, $s6
    move $a1, $s7
    lw   $a2, ballColor
        
######################
#PIXEL / LINES
######################
#Draw single pixel at (a0,a1) with color a2
Pixel:
    sll $t0, $a1, 6         #y * 64
    addu $v0, $a0, $t0
    sll $v0, $v0, 2
    addu $v0, $v0, $gp
    sw  $a2, ($v0)
    jr  $ra

#Draw horizontal line from x=a0..a3 at y=a1
#Uses a2 as line color
HorizontalLine:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
        
    sub  $t9, $a3, $a0      #t9=length-1 (delta x)
    move $t1, $a0           #t1=original start x
        
HLineLoop:
    add $a0, $t1, $t9       #a0=current x: start+offset
    jal Pixel               #draw pixel at (a0,a1)
    addi $t9, $t9, -1       #offset--
    bge $t9, 0, HLineLoop   #loop until offset<0
        
    lw  $ra, 0($sp)
    addi $sp, $sp, 4
    jr  $ra
        
#Draw vertical line from y=a1..a3 at x=a0
VerticalLine:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
        
    sub  $t9, $a3, $a1      #t9=length-1 (delta y)
    move $t1, $a1           #t1=original start y
        
VLineLoop:
    add $a1, $t1, $t9       #a1=current y
    jal Pixel               #draw pixel at (a0,a1)
    addi $t9, $t9, -1
    bge $t9, 0, VLineLoop
        
    lw  $ra, 0($sp)
    addi $sp, $sp, 4
    jr  $ra

######################
#FIELD BACKDROP (YARD LINES)
######################
#Fills entire 64x32 area calling GetFieldColor for each pixel
#Keeps background and erase logic perfectly in sync
DrawYardLines:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $t2, 0          #t2=y from 0..31

DY_RowLoop:
    li   $t3, 0          #t3=x from 0..63 for each row

DY_ColLoop:
    move $a0, $t3        #a0=x
    move $a1, $t2        #a1=y
    jal  GetFieldColor   #v0=color for this pixel

    move $a0, $t3        #restore x for Pixel
    move $a1, $t2        #restore y
    move $a2, $v0
    jal  Pixel           #draw background pixel

    addi $t3, $t3, 1           #x++
    blt  $t3, 64, DY_ColLoop   #loop until x==64

    addi $t2, $t2, 1           #y++
    blt  $t2, 32, DY_RowLoop   #loop until y==32

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

######################
#GET FIELD COLOR (BACKGROUND)
######################
#Input: a0=x, a1=y
#Output: v0=color (bgColor or accentColor for yard lines/ticks)
#Logic:
# -Even-indexed lines:full vertical white yard lines
# -Odd-indexed lines:only top/bottom tick marks (y=0 or 31)
GetFieldColor:
    lw  $v0, bgColor          #default=grass green

    li  $t5, 10               #number of yard line positions
    li  $t6, 0                #line index i=0..9
    li  $t7, 4                #starting x for first line
    li  $t8, 6                #spacing between lines in pixels

GF_Loop:
    bge $t6, $t5, GF_Done     #if i>=10, no more lines

    beq $a0, $t7, GF_OnThisLine   #if x matches this line

    addu $t7, $t7, $t8        #advance x to next line
    addi $t6, $t6, 1          #i++
    j    GF_Loop

#Decide line style based on index parity
GF_OnThisLine:
    andi $t9, $t6, 1          #t9=i&1 (0=even full,1=odd tick)

    beq  $t9, $zero, GF_FullLine   #even index:full-height line

    #Odd index:tick line only at very top or bottom row
    beq  $a1, $zero, GF_SetAccent  #if y==0 -> top tick
    li   $t0, 31
    beq  $a1, $t0, GF_SetAccent    #if y==31 -> bottom tick
    j    GF_Done                   #middle rows keep grass color

GF_FullLine:
GF_SetAccent:
    lw  $v0, accentColor      #white yard line/tick color

GF_Done:
    jr  $ra


######################
#INPUT KEYS
######################
#Maps keyboard keys to paddle directions:
# 'a'->p1 up, 'z'->p1 down, 'k'->p2 up, 'm'->p2 down
HandleInput: 
    lw $a0, 0xFFFF0004        #read ASCII of key
        
    bne $a0, 97, CheckZ      #97='a'
    li  $s0, 0x01000000      #p1 up
    j   InputDone

CheckZ:
    bne $a0, 122, CheckK     #122='z'
    li  $s0, 0x02000000      #p1 down
    j   InputDone

CheckK:
    bne $a0, 107, CheckM     #107='k'
    li  $s1, 0x01000000      #p2 up
    j   InputDone

CheckM:
    bne $a0, 109, InputDone  #109='m'
    li  $s1, 0x02000000      #p2 down

InputDone:
    jr $ra

######################
#COLLISIONS
######################
#Input: $a0=ball x, $a1=ball y (not reused, uses globals)
#Handles:
# -scoring if ball hits left/right border
# -paddle collisions (with angle)
# -top/bottom wall bounce
CheckCollisions:
    #LeftEdge->P1Loses
    beq $s6, 0,  P1Loses
    #RightEdge->P2Loses
    beq $s6, 63, P2Loses
    #CheckLeftPaddleX
    bne $s6, 8, CheckRightPaddle
        
CheckLeftPaddle:
    blt $s7, $s4, CheckWalls     #ball above top of paddle
    lw   $t0, paddleHeight
    addi $t0, $t0, -1
    addu $t3, $s4, $t0          #paddle bottom y (top+height-1)

    bgt $s7, $t3, CheckWalls    #ball below paddle bottom

    #Compute raw hit position:0..paddleHeight-1
    sub  $t3, $s7, $s4

    #Scale hit position into 0..5 using integer math
    lw   $t0, paddleHeight      #t0=paddleHeight
    li   $t1, 6
    mul  $t2, $t3, $t1          #t2=t3*6
    div  $t2, $t0               #t2/paddleHeight
    mflo $t3                    #t3=scaled zone 0..5

    li  $s2, 1                  #ball now going right
    j   PaddleHit
           
CheckRightPaddle:
    bne $s6, 54, CheckWalls     #only check when at paddle x
    blt $s7, $s5, CheckWalls    #ball above paddle
    lw   $t0, paddleHeight
    addi $t0, $t0, -1
    addu $t3, $s5, $t0          #paddle bottom
    bgt $s7, $t3, CheckWalls    #ball below paddle

    #Compute raw and scaled hit position 0..5
    sub  $t3, $s7, $s5

    lw   $t0, paddleHeight      #t0=paddleHeight
    li   $t1, 6
    mul  $t2, $t3, $t1          #t2=t3*6
    div  $t2, $t0               #t2/paddleHeight
    mflo $t3                    #t3=scaled zone 0..5

    li  $s2, -1                 #ball now going left
    j   PaddleHit     

CheckWalls:
    #Check bottom and top walls for bounce
    beq $s7, 31, WallHit        #bottom row
    bne $s7, 0,  NoBounce       #if not top row, no bounce
        
WallHit:      
    #Flip y direction if ySpeed small enough
    bgt $s3, 1, NoBounce        #if vertical delay>1, skip flip
    lw  $t4, yDir
    xori $t4, $t4, 0xffffffff   #t4=-yDir (two's complement)
    addi $t4, $t4, 1
    sw  $t4, yDir               #store flipped direction
        
NoBounce:
    jr $ra
        
PaddleHit: 
    #On paddle hit, enable AI and adjust angle based on zone
        
    #SetAI speed from difficulty after first paddle contact
    lw $t4, difficulty
    sw $t4, aiSpeed
        
    beq $t3, 0, HighAngle
    beq $t3, 1, MediumAngle
    beq $t3, 2, ShallowAngle
    beq $t3, 3, ShallowAngle2
    beq $t3, 4, MediumAngle2
    beq $t3, 5, HighAngle2
    beq $t3, 6, SteepAngle      
    beq $t3, 7, SteeperAngle
        
HighAngle:
    li $s3, 1        #fast vertical update (steep)
    sw $s3, ySpeed
    li $s3, -1       #direction up
    sw $s3, yDir
    j  CheckWalls

MediumAngle:
    li $s3, 2        #medium speed
    sw $s3, ySpeed
    li $s3, -1
    sw $s3, yDir
    j  CheckWalls

ShallowAngle:
    li $s3, 4        #slower vertical, more horizontal
    sw $s3, ySpeed
    li $s3, -1
    sw $s3, yDir
    j  CheckWalls

ShallowAngle2:
    li $s3, 4
    sw $s3, ySpeed
    li $s3, 1        #same shallow but downward
    sw $s3, yDir
    j  CheckWalls

MediumAngle2:
    li $s3, 2
    sw $s3, ySpeed
    li $s3, 1
    sw $s3, yDir
    j  CheckWalls

HighAngle2:
    li $s3, 1
    sw $s3, ySpeed
    li $s3, 1        #steep downward
    sw $s3, yDir
    j  CheckWalls
    
SteepAngle:
    li $s3, 3        #custom steeper tuning
    sw $s3, ySpeed
    li $s3, 1
    sw $s3, yDir
    j  CheckWalls

SteeperAngle:
    li $s3, 1             
    sw $s3, ySpeed
    li $s3, 1
    sw $s3, yDir
    j  CheckWalls

######################
#CLEAR SCREEN
######################
#Fill entire 64x32*4 bytes VRAM with color in $a0
ClearScreen:
    move $t0, $a0           #t0=color
    li   $t1, 8192          #total bytes (64*32*4)
ClearLoop:
    subi $t1, $t1, 4        #step by 4 bytes (one pixel)
    addu $t2, $t1, $gp      #address=gp+offset
    sw   $t0, ($t2)         #store color
    beqz $t1, ClearDone     #when offset 0 reached, done
    j    ClearLoop

ClearDone:
    jr $ra
        
######################
#SCORING / GAME OVER
######################
P1Loses:
    lw   $t1, p2Score
    addi $t1, $t1, 1
    sw   $t1, p2Score       #increment p2 score
    li   $t2, 1
    sw   $t2, xDir          #restart ball going right
    li   $a3, 54            #right side score column
    sw   $zero, 0xFFFF0004  #clear last key
    beq  $t1, 7, GameOver   #if score==7, end game
    j    ScoreSound
        
P2Loses:    
    lw   $t1, p1Score
    addi $t1, $t1, 1
    sw   $t1, p1Score       #increment p1 score
    li   $t2, -1
    sw   $t2, xDir          #restart ball going left
    li   $a3, 1             #left side score column
    sw   $zero, 0xFFFF0004
    beq  $t1, 7, GameOver   #if score==7, end game

ScoreSound:
   #Play3-notecelebrationlikeatouchdownhorn
    li $a0, 60
    li $a1, 300
    li $a2, 56              #Trumpet instrument
    li $a3, 127             #max volume
    li $v0, 31
    syscall
	
    li $a0, 64              #Second note in chord
    li $a1, 300
    li $a2, 56
    li $a3, 127
    li $v0, 31
    syscall
	
    li $a0, 67              #Third note
    li $a1, 300
    li $a2, 56
    li $a3, 127
    li $v0, 31
    syscall
    j  NewRound             #start next round
	
    
#Displaywinner and wait for reset key
GameOver:
    lw $a0, bgColor
    jal ClearScreen         #wipe field

    #CheckIfPlayer1Won
    lw $t0, p1Score
    beq $t0, 5, Winner1     #if p1 score=5, draw P1 win

    #CheckIfPlayer2Won
    lw $t1, p2Score
    beq $t1, 5, Winner2     #if p2 score=5, draw P2 win

    #Fallback:default to winner2 (should not happen)
    j Winner2
        
Winner1:    
    #Drawdigit"1"
    li $a0, 34
    li $a1, 12
    lw $a2, accentColor
    li $a3, 15
    jal VerticalLine        #main stroke

    li $a0, 33
    li $a1, 13
    jal Pixel               #small notch

    li $a1, 16
    li $a3, 35
    jal HorizontalLine      #base line
   
    j  WinnerP
        
Winner2:    
    #Drawdigit"2"
    li $a0, 33
    li $a1, 16
    lw $a2, accentColor
    li $a3, 36
    jal HorizontalLine      #bottom bar

    li $a0, 34
    li $a1, 12
    li $a3, 35
    jal HorizontalLine      #top bar

    li $a1, 15
    jal Pixel               #curve pixels of "2"

    li $a0, 35
    li $a1, 16
    jal Pixel

    li $a1, 14
    jal Pixel

    li $a0, 36
    li $a1, 13
    jal Pixel

    li $a0, 33
    jal Pixel
    
    
    j  WinnerP
        
WinnerP:    
    #Drawletter"P"for"Player"
    li $a0, 27
    li $a1, 12
    li $a3, 16
    jal VerticalLine        #stem of P

    li $a0, 30
    li $a3, 14
    jal VerticalLine        #right side of loop

    li $a0, 28
    li $a3, 29
    jal HorizontalLine      #top of loop

    li $a1, 14
    jal HorizontalLine      #middle of loop

    li $a0, 100
    li $v0, 32
    syscall                 #pause so player can see result
    sw $zero, 0xFFFF0000    #clear keyboard flag

WaitReset:        
    li $a0, 10
    li $v0, 32
    syscall                 #small poll delay
    lw $t0, 0xFFFF0000      #wait for keypress
    beq $t0, $zero, WaitReset
    j  ResetGame
        
ResetGame:        
    sw $zero, p1Score       #reset scores
    sw $zero, p2Score
    sw $zero, 0xFFFF0000    #clear key flag
    sw $zero, 0xFFFF0004    #clear key code
    lw $a0, bgColor
    jal ClearScreen         #clear to field color
    j  NewGame              #go back to title