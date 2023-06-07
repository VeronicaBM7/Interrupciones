.section .text
.align	1
.syntax unified
.thumb
.global delay

delay:
        mov     r10, r0 @ make a copy of cheeck_speed
.loop:
        cmp     r10, #0  @ wait for timeDelay = 0
        bne     .loop   @r10 is decreased periodicall by systick_handler
        bx      lr      @exit

.size   delay, .-delay


