_code segment
assume  cs:_code, ds:_data

start:
mov    ax,_data
mov    ds,ax

mov dx, offset textpodaj
mov ah,09h
int 21h

mov dx,offset max
mov ah,0ah
int 21h

xor bx,bx
mov cl,znaki[bx]
mov len,cl

xor ch,ch
mov bx, cx
walidacja:
mov cl, znaki[bx]
cmp cl,39h
jg blad
cmp cl,2Fh
jle blad
dec bx
jnz walidacja


xor dx,dx
mov ah,02h ;new line
mov dl,0ah
int 21h
mov dl,0dh
int 21h


xor dx,dx
xor ax,ax
xor bx,bx
mov dl,len
xor si,si
znakdorejestru:
xor cx,cx
inc si
add cx,dx
sub cx,si
mov bx,0ah
mov ax,1h
cmp si,dx
jz jednosc
razydziesiec:
mul bx
dec cl
jnz razydziesiec
jednosc:
mov bl,znaki[si]
sub bl,30h
mul bx
jc blad   
add hex,ax
jc blad
jmp pomin
blad:
xor ax,ax
xor dx,dx
mov ah,02h ;new line
mov dl,0ah
int 21h
mov dl,0dh
int 21h
mov     dx,offset textblad
mov     ah,09h
int     21h
jmp koniec
pomin:
mov dl,len
cmp si,dx
jnz znakdorejestru

mov dx, offset textbin
mov ah,09h
int 21h


xor cx,cx
mov ax,hex
dec cl
wpisywaniebin:
mov bx,2
xor dx,dx
div bx
xor bx,bx
inc cl
mov bl,cl
add dl,30h
mov bin[bx],dl
cmp ax,0
jnz wpisywaniebin

xor ax,ax
xor bx,bx
mov ah,02h
wypisywaniebin:
mov bx,cx
mov dl,bin[bx]
int 21h
cmp cx,0
jz wypiszero
loop wypisywaniebin
mov dl,bin[bx+1]
int 21h

wypiszero:

xor ax,ax
xor bx,bx
xor dx,dx
xor cx,cx
mov ax,hex
mov cx,4
wpisywaniehex:
mov bx,16
div bx
mov bx,cx
dec bx
mov hexascii[bx],dl
loop wpisywaniehex

xor ax,ax
xor dx,dx
mov ah,02h ;new line
mov dl,0ah
int 21h
mov dl,0dh
int 21h

mov dx, offset texthex
mov ah,09h
int 21h

xor dx,dx
xor ax,ax
xor bx,bx
xor cx,cx
mov cx,4
mov ah,02h


wypisywaniehex:
mov dl,hexascii[bx]
;zmiana na ascii
cmp bx,3
jz wiekszemniejesze
cmp dx,0 
jz pierwszezero
mov dh,1
jmp wiekszemniejesze
mniejsze:
add dl,30h
jmp koniechex
wiekszemniejesze:
cmp dl,9
jng mniejsze
add dl,37h
jmp koniechex
koniechex:
int 21h
pierwszezero:
inc bx
loop wypisywaniehex

koniec:
mov    ah,4ch
mov    al,0
int    21h

_code ends
_data segment
textpodaj	db	'Podaj liczbe (0-65 535): $'
textbin		db	'Liczba binarna: $'
texthex		db	'Liczba hex: $'
len             db    ?
hex         dw  0h
hexascii db 4 dup(0)
textblad        db    'blad$'
max             db    6
znaki           db    6 dup(0)
bin db           16 dup(0)
_data ends

end start

