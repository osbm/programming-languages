        # bedir t karaabalı
        # GAS x86-64 (64 bit)
        # 2025
        # collatz problem

.text
# void collatz_len_and_peak(uint64_t x, uint64_t *steps, uint64_t *peak)
.global collatz_len_and_peak
.global scan_upto



# bu makrolar yukardaki belirlediğim stack'e çok bağlı yani %rbp relative
# bu demek oluyor ki stack değişirse bu makrolar da değişmek zorunda
# daha esnek bir tasarım offset eklemek olurdu
.macro save_registers base
    movq %rax, -96(%\base)
    movq %rcx, -88(%\base)
    movq %rdx, -80(%\base)
    movq %rsi, -72(%\base)
    movq %rdi, -64(%\base)
    movq %r8, -56(%\base)
    movq %r9, -48(%\base)
    movq %r10, -40(%\base)
    movq %r11, -32(%\base)
.endm

.macro restore_registers base
    movq -96(%\base), %rax
    movq -88(%\base), %rcx
    movq -80(%\base), %rdx
    movq -72(%\base), %rsi
    movq -64(%\base), %rdi
    movq -56(%\base), %r8
    movq -48(%\base), %r9
    movq -40(%\base), %r10
    movq -32(%\base), %r11
.endm



collatz_len_and_peak:
    # Collatz problem implementation
    # x -> rdi, steps -> rsi, peak -> rdx

    movq $0, (%rsi) # *steps=0
    movq %rdi, (%rdx) # *peak = x
    movq %rdi, %r8 # r8(n) (caller-saved) = x
    
.loop:
    cmpq $1, %r8 # while (n != 1)
    je .done
    testq $1, %r8 # 1 and n
    jz .even
    # odd case
    leaq 1(%r8, %r8, 2), %r8 # n *= 3 -> lea ( base + index * scale )
    jmp .next_step
.even:
    shrq $1, %r8 # n /= 2
.next_step:
    cmpq (%rdx), %r8 # if (n > *peak) n - *peak
    jle .next
    movq %r8, (%rdx) # *peak = n
.next:
    addq $1, (%rsi) # (*steps)++
    jmp .loop
.done:
    ret


# void scan_upto(uint64_t N, uint64_t *best_n, uint64_t *best_steps, uint64_t *best_peak, uint64_t *xor_steps) 
scan_upto:
    pushq %rbp
    movq %rsp, %rbp

    subq $104, %rsp # burda stack de local değişkenler tutulcak makro için 80 byte + 16 byte local değişkenler ama 
    # hizalamak da gerekiyor

    # başlatma initialize
    # rdi rsi rdx rcx r8
    movq $1, (%rsi) # *best_n = 1
    movq $0, (%rdx) # *best_steps = 0
    movq $1, (%rcx) # *best_peak = 1
    movq $0, (%r8)  # *xor_steps = 0

    movq $1, %r9   # n = 1
.loop_scan:
    cmpq %rdi, %r9 # if (n <= N)
    jg .done_scan
    # local değişkenler
    movq $0, -8(%rbp) # steps = 0
    movq $0, -16(%rbp) # peak = 0
    # şimdi fonksiyon çağırcam ama register sırasını korumam lazım bunlar
    # caller-saved olduğu için diper fonksiyonda korunmazlar ve değişiler bu yüzden
    # hali hazırda kullandığım registerları stack e vermem lazım
    # ama bunu makro olarak yazmak istiyorum bir daha kullanmıycak olsamda
    save_registers rbp
    movq %r9, %rdi # n
    leaq -8(%rbp), %rsi # steps
    leaq -16(%rbp), %rdx # peak
    call collatz_len_and_peak
    restore_registers rbp
    movq (%r8), %r11 # r11 = *xor_steps
    xorq -8(%rbp), %r11 # *xor_steps ^= steps
    movq %r11, (%r8) # *xor_steps = r11
    movq (%rdx), %r11 # r11 = *best_steps
    movq -8(%rbp), %r10 # r10 = steps
    cmpq %r11, %r10 # if (steps > *best_steps)
    jle .incr
    movq %r9,(%rsi) # *best_n = n
    movq %r10, (%rdx) # *best_steps = r10
    movq -16(%rbp), %r11 # r11 = peak
    movq %r11, (%rcx) # *best_peak = r11

.incr:
    incq %r9
    jmp .loop_scan

.done_scan:
    leave
    ret

