/*
 * asm_TP2.S
 *
 *  Created on: May 16, 2024
 *      Author: flealu
 *Antes S mayuscula nos dejaba utilizar primitivas
 *de preprosesamiento, o sea, macros
 */

.text 	// Sección de texto: se indica que en esta sección hay código para ejecutar


.syntax unified		// Uso del UAL
.thumb		 	// El ISA que se utilizará es Thumb-2


.global asm_pack32to16
.global asm_max
.global asm_invertir
.global asm_downSample

//Ejercicio 1
// void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud)

.thumb_func
asm_pack32to16:

		push {r4 - r8} //Guardamos registros que probablemente tengan info
		cbz r0, _exit1
		cbz r1, _exit1
		cbz r2, _exit1


_loop1:
		sub r2, #1
		ldr r3, [r0, r2, LSL#2]
		asr r3, r3, #16
		strh r3, [r1, r2, LSL#1]
		cbz r2, _exit1
		b _loop1

_exit1:
		pop {r4 - r8} // Recuperamos lo que guardamos
		bx lr // Volvemos a donde estabamos



.thumb_func

//Ejercicio 2
// uint32_t max (int32_t * vectorIn, uint32_t longitud)

asm_max:
		cbz r0, _exit2
		cbz r1, _exit2

		ldr r2, [r0]

	_loop2:
		subs r1, #1
		bmi _exit2

		ldr r3, [r0, r1, LSL #2]
		cmp r3, r2
		it hi
		movhi r2, r3

        b _loop2

	_exit2:
		mov r0, r2
		bx lr

// Ejercicio 3
//void downSample (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N)
//
// r0: vectorIn
// r1: vectorOut
// r2: longitud
// r3: N
//
//

.thumb_func

asm_downSample:

		push {r4 - r8}
		cbz r0, _exit3
		cbz r1, _exit3
		cbz r2, _exit3
		cbz r3, _exit3
		udiv r4, r2, r3 // r4 = longitud / N
		sub r4, r2, r4 // longitudOut

_loop3:

		udiv r5, r2, r3
		mul r5, r5, r3
		cmp r5, r2
		it eq
		subeq r2, #1
		sub r4, #1
		sub r2, #1
		ldr r6, [r0, r2, LSL #2]
		str r6, [r1, r4, LSL #2]
		subs r2, #1
		bne _loop3


_exit3:

		pop {r4 - r8} // Recuperamos lo que guardamos
		bx lr // Volvemos a donde estabamos





// Ejercicio 4
//void invertir (uint16_t * vector, uint32_t longitud);
//
//r0: vector
//r1: longitud
//

.thumb_func
asm_invertir:

		push {r4 - r8} //Guardamos registros que probablemente tengan info
		cbz r0, _exit4
		cbz r1, _exit4
		mov r4, #0 // j
		sub r1, #1 // i

_loop4:


		ldrh r2, [r0, r1, LSL#1] // longitud
		ldrh r3, [r0, r4, LSL#1] // 0

		strh r2, [r0, r4, LSL#1]
		strh r3, [r0, r1, LSL#1]

		add r4, #1
		sub r1, #1 // i
		cmp r4, r1
		it hi
		bhi _exit4
		b _loop4

_exit4:
		pop {r4 - r8} // Recuperamos lo que guardamos
		bx lr // Volvemos a donde estabamos




















