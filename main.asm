.data

#Bitmap Display Setup:
#Unit width in pixels      ---> 8
#Unit Height in pixels     ---> 8
#Display Height in pixels  ---> 512
#Display Height in pixes   ---> 256
#Base address for display  ---> 0x10008000 ($gp)

    xDir:           .word 1      # ball horizontal direction (1=right, -1=left)
	ySpeed:         .word -1     # frames before ball moves vertically
	yDir:           .word -1     # ball vertical direction (1=down, -1=up)
	p1Score:        .word 0
	p2Score:        .word 0
	aiCounter:      .word 0
	aiSpeed:        .word 0      # AI reaction speed (set after first paddle hit)
	difficulty:     .word 6
	color1:         .word 0x000C2340   # Auburn navy
	color2:         .word 0x00DC143C   # Alabama crimson
	ballColor:      .word 0x895959
	bgColor:        .word 0x4CA450     # field green
	titleBG:        .word 0x000A5F0A   # title
	accentColor:    .word 0x00ffffff   # white
	gameMode:       .word 0           # 1=single player, 2=two player
	white:          .word 0x00ffffff
	orange:         .word 0x00E87722 
	yellow:         .word 0x00FFFF00
    	paddleHeight:   .word 10          # default paddle height
   	ballFrameSkip:  .word 1           # used to slow ball in 2P mode

.text

NewGame:
	lw  $a0, titleBG 
	jal ClearScreen

	#Football 
	Lines:
	#Blue line
		li $a0, 0
		li $a1, 13 
		lw $a2, orange
		li $a3, 70
		jal HorizontalLine
		
		li $a1, 14
		jal HorizontalLine
		
		li $a0, 0
		li $a1, 15
		lw $a2, accentColor
		li $a3, 70
		jal HorizontalLine
		
		li $a1, 16 
		jal HorizontalLine
		
		li $a0, 0
		li $a1, 17
		lw $a2, color1
		li $a3, 63
		jal HorizontalLine
		
		li $a1, 18
		jal HorizontalLine
		
FieldGoals: 
#feild goal 1
	li $a0, 2
	li $a1, 6
	lw $a2, yellow
	li $a3, 8
	jal HorizontalLine
	
	li $a0, 2
	li $a1, 1
	lw $a2, yellow
	li $a3, 5
	jal VerticalLine
	
	li $a0, 8
	li $a1, 1
	lw $a2, yellow
	li $a3, 5
	jal VerticalLine
	
	li $a0, 5
	li $a1, 6
	lw $a2, yellow
	li $a3, 10
	jal VerticalLine
	
	
#field goal 2	
	li $a0, 52
	li $a1, 6
	lw $a2, yellow
	li $a3, 58
	jal HorizontalLine
		
	li $a0, 52
	li $a1, 1
	lw $a2, yellow
	li $a3, 5
	jal VerticalLine
	
	li $a0, 58
	li $a1, 1
	lw $a2, yellow
	li $a3, 5
	jal VerticalLine
		
	li $a0, 55
	li $a1, 6
	lw $a2, yellow
	li $a3, 10
	jal VerticalLine	
	# Draw "PONG" title
	# Replace the DrawTitle section with this code:

DrawTitle: # Beat Bama

#a0 = left to right
#a1 = up and down

	# Draw "B" 
	li $a0, 12
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a1, 5
	li $a3, 13
	jal HorizontalLine
	
	li $a1, 7
	li $a3, 14
	jal HorizontalLine
	
	li $a1, 9
	li $a3, 13
	jal HorizontalLine
	
	li $a0, 14
	li $a1, 6
	jal Pixel
	
	li $a1, 8
	jal Pixel
	
	#E
	li $a0, 16
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 17
	li $a1, 9
	jal Pixel
	
	li $a0, 18
	li $a1, 9
	jal Pixel
	
	li $a0, 17
	li $a1, 7
	jal Pixel
	
	li $a0, 17
	li $a1, 5
	jal Pixel
	li $a0, 18
	li $a1, 5
	jal Pixel
	
	#A
	li $a0, 20
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 22
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 21
	li $a1, 7
	jal Pixel
	li $a0, 21
	li $a1, 5
	jal Pixel
	
	#T
	li $a0, 25
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 24
	li $a1, 5
	jal Pixel
	li $a0, 26
	li $a1, 5
	jal Pixel
	
	#B (for bama)
	li $a0, 31
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 32
	li $a1, 5
	jal Pixel
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
	
	#A
	li $a0, 35
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 36
	li $a1, 5
	jal Pixel
	li $a0, 36
	li $a1, 7
	jal Pixel
	
	li $a0, 37
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	#M
	li $a0, 39
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 40
	li $a1, 6
	jal Pixel
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
	jal VerticalLine
	
	#A
	li $a0, 45
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	li $a0, 46
	li $a1, 5
	jal Pixel
	li $a0, 46
	li $a1, 7
	jal Pixel
	
	li $a0, 47
	li $a1, 5
	lw $a2, white
	li $a3, 9
	jal VerticalLine
	
	#1-Main 2-Catch
	DrawInstructions:
          #1 
	li $a0, 3
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	#"-"
	li $a0, 5
	li $a1, 26
	jal Pixel
        li $a0, 6
	li $a1, 26
	jal Pixel

	#M (for Main)
	li $a0, 8
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	li $a0, 9
	li $a1, 25
	jal Pixel
	li $a0, 10
	li $a1, 26
	jal Pixel
	li $a0, 11
	li $a1, 25
	jal Pixel
	
	li $a0, 12
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	#A
	li $a0, 14
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	li $a0, 15
	li $a1, 24
	jal Pixel
	li $a0, 15
	li $a1, 26
	jal Pixel
	
	li $a0, 16
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	#I
	li $a0, 18
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	#N
	li $a0, 20
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	li $a0, 21
	li $a1, 25
	jal Pixel
	li $a0, 22
	li $a1, 26
	jal Pixel
	
	li $a0, 23
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	#2
	li $a0, 34
	li $a1, 24
	jal Pixel
	li $a0, 35
	li $a1, 24
	jal Pixel
	li $a0, 36
	li $a1, 24
	jal Pixel
	
	li $a0, 36
	li $a1, 25
	jal Pixel
	
	li $a0, 34
	li $a1, 26
	jal Pixel
	li $a0, 35
	li $a1, 26
	jal Pixel
	li $a0, 36
	li $a1, 26
	jal Pixel
	
	li $a0, 34
	li $a1, 27
	jal Pixel
	
	li $a0, 34
	li $a1, 28
	jal Pixel
	li $a0, 35
	li $a1, 28
	jal Pixel
	li $a0, 36
	li $a1, 28
	jal Pixel
	
	# "-"
	li $a0, 38
	li $a1, 26
	jal Pixel
	li $a0, 39
	li $a1, 26
	jal Pixel
	
	# C (for catch)
	li $a0, 41
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	li $a0, 42
	li $a1, 28
	jal Pixel
	li $a0, 43
	li $a1, 28
	jal Pixel
	
	li $a0, 42
	li $a1, 24
	jal Pixel
	li $a0, 43
	li $a1, 24
	jal Pixel
	
	# A
	li $a0, 45
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	li $a0, 46
	li $a1, 24
	jal Pixel
	li $a0, 46
	li $a1, 26
	jal Pixel
	
	li $a0, 47
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	# T
	li $a0, 50
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	li $a0, 49
	li $a1, 24
	jal Pixel
	li $a0, 51
	li $a1, 24
	jal Pixel
	
	# C
	li $a0, 53
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

	li $a0, 54
	li $a1, 24
	jal Pixel
	li $a0, 55
	li $a1, 24
	jal Pixel
	
	li $a0, 54
	li $a1, 28
	jal Pixel
	li $a0, 55
	li $a1, 28
	jal Pixel
	
	# H
	li $a0, 57
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine
	
	li $a0, 58
	li $a1, 26
	jal Pixel
	
	li $a0, 59
	li $a1, 24
	lw $a2, white
	li $a3, 28
	jal VerticalLine

        
# Wait for player to select game mode
SelectMode:
    lw $t1, 0xFFFF0004        # check which key was pressed
    beq $t1, 0x31, Set1Player # '1' pressed
    beq $t1, 0x32, Set2Player # '2' pressed
        
    li $a0, 250
    li $v0, 32                # pause 250ms
    syscall
        
    j SelectMode
        
Set1Player:
    li $t1, 1
    j StartGame

Set2Player:
    li $t1, 2

StartGame:
    sw $zero, 0xFFFF0000      # clear button state
    sw $t1, gameMode
        

######################
# NEW ROUND / SETUP
######################
# $s0 = player 1 direction
# $s1 = player 2 direction (or AI)
# $s2 = ball x velocity counter
# $s3 = ball y velocity counter
# $s4 = paddle 1 position (y-top)
# $s5 = paddle 2 position (y-top)
# $s6 = ball x position
# $s7 = ball y position
NewRound:
    # Initialize round variables
    li $t0, 1
    li $t1, -1
    sw $t0, ySpeed
    sw $t1, yDir
    sw $zero, aiSpeed
    sw $zero, aiCounter
        
    li $s0, 0           # no movement
    li $s1, 0
    lw $s2, xDir
    lw $s3, ySpeed
    li $s4, 13          # center paddles
    li $s5, 13
    li $s6, 32          # center ball
    li $s7, 0
    
    # Set paddle height based on game mode (bigger in 2P)
    lw  $t0, gameMode
    bne $t0, 2, SetNormalPaddle

    li  $t1, 14               # taller paddles in 2-player mode
    sw  $t1, paddleHeight
    j   DoneSetPaddle

SetNormalPaddle:
    li  $t1, 10               # default height in 1-player mode
    sw  $t1, paddleHeight

DoneSetPaddle:
    li  $t2, 1                # reset ball frame skip counter
    sw  $t2, ballFrameSkip

    lw $a0, bgColor
    jal ClearScreen

    # draw football field yard lines (uses GetFieldColor)
    jal DrawYardLines
        
    # Draw scores
    lw $a2, p1Score
    li $a3, 1
    jal DrawScore

    lw $a2, p2Score
    li $a3, 54
    jal DrawScore
        
    # Draw paddles
    li $a0, 7          # left paddle x
    move $a1, $s4
    lw $a2, color1
    jal DrawPaddle
        
    li $a0, 55         # right paddle x
    move $a1, $s5
    lw $a2, color2
    jal DrawPaddle

    li $a0, 1000
    li $v0, 32          # 1 second countdown
    syscall

######################
# MAIN GAME LOOP
######################
GameLoop:
    # In 2-player mode, only move the ball every 2 frames
    lw  $t0, gameMode
    bne $t0, 2, DoBallNow      # if not 2P, normal speed

    lw   $t1, ballFrameSkip
    addi $t1, $t1, -1
    sw   $t1, ballFrameSkip    # <<< store decremented value
    bgtz $t1, SkipBall         # if still > 0, skip moving ball
    li   $t1, 2                # reset counter: move ball every 2 frames
    sw   $t1, ballFrameSkip

DoBallNow:
    move $a0, $s6
    move $a1, $s7
    jal  CheckCollisions
    jal  MoveBall
    j    UpdatePaddles

SkipBall:
    # don't move ball this frame, just update paddles & inputs
    j    UpdatePaddles

UpdatePaddles:
    # Update player 1 paddle
    li  $a0, 7          # left paddle x
    move $a1, $s4       # current top y
    lw   $a2, color1
    move $a3, $s0       # direction from input
    jal  DrawPaddle
    move $s4, $a1       # save new y position
    move $s0, $a3       # keep updated direction

    # Update player 2 paddle or AI
    li  $a0, 55         # right paddle x
    move $a1, $s5
    lw   $a2, color2

UpdateAI:
    lw $t1, gameMode
    bne $t1, 1, UpdatePlayer2   # skip AI if 2-player mode
        
    lw $t0, aiCounter
    addi $t0, $t0, -1
    sw $t0, aiCounter
    bgt $t0, 0, UpdatePlayer2
        
    lw $t0, aiSpeed
    sw $t0, aiCounter
    addi $t1, $s5, 2    # paddle middle
    blt $t1, $s7, MoveAIDown
    li  $s1, 0x01000000  # move up
    j UpdatePlayer2

MoveAIDown: 
    li $s1, 0x02000000  # move down
        
UpdatePlayer2:
    move $a3, $s1
    jal DrawPaddle
    move $s5, $a1
    move $s1, $a3
        
        
######################
# INPUT HANDLING
######################
WaitForInput:    
    li $t0, 2           # ~20ms wait cycles
    
InputLoop:
    blez $t0, EndWait
    li $a0, 10
    li $v0, 32          # 10ms pause
    syscall
        
    addi $t0, $t0, -1
        
    lw $t1, 0xFFFF0000  # check for keypress
    blez $t1, InputLoop
                
    jal HandleInput
    sw $zero, 0xFFFF0000
    j InputLoop
        
EndWait:        
    j GameLoop
        
######################
# DRAW PADDLE
######################
# $a0 = x position, $a1 = y position (top)
# $a2 = color, $a3 = direction
# Returns: $a1 = new position, $a3 = new direction
DrawPaddle:
    beq $a3, 0x02000000, MoveDown
    bne $a3, 0x01000000, NoMove
    
MoveUp:
    # erase bottom pixel of paddle (height-1)
    move $t2, $a2          # save paddle color
    move $t1, $a1          # save original y
    lw   $t0, paddleHeight
    addi $t0, $t0, -1
    addu $a1, $a1, $t0     # y of bottom pixel

    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  GetFieldColor     # background color at (a0, a1)
    move $a2, $v0
    jal  Pixel             # restore background (line or grass)
    lw   $ra, 0($sp)
    addi $sp, $sp, 4

    move $a1, $t1          # restore y
    move $a2, $t2          # restore paddle color
           
    # move up (if not at top)
    beq $a1, 0, NoMove
    addi $a1, $a1, -1
    j DrawPaddlePixels
        
MoveDown:
    # erase top pixel
    move $t1, $a2          # save paddle color

    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  GetFieldColor     # background color at (a0, a1)
    move $a2, $v0
    jal  Pixel             # restore background
    lw   $ra, 0($sp)
    addi $sp, $sp, 4

    move $a2, $t1          # restore paddle color
           
    # move down (if not at bottom)
    # screen 0–31, last top = 32 - paddleHeight
    lw  $t0, paddleHeight
    li  $t1, 32
    sub $t1, $t1, $t0      # max top row for paddle
    beq $a1, $t1, NoMove
    addi $a1, $a1, 1
    j DrawPaddlePixels    

NoMove:
    li $a3, 0               # stop movement

DrawPaddlePixels:
    lw $t0, paddleHeight    # paddle height
PaddleLoop:
    subi $t0, $t0, 1
    addu $t1, $a1, $t0
        
    # convert to memory address
    sll $t1, $t1, 6         # y * 64
    addu $v0, $a0, $t1
    sll $v0, $v0, 2
    addu $v0, $v0, $gp
        
    sw $a2, ($v0)
    beqz $t0, PaddleDone
    j PaddleLoop
        
PaddleDone:        
    jr $ra

######################
# DRAW SCORE
######################
# $a2 = score value, $a3 = leftmost column
DrawScore:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s2, 4($sp)
    sw $a2, 8($sp)
           
    move $s2, $a2
    lw $a2, ballColor
    ble $s2, 5, ScoreRow1
           
ScoreRow2:              # second row (scores 6-10)
    sub $t1, $s2, 6
    sll $t1, $t1, 1
    add $a0, $t1, $a3
    li $a1, 3
    jal Pixel
    addi $s2, $s2, -1
    bge $s2, 6, ScoreRow2
           
