
section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    xor eax, eax ;i
    xor ecx, ecx ;p
    ForKey:
    cmp ecx, [len_cheie] ;vedem daca am ajuns la final
    jl Cipher ;daca nu, mergem la 
    jge Exit 
    ForKeyAici:
    inc ecx ;incrementam eax 
    jmp ForKey ;iteram iar

    Cipher:
    push eax ;din lipsa de registre, il punem pe stiva pe eax
    mov eax, [edi+ecx*4] ;merg in vectorul de chei pe poz i
    mov dl, [esi+eax] ;ma situez in vectorul meu haystack pe poz key[eax]
    pop eax 
    mov [ebx+eax], dl ;pun in cihpertext pe poz eax litera din haystack
    mov edx, [edi+ecx*4] ;o sa folosesc edx ca pe o un i 

    For2:
    cmp edx, [len_haystack] ;compar edx cu lungimea heystack
    jl Cipher2   ;daca e mai mica, o sa merg din edx in edx prin haystack si pun in ebx carcacterul
    jge ForKeyAici ;daca nu, revenim la "for"-ul initial
    For2Aici:
    add edx, [len_cheie] ;crestem edx cu lungimea cheii
    jmp For2 ;iterez iar

    Cipher2:
    push ecx ;imi eliberez un registru ca nu mai am
    mov cl, [esi+edx] ;salvam caracterul din haystack
    mov [ebx+eax], cl ;si il punem in ciphertext
    pop ecx
    inc eax ;cresteam "i"-ul
    jmp For2Aici

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    Exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY
