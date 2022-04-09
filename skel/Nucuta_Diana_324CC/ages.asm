; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

;void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    xor eax, eax    ;eax e i-ul meu
    For:
    cmp eax, edx    ;vedem daca am ajuns pe poz len
    jl IntAge       ;daca nu, incercam sa aflam age
    jge Leave       ;daca da, terminam codul
    ForAici:        ;ne reintoarcem sa continuam sa iteram
    inc eax         ;crestem eax
    jmp For

    IntAge: 
    mov ebx, [esi + my_date.year]  ;ebx e age
    push edx    ;din lipsa de registre, folosesc edx
    lea edx, [edi + eax*my_date_size] ; edx e diferenta anilor
    sub ebx, [edx + my_date.year]
    ;if1
    push eax
    mov ax, [edx + my_date.month] 
    cmp ax, [esi + my_date.month] ;verific lunile, deoarece este poisbil ca anii sa fie la fel
    jg Scad1 ;daca cumva luna din present e mai mica scad un an
    Intors:
    ;if2
    cmp ax, [esi + my_date.month] ;verific zilele deoarece este posibil ca lunile si anii sa fie la fel
    je IfDay ;daca se intampla ce am zis mai sus, verific cum sunt zilele
    jmp HaiSaVedem

    Scad1: ;scand un an daca am treaba cu lunile si ma intorc sa vad si cu ziele
    dec ebx
    jmp Intors
 
    ;vad cum sunt zilele 
    IfDay:
    mov ax, [edx + my_date.day]
    cmp ax, [esi + my_date.day]
    jg Scad2 ;daca ziua din present e mai mare scad un an
    jmp HaiSaVedem

    Scad2:
    dec ebx

    HaiSaVedem:
    pop eax
    pop edx;
    cmp ebx, 0  ;daca anul e negativ e cazul cand present e mai mic ca data de nastere
    jl PuneInAges0
    AmPus:
    cmp ebx, 0  ;daca anul e >=0 punem valoarea lui
    jge PuneInAges
    AmPus2:
    jmp ForAici ;ne reintoarcem in for-ul initial


    PuneInAges0:
    mov dword [ecx + eax*4], 0
    jmp AmPus

    PuneInAges:
    mov dword [ecx + eax*4], ebx
    jmp AmPus2


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    Leave:
    popa
    leave
    ret
    ;; DO NOT MODIFY
