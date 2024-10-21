Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik

start:
;////////////////////////////////////////////////////
                ; Clear screen
                mov     ax,0600h
                mov     bh,7
                mov     cx,0
                mov     dx,184fh
                int     10h

                mov     bl,5
                mov     bh,0
                mov     dh,1
                mov     dl,40
                mov     al,65
                mov     cx,1

                mov     di,24
piramida:
                mov     ah,2
                int     10h
                mov     ah,9
                int     10h

                inc     dh
                dec     dl
                inc     al
                add     cx,2
                inc     bl

                dec     di
                jnz     piramida
;////////////////////////////////////////////////////
                mov     ah,4ch
                mov     al,0
                int     21h

Progr           ends

dane            segment

dane            ends

stosik          segment

stosik          ends


end