; a short program to check how
; set and get pixel color works

name "pixel"

org  100h

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
int 10h     ; set it!



;0      0000      black
;1      0001      blue
;2      0010      green
;3      0011      cyan
;4      0100      red
;5      0101      magenta
;6      0110      brown
;7      0111      light gray
;8      1000      dark gray
;9      1001      light blue
;A      1010      light green
;B      1011      light cyan
;C      1100      light red
;D      1101      light magenta
;E      1110      yellow
;F      1111      white

jmp cadre ;pixel pour pas ce faire chier
var:

; dimensions of the rectangle:
; width: 10 pixels
; height: 5 pixels

w equ 319
h equ 199


cadre:
; draw upper line:

    mov cx, 0+w  ; column
    mov dx, 0     ; row
    mov al, 1101b     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    jae u1
 

 
; draw left line:

    mov cx, 0    ; column
    mov dx, 0+h   ; row
    mov al, 1101b     ; white
u3: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 1
    ja u3 
    
    
; draw right line:

    mov cx, 0+w  ; column
    mov dx, 0+h   ; row
    mov al, 1101b     ; white
u4: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 1
    ja u4     
	
; draw bottom line:

    mov cx, 0+w  ; column
    mov dx, 0+h   ; row
    mov al, 1101b     ; white
u2: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    ja u2

;ICI ON fait les pixels
pixel:
;10x10
mov cx, 08  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 11  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 12  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 13  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 14  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 15  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 16  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 19  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 08  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 11  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 12  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 13  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 14  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 15  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 16  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 19  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 09  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

;colum 10
mov cx, 10  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 11  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 13  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 14  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 15  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 16  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 19  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 20  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 10  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

;column11


mov cx, 11  ; column
mov dx, 10  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 13  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 14  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 16  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 11  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

;colunm 12

mov cx, 12  ; column
mov dx, 10  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 12  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 13  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 14  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 16  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 17  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 12  ; column
mov dx, 22  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 13

mov cx, 13  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 13  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 14  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 16  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 17  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 18  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 20  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 21  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 13  ; column
mov dx, 22  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 14

mov cx, 14  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 13  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 14  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 16  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 17  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 18  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 20  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 14  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 15

mov cx, 15  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 13  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 14  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 16  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 17  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 18  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 20  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 15  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 16

mov cx, 16  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 12  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 13  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 14  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 16  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 17  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 18  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 20  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 21  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 16  ; column
mov dx, 22  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 17

mov cx, 17  ; column
mov dx, 10  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 13  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 14  ; row
mov al, 0000b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 16  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 17  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 17  ; column
mov dx, 22  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 18

mov cx, 18  ; column
mov dx, 10  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 11  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 13  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 14  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 15  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 16  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 19  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 18  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h
;colunm 19

mov cx, 19  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 11  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 12  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 13  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 14  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 15  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 16  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 19  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 20  ; row
mov al, 1100b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 19  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 11  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 12  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 13  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 14  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 15  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 16  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 19  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 20  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 10  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 11  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 12  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 13  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 14  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 15  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 16  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 17  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 18  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 19  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 20  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 21  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 21  ; column
mov dx, 22  ; row
mov al, 0111b  ; red
mov ah, 0ch ; put pixel
int 10h


;jmp     game_loop


; pause the screen for dos compatibility:

;wait for keypress
  mov ah,00
  int 16h			


  

	
ret

