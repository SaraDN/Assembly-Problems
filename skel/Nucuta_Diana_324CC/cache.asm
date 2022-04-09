;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS


section .text
    global load

; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    xor esi, esi                  
    push eax
    mov eax, edx                 
    shr eax, OFFSET_BITS    ; incerc sa obtin tag-ul in eax        
    ForTags:
    cmp eax, dword [ebx+4*esi]     ;il caut in tags      
    je EInTags                    ;daca exista, fac un jump 
    inc esi           ;cresc esi, care e un soi de i          
    cmp esi, CACHE_LINES    ;vad daca n-am ajuns la final      
    jl ForTags             ;reiterez    
    
    NuEInTags:
    mov [ebx+4*edi], eax      ;daca nu am facut jump mai sus, e clar ca nu e in tags     
    shl eax, OFFSET_BITS         ;pun 000 in coada lui eax care e tag  
    xor esi, esi             ;refac esi 0 ca sa il folosesc iar ca pe un i
    For1:                          
    cmp esi, CACHE_LINE_SIZE       ;daca n-am ajuns la finalul liniei pun in cache 
    jl PuneInCache               
    cmp esi, CACHE_LINE_SIZE       
    je PuneInReg            ;cand ajung la final pun si adresa in reg
    Revii:
    inc esi                 
    jmp For1                   

    PuneInCache:
    push edx   ;eliberez un registru ca nu mai am
    mov dx, [eax+esi] ;salvez in el ce o sa pun in cache
    push ebx  ;in ebx pun adresa de inceput a liniei din cache
    lea ebx, [ecx+8*edi] ;aici
    mov [ebx+esi], dx ;aici pun pe poz esi ce am in dx
    pop ebx
    pop edx
    jmp Revii

    PuneInReg:
    pop eax
    push ebx
    mov bx, [edx]
    mov [eax], bx
    pop ebx
    jmp Exit

    EInTags:
    lea edi, [ecx+8*esi]      ;
    and edx, 7         ;iau ultimii 3 biti din adresa care imi spun al catelea e pe linie
    mov dx, [edi+edx]     ;iau caracterul si il pun in dx    
    pop eax
    mov [eax], dx        ;pun in reg caracterul dx
    jmp Exit
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
Exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY

