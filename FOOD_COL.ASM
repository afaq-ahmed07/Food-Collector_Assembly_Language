[org 0x0100]
jmp start
col : dw 0
count : dd 0
check :dw 3582
check2:dw 3612
chances : dw 5
pos : dw 0
score : dw 0
flagi : dw 1
message: db 'Score:'
b1 : dw 0
b2 : dw 0
limit: dw 0
level:dw 10
pc: db 0
msg2: db 'LEVEL-UPDATE'
count1:dd 0
welcome_message: db ' FOOD COLLECTOR GAME!'
welcome_message_length: dw 22
Over: db 'GAME OVER!'
 OverLength: dw 10
name1:dw 'ROLL NO = 21F-9298'
n1l:dw 18
name2:dw 'ROLL NO = 21F-9143'
cmsg:db 'PRESS LEFT AND RIGHT ARROW TO MOVE THE PADDLE'
rewardflag:db 0
;-----------------clearscreen-----------------------
clearpaddle:
 push es
 push ax
 push di
 push cx
 mov di,3522
mov ax,0xb800
 mov es,ax 
mov ax,0x0020
 phirse:
 mov [es:di],ax
add di,2
cmp di,3678
jne phirse
 
 
 ;popping all values
 pop cx
 pop di
 pop ax
 pop es
 ret
;------------------------------------------------------------;
clearscreen:
 push es
 push ax
 push di
 push cx
 mov ax,0xb800 ; video memory address
 mov es,ax
 mov ax,0x0720 ; color code and space ASCII
 mov di,0
 nextchar:
 mov [es:di],ax
 add di,2
 cmp di,4000
 jne nextchar
mov word [b1],3680
mov word [b2],3840
mov word[limit],2
call printborder
;left side border
mov word [b1],0
mov word [b2],3580
mov word[limit],160
 call printborder
 
 ;right side border
 mov word [b1],158
mov word [b2],3740
mov word[limit],160
call printborder
 
 call printscore
 ;popping all values
 pop cx
 pop di
 pop ax
 pop es
 ret
;------------------------------------------------------;
clearscreen2:
;pint a space at specific position
 push es
 push ax
 push di
 push cx
 mov di,[pos]
mov ax,0xb800
 mov es,ax 
mov ax,0x0020
 mov [es:di],ax
 
 
 ;popping all values
 pop cx
 pop di
 pop ax
 pop es
 ret
;<-----------------START----------------->
start:
call clearscreen
mov dx, 1972
 push dx
 mov dx, welcome_message 
 push dx 
 push word [welcome_message_length]
 call printName
;-------------printing roll no 1
mov dx,3524
push dx
mov dx,name1
push dx
push word [n1l]
call printName
;------------printing roll no 2
mov dx,3364
push dx
mov dx,name2
push dx
push word [n1l]
call printName
 call WelcomeBorder
mov ah, 01
 int 0x21
call clearscreen
;print controls
call printcntrl
 call clearscreen
call paddle
chki:mov word [flagi],1
call ball
cmp word [chances],0
jne chki
call GameOver
mov ax ,0x4c00
int 0x21
 ;<-------------------paddle------------------>;
 
 paddle:
 push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 
mov di,[check]
mov ax,0
 mov ax,0xb800 ; video memory address
 mov es,ax
 mov ax,0x07DC ; color code and space ASCII
 
 nextcharii:
 mov [es:di],ax
 add di,2
 cmp di,[check2]
 jne nextcharii
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 
 
 ;<--------------------BALL---------------------->
ball:
push ax
push bx
push cx
push dx
push di
push es
push si
call RANDSTART
 mov cx,0
 mov ax,80
 mul cx
 add ax,[col]
 shl ax,1
 
 mov cx,0
 mov si,0
 mov dx,ax
 
 
 goagain:
 
add dx,si
mov ax,dx
 mov di,ax
mov ax,0xb800
 mov es,ax 
mov ax,0x076f
 mov [es:di],ax
