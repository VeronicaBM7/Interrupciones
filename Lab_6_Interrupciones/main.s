.thumb              @ Assembles using thumb mode
.cpu cortex-m3      @ Generates Cortex-M3 instructions
.syntax unified

.include "ivt.s"
.include "gpio_map.inc"
.include "rcc_map.inc"
.include "afio_map.inc"
.include "exti_map.inc"
.include "nvic_reg_map.inc"
.extern delay
.extern Systick_Handler
.extern check_speed
.extern systick_initialize
.extern output
.section .text
.align	1
.syntax unified
.thumb
.global __main
__main:
setup:
        push {r7, lr}
        sub sp, sp, #8
        add r7, sp, #0
       //Configuracion de perifericos 
        # enabling clock in port 
        ldr r0, =RCC_BASE
        mov r1, 0x4 
        str r1, [r0, RCC_APB2ENR_OFFSET]

        # set pin 0 to 7 in GPIOA
        ldr r0, =GPIOA_BASE
        ldr r3, =0x33333333 @ Turn on pins 0-7
        str r3, [r0, GPIOx_CRL_OFFSET]  

        # ports 8 and 9 output and 10 and 11 input
        ldr r3, =0x44448833 
        str r3, [r0, GPIOx_CRH_OFFSET]    

        # Configure EXI11 and EXI10
        ldr r0, =AFIO_BASE 
        eor r1, r1 @ Clears r1
        str r1, [r0, AFIO_EXTICR3_OFFSET] @Selects PA 11 and 10 as inputs

        ldr r0, =EXTI_BASE 
        ldr r1, =0x00000C00
        str r1, [r0, EXTI_RTST_OFFSET] @ Rising Trigger event lines PA 11 and 10
        str r1, [r0, EXTI_IMR_OFFSET] @ Unmask the interrupt request from 11 and 10
        eor r1, r1
        str r1, [r0, EXTI_FTST_OFFSET] @ Unmask the interrupt request from 11 and 10
        # Configures NVIC to attends EXIT Request
        ldr r0, =NVIC_BASE
        ldr r1, =0x00000100
        str r1, [r0, NVIC_ISER1_OFFSET] @ Enables EXIT [15:10]

        //Systic es una configuracion de perifericos 
        //inicializacion 
        bl  systick_initialize
loop:
        movs    r0, #0
        str     r0, [r7]
        movs    r8, #3 
        movs    r9, #0
L1:          
        bl      check_speed
        mov     r5, r0
        mov	r3, r9
        cmp     r3, #0 //if (modo == 0)
        bne     L10
        ldr     r0, [r7]
        adds    r0, r0, #1 //counter ++
        str     r0, [r7]
        b       L11
L10:
        ldr     r0, [r7]
        subs    r0, r0, #1 //counter --
        str     r0, [r7]
L11:
        ldr     r0, [r7]
        bl      output //output (counter)
        mov     r0, r5
        bl      delay   
        b       L1  //go to L1