ScoreRow1:              # first row (scores 1-5)
    beq $s2, $zero, ScoreDone
    sub $t1, $s2, 1
    sll $t1, $t1, 1
    add $a0, $t1, $a3
    li $a1, 1
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
# MOVE BALL
######################
# $a0 = x, $a1 = y    
MoveBall:        
    # erase old position with proper background (line or grass)
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # a0,a1 are old ball position from caller
    jal  GetFieldColor       # -> v0 = background color here
    move $a2, $v0
    jal  Pixel               # restore background pixel

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
           
    add $s6, $s6, $s2       # update x
           
    # update y based on speed counter
    addi $s3, $s3, -1
    bgt  $s3, 0, SkipY
           
UpdateY:
    lw $t0, yDir    
    add $s7, $s7, $t0
    lw $s3, ySpeed
        
SkipY:
    # draw new position (fall-through into Pixel)
    move $a0, $s6
    move $a1, $s7
    lw   $a2, ballColor
        
######################
# PIXEL / LINES
######################
# Draw single pixel
# $a0 = x, $a1 = y, $a2 = color
Pixel:
    sll $t0, $a1, 6         # y * 64
    addu $v0, $a0, $t0
    sll $v0, $v0, 2
    addu $v0, $v0, $gp
    sw  $a2, ($v0)
    jr  $ra

# Draw horizontal line
# $a0 = x start, $a1 = y, $a2 = color, $a3 = x end
HorizontalLine:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
        
    sub  $t9, $a3, $a0
    move $t1, $a0
        
HLineLoop:
    add $a0, $t1, $t9
    jal Pixel
    addi $t9, $t9, -1
    bge $t9, 0, HLineLoop
        
    lw  $ra, 0($sp)
    addi $sp, $sp, 4
    jr  $ra
        
# Draw vertical line
# $a0 = x, $a1 = y start, $a2 = color, $a3 = y end
VerticalLine:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
        
    sub  $t9, $a3, $a1
    move $t1, $a1
        
VLineLoop:
    add $a1, $t1, $t9
    jal Pixel
    addi $t9, $t9, -1
    bge $t9, 0, VLineLoop
        
    lw  $ra, 0($sp)
    addi $sp, $sp, 4
    jr  $ra

######################
# FIELD BACKDROP (YARD LINES)
######################
# Fills the whole 64x32 field using GetFieldColor,
# so the static backdrop and erase logic always match.
DrawYardLines:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $t2, 0          # y = 0

DY_RowLoop:
    li   $t3, 0          # x = 0 for each row

DY_ColLoop:
    move $a0, $t3        # a0 = x
    move $a1, $t2        # a1 = y
    jal  GetFieldColor   # v0 = background color for this pixel

    move $a0, $t3        # Pixel(x,y,color)
    move $a1, $t2
    move $a2, $v0
    jal  Pixel

    addi $t3, $t3, 1           # x++
    blt  $t3, 64, DY_ColLoop   # while x < 64

    addi $t2, $t2, 1           # y++
    blt  $t2, 32, DY_RowLoop   # while y < 32

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

######################
# GET FIELD COLOR (BACKGROUND)
######################
# IN:  a0 = x, a1 = y
# OUT: v0 = color (bgColor or accentColor for yard lines)
GetFieldColor:
    lw  $v0, bgColor          # default: grass green

    li  $t5, 10               # number of yardline positions
    li  $t6, 0                # line index i = 0..9
    li  $t7, 4                # starting x (first line on left)
    li  $t8, 6                # spacing between lines

GF_Loop:
    bge $t6, $t5, GF_Done     # checked all lines

    beq $a0, $t7, GF_OnThisLine   # are we on this yardline x?

    addu $t7, $t7, $t8        # next line x
    addi $t6, $t6, 1
    j    GF_Loop

# Decide what kind of line this is and whether to paint here
GF_OnThisLine:
    andi $t9, $t6, 1          # t9 = i & 1 (0 = even, 1 = odd)

    beq  $t9, $zero, GF_FullLine   # even index -> full-height line

    # odd index -> tick line: only paint at top or bottom
    beq  $a1, $zero, GF_SetAccent  # y == 0 (top)
    li   $t0, 31
    beq  $a1, $t0, GF_SetAccent    # y == 31 (bottom)
    j    GF_Done                   # middle rows: stay grass

GF_FullLine:
GF_SetAccent:
    lw  $v0, accentColor      # white yard line / tick color

GF_Done:
    jr  $ra


######################
# INPUT KEYS
######################
HandleInput: 
    lw $a0, 0xFFFF0004
        
    bne $a0, 97, CheckZ      # 'a'
    li  $s0, 0x01000000      # p1 up
    j   InputDone

CheckZ:
    bne $a0, 122, CheckK     # 'z'
    li  $s0, 0x02000000      # p1 down
    j   InputDone

CheckK:
    bne $a0, 107, CheckM     # 'k'
    li  $s1, 0x01000000      # p2 up
    j   InputDone

CheckM:
    bne $a0, 109, InputDone  # 'm'
    li  $s1, 0x02000000      # p2 down

InputDone:
    jr $ra

######################
# COLLISIONS
######################
# $a0 = ball x, $a1 = ball y
CheckCollisions:
    beq $s6, 0,  P1Loses
    beq $s6, 63, P2Loses
    bne $s6, 8, CheckRightPaddle
        
CheckLeftPaddle:
    blt $s7, $s4, CheckWalls
    lw   $t0, paddleHeight
    addi $t0, $t0, -1
    addu $t3, $s4, $t0          # paddle bottom (top + height-1)

    bgt $s7, $t3, CheckWalls

    # raw hit position on paddle: 0 .. paddleHeight-1
    sub  $t3, $s7, $s4

    # scale hit position to 0..5 regardless of paddleHeight
    # t2 = t3 * 6
    lw   $t0, paddleHeight      # t0 = paddleHeight
    li   $t1, 6
    mul  $t2, $t3, $t1          # t2 = t3 * 6
    div  $t2, $t0               # t2 / paddleHeight
    mflo $t3                    # t3 = scaled zone 0..5

    li  $s2, 1                  # ball now going right
    j   PaddleHit
           
CheckRightPaddle:
    bne $s6, 54, CheckWalls
    blt $s7, $s5, CheckWalls
    lw   $t0, paddleHeight
    addi $t0, $t0, -1
    addu $t3, $s5, $t0          # paddle bottom
    bgt $s7, $t3, CheckWalls

    # raw hit position on paddle: 0 .. paddleHeight-1
    sub  $t3, $s7, $s5

    # scale hit position to 0..5 regardless of paddleHeight
    lw   $t0, paddleHeight      # t0 = paddleHeight
    li   $t1, 6
    mul  $t2, $t3, $t1          # t2 = t3 * 6
    div  $t2, $t0               # t2 / paddleHeight
    mflo $t3                    # t3 = scaled zone 0..5

    li  $s2, -1                 # ball now going left
    j   PaddleHit     

CheckWalls:
    beq $s7, 31, WallHit
    bne $s7, 0,  NoBounce
        
WallHit: 
    # (placeholder for sound)
    addi $sp, $sp, -8
    sw   $a0, 0($sp)
    sw   $a1, 4($sp)
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    addi $sp, $sp, 8
           
    # flip y direction
    bgt $s3, 1, NoBounce
    lw  $t4, yDir
    xori $t4, $t4, 0xffffffff
    addi $t4, $t4, 1
    sw  $t4, yDir
        
NoBounce:
    jr $ra
        
PaddleHit: 
    # play hit sound
    addi $sp, $sp, -8
    sw   $a0, 0($sp)
    sw   $a1, 4($sp)
    li   $a0, 80
    li   $a1, 80
    li   $a2, 32
    li   $a3, 127
    li   $v0, 31
    syscall
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    addi $sp, $sp, 8
        
    # set AI speed after first hit
    lw $t4, difficulty
    sw $t4, aiSpeed
        
    # adjust angle based on hit position
    beq $t3, 0, AngleSteep
    beq $t3, 1, AngleMedium
    beq $t3, 2, AngleShallow
    beq $t3, 3, AngleShallow2
    beq $t3, 4, AngleMedium2
    beq $t3, 5, AngleSteep2
        