;interept
mov ah,01h
int 0x16
jz tt
mov ah,00h
int 0x16
cmp ah,0x4B
jne right
left:
call leftkey
right:
cmp ah,0x4D
jne tt
call rightkey
tt:
mov ax,0
;-----delay-----;
mov dword[count],40000
n:
dec dword[count]
cmp dword[count],0
jne n
;---------------;
;ball hit paddle check 
mov bx,dx
mov word [pos],bx
add bx,160 
cmp bx,[check]
jb space
cmp bx,[check2]
ja space
add word [score],2
call printscore
;----------level check
push ax
mov ax,[level]
cmp word [score],ax
jb chaltarahe
;---------level check
inc byte [pc]
cmp byte [pc],3
ja chaltarahe
;-------------update level
call clearscreen
call printlvlupdate
call clearscreen
add word [level],20
add word [check],4
sub word [check2],4
call clearscreen
call paddle
call printreward
cmp byte[rewardflag],1
jne chaltarahe
add word [score],5
call printscore
chaltarahe:
pop ax
mov word [flagi],0
call clearscreen2
jmp exit
space: 
;space printing at ball current location
mov ax,dx
 mov di,ax
mov ax,0xb800
 mov es,ax 
mov ax,0x0020 
 mov [es:di],ax
mov si,160
inc cx
cmp cx ,23
jne goagain
exit:
cmp word [flagi],0
je skipi
dec word [chances]
skipi:
pop si
pop es
pop di
pop dx
pop cx
pop bx
pop ax
ret
;-----------------------------------ball subroutine end here -------------------------------
;
RANDSTART:
push ax
push dx
push cx
push bx
 mov ax, 00h 
int 1AH 
 
 mov ax, dx 
 mov dx,0
 mov bx,78
 mov cx,ax
 div bx
 
 cmp dx,2
 ja janedo
 add dx,1
 janedo:
 mov [col],dx
 pop bx
 pop cx
 pop dx
 pop ax
 
 ret
 
 ;---------------------------leftkey----------------------------------;
 
 leftkey:
 push ax
 mov ax,6
 sub word [check],ax
 sub word [check2],ax
 cmp word [check],3520
 ja temp
 add word [check],ax
 add word [check2],ax
 temp:
 call clearpaddle
 call paddle
 pop ax 
 ret
 
 ;------------------------------------rightkey----------------------------------;
 
 rightkey:
 push ax
 mov ax,6
 add word [check],ax
 add word [check2],ax
 cmp word [check2],3680
 jl temp2
 sub word [check],ax
 sub word [check2],ax
 temp2:
 call clearpaddle
 call paddle
 pop ax 
 ret
 
 
 ;-----------
 printscore:
 push ax
 push bx
 push dx
 push cx
 push es
 push bp
mov ah, 0x13 ; service 13 - print string
mov al, 0 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x1844 ; row 10 column 3
mov cx, 6 ; length of string
push cs
pop es ; segment of string
mov bp, message ; offset of string
int 0x10
 
 ;printing score value
 
 mov ax,[score] 
 mov bx, 10 
 mov cx, 0 
 nextdigit: 
 mov dx, 0 
 div bx 
 add dl, 0x30 
push dx
 inc cx 
 cmp ax, 0 
 jnz nextdigit 
 mov ax, 0xb800 
 mov es, ax 
 mov di,3988
 nextpos: 
pop dx
 mov dh, 0x03 
 mov [es:di], dx 
 add di, 2 
 loop nextpos 
pop bp
pop es
pop cx
pop dx
pop bx
pop ax
ret
;---------
printborder:
 push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 
mov di,[b1]
mov ax,0
 mov ax,0xb800 ; video memory address
 mov es,ax
 mov ax,0x04B2 ; color code and space ASCII
 
 nextchariii:
 mov [es:di],ax
 add di,[limit]
 cmp di,[b2]
 jb nextchariii
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 
 ;----------------------------print level update---------------------;
 printlvlupdate:
 
 push ax
 push bx
 push dx
 push cx
 push es
 push bp
