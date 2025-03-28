.section .data
    as_string: .asciz "Podaj rozmiar tablicy: "
    sc_string: .asciz "%d"
    rozmiar_tablicy: .asciz "rozmiar: %d\n"
    rozmiar: .int 0
    tab_ptr: .int 0
    overflow_max: .int 2147483647
    overflow_message: .asciz "Overflow occurred!\n"
    time_start: .int 0   
    time_end: .int 0
    output_format: .asciz "Time: %u tików\n"

.section .text
    .global main
    .extern printf, scanf, clock, free
    .extern generacja_danych, print_tablicy, quick_sort, generacja_danych_sortowane

overflow:
    push $overflow_message
    call printf
    add $4, %esp
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

main:
    # Wiadomosc na podanie danych
    push $as_string
    call printf
    add $4, %esp

    # Wczytanie danych i sprawdzenie overflow
    push $rozmiar
    push $sc_string
    call scanf
    add $8, %esp
    mov rozmiar, %eax
    cmp overflow_max, %eax
    jg overflow

    # Alokacja pamięci i tworzenie tabeli z danymi
    push rozmiar
    call generacja_danych_sortowane
    add $4, %esp
    mov %eax, tab_ptr

    # Obliczanie prawego piwota
    mov rozmiar, %ebx
    sub $1, %ebx
    mov %ebx, rozmiar

    # Start liczenia czasu
    rdtsc
    mov %eax, time_start       

    # quick sort tablicy
    push rozmiar
    push $0
    push tab_ptr
    call quick_sort
    add $12, %esp

    # Koncowy czas
    rdtsc
    mov %eax, time_end

    # Zwalanianie pamięci
    push tab_ptr
    call free
    add $4, %esp
    
    # Liczenie roznicy czasu
    mov time_end, %eax
    sub time_start, %eax
    
    # Drukowanie wyniku
    push %eax             
    push $output_format      
    call printf              
    add $8, %esp             

    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

.section .note.GNU-stack,"",%progbits
