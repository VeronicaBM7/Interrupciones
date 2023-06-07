.cpu cortex-m3      @ Generates Cortex-M3 instructions
.section .text
.align	1
.syntax unified
.thumb
.global SysTick_Handler
SysTick_Handler: 
        sub     r10, #1 @drecrement timeDelay
        bx      lr @exit and trigger auto-unstacking

.size   SysTick_Handler, .-SysTick_Handler