mov ah, 0x13 ; service 13 - print string
mov al, 0 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl,0x83; normal attrib
mov dx, 0x0B22 ; row 10 column 3
mov cx, 12 ; length of string
push cs
pop es ; segment of string
mov bp, msg2 ; offset of string
int 0x10
mov dword[count1],4000000
n1:
dec dword[count1]
cmp dword[count1],0
jne n1
pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 
 ;-----------------------print controls subroutine-----------
 printcntrl:
 push ax
 push bx
 push dx
 push cx
 push es
 push bp
mov ah, 0x13 ; service 13 - print string
mov al, 0 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl,0x03; normal attrib
mov dx, 0x0B0F ; row 10 column 3
mov cx, 45 ; length of string
push cs
pop es ; segment of string
mov bp, cmsg ; offset of string
int 0x10
mov dword[count1],4000000
n12:
dec dword[count1]
cmp dword[count1],0
jne n12
pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 
;----------------------------------
printName:
 push bp
 mov bp, sp
 push es
 push ax
 push cx 
 push si 
 push di 
 mov ax, 0xb800 
 mov es, ax 
 ;// Displaying Score
 ; mov di, 3842 
 mov di, [bp + 8]
 mov si, [bp + 6]
 mov cx, [bp + 4]
 mov ah, 0x02 ; only need to do this once 
 nextchar1: 
 mov al, [si]
 mov [es:di], ax 
 add di, 2 
 add si, 1 
 
 loop nextchar1
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 6 
;-----------------------
WelcomeBorder:
 mov ax, 0xb800 
 mov es, ax 
 mov di, 2126 
 mov ah, 0x04 ; only need to do this once 
 print0: 
 mov al, '-'
 mov [es:di], ax 
 add di, 2
 cmp di, 2190
 jne print0
 mov ah, 0x03
 mov al, 'P'
 mov word [es:2312], ax
 mov al, 'L'
 mov word [es:2314], ax
 mov al, 'A'
 mov word [es:2316], ax
 mov al, 'Y'
 mov word [es:2318], ax
 mov al, '!'
 mov word [es:2320], ax
ret
;--
GameOver:
push cx
push dx
push ax
push bx
push si
push di
 call clearscreen
 mov dx, 1994
 push dx
 mov dx, Over 
 push dx 
 push word [OverLength]
 call printName
pop di
pop si
pop bx
pop ax
pop dx
pop cx
ret 
;---------------reward-----------------
printreward:
push ax
push bx
push cx
push dx
push di
push es
push si
call RANDSTART
 mov cx,0
 mov ax,80
 mul cx
 add ax,[col]
 shl ax,1
 
 mov cx,0
 mov si,0
 mov dx,ax
 goagain2:
add dx,si
mov ax,dx
 mov di,ax
mov ax,0xb800
 mov es,ax 
mov ax,0x0332
 mov [es:di],ax
;interept
mov ah,01h
int 0x16
jz tt1
mov ah,00h
int 0x16
cmp ah,0x4B
jne right2
left2:
call leftkey
right2:
cmp ah,0x4D
jne tt1
call rightkey
tt1:
mov ax,0
;-----delay-----;
mov dword[count],40000
n2:
dec dword[count]
cmp dword[count],0
jne n2
;---------------;
;ball hit paddle check 
mov bx,dx
mov word [pos],bx
add bx,160 
cmp bx,[check]
jb space2
cmp bx,[check2]
ja space2
mov byte [rewardflag],1
call clearscreen2
jmp exit2
space2: 
;space printing at ball current location
mov ax,dx
 mov di,ax
mov ax,0xb800
 mov es,ax 
mov ax,0x0020 
 mov [es:di],ax
mov si,160
inc cx
cmp cx ,23
jne goagain2
exit2:
pop si
pop es
pop di
pop dx
pop cx
pop bx
pop ax
ret