AngleSteep:
    li $s3, 1
    sw $s3, ySpeed
    li $s3, -1
    sw $s3, yDir
    j  CheckWalls

AngleMedium:
    li $s3, 2
    sw $s3, ySpeed
    li $s3, -1
    sw $s3, yDir
    j  CheckWalls

AngleShallow:
    li $s3, 4
    sw $s3, ySpeed
    li $s3, -1
    sw $s3, yDir
    j  CheckWalls

AngleShallow2:
    li $s3, 4
    sw $s3, ySpeed
    li $s3, 1
    sw $s3, yDir
    j  CheckWalls

AngleMedium2:
    li $s3, 2
    sw $s3, ySpeed
    li $s3, 1
    sw $s3, yDir
    j  CheckWalls

AngleSteep2:
    li $s3, 1
    sw $s3, ySpeed
    li $s3, 1
    sw $s3, yDir
    j  CheckWalls

######################
# CLEAR SCREEN
######################
# Clear entire screen to color in $a0
ClearScreen:
    move $t0, $a0           # color
    li   $t1, 8192          # total bytes
ClearLoop:
    subi $t1, $t1, 4
    addu $t2, $t1, $gp
    sw   $t0, ($t2)
    beqz $t1, ClearDone
    j    ClearLoop

ClearDone:
    jr $ra
        
######################
# SCORING / GAME OVER
######################
P1Loses:
    lw   $t1, p2Score
    addi $t1, $t1, 1
    sw   $t1, p2Score
    li   $t2, 1
    sw   $t2, xDir
    li   $a3, 54
    sw   $zero, 0xFFFF0004
    beq  $t1, 10, GameOver
    j    ScoreSound
        
P2Loses:    
    lw   $t1, p1Score
    addi $t1, $t1, 1
    sw   $t1, p1Score
    li   $t2, -1
    sw   $t2, xDir
    li   $a3, 1
    sw   $zero, 0xFFFF0004
    beq  $t1, 10, GameOver

ScoreSound:
    li $a0, 80
    li $a1, 300
    li $a2, 121
    li $a3, 127
    li $v0, 31
    syscall
    j  NewRound
    
# Display winner and wait for reset
GameOver:
    lw $a0, bgColor
    jal ClearScreen
        
    lw $t0, p1Score
    bne $t0, 10, Winner2
        
Winner1:    
    li $a0, 34
    li $a1, 12
    lw $a2, accentColor
    li $a3, 15
    jal VerticalLine

    li $a0, 33
    li $a1, 13
    jal Pixel

    li $a1, 16
    li $a3, 35
    jal HorizontalLine
    j  WinnerP
        
Winner2:    
    li $a0, 33
    li $a1, 16
    lw $a2, accentColor
    li $a3, 36
    jal HorizontalLine

    li $a0, 34
    li $a1, 12
    li $a3, 35
    jal HorizontalLine

    li $a1, 15
    jal Pixel

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
        
WinnerP:    
    li $a0, 27
    li $a1, 12
    li $a3, 16
    jal VerticalLine

    li $a0, 30
    li $a3, 14
    jal VerticalLine

    li $a0, 28
    li $a3, 29
    jal HorizontalLine

    li $a1, 14
    jal HorizontalLine

    li $a0, 100
    li $v0, 32
    syscall
    sw $zero, 0xFFFF0000

WaitReset:        
    li $a0, 10
    li $v0, 32
    syscall
    lw $t0, 0xFFFF0000
    beq $t0, $zero, WaitReset
    j  ResetGame
        
ResetGame:        
    sw $zero, p1Score
    sw $zero, p2Score
    sw $zero, 0xFFFF0000
    sw $zero, 0xFFFF0004
    lw $a0, bgColor
    jal ClearScreen
    j  NewGame
