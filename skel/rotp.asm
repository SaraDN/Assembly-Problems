section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    xor     eax, eax
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
cipher:
     
     mov bl, [esi+eax]    ;luam elementul de pe poz eax din plaintext
     xor bl, [edi+ecx-1]  ;facem xor cu cel de pe poz key+len-1
     mov [edx+eax], bl     ;punem in ciphertext pe poz eax
     add eax, 1             ;crestem eax
     dec ecx                ;decrementam len
     cmp ecx, 0             ;comparam len cu 0
     jne cipher             ;daca nu e 0, iteram iar

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY