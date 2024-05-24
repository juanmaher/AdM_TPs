/*
 * asm_TP2.S
 *
 *  Created on: May 16, 2024
 *      Author: flealu
 *Antes S mayuscula nos dejaba utilizar primitivas
 *de preprosesamiento, o sea, macros
 */
/*
//lo que esta en blanco como las .syntax y .thumb es porque son optativas

.text //le dice al compilador que lo que escribimos luego va en la flash
.syntax unified //dice que es lenguaje asembly unificado
.thumb //dice que usamos thumb

*/

// Ejemplo de cómo se realiza un archivo para escribir código en Assembly.
// Los comentarios son iguales que en C, y además se puede utilizar @:
@ Un comentario

// Directivas del compilador: Son aquellas que comienzan con un "."
// Para que nuestro código funcione, necesitamos:
.text 	// Sección de texto: se indica que en esta sección hay código para ejecutar

// Otras opcionales, pero muy recomendadas, son (no importa el orden):
.syntax unified		// Uso del UAL
.thumb		 	// El ISA que se utilizará es Thumb-2

//Otra directiva que es mandatoria es .global. Sirve para que nuestra función sea
//"visible" por los demás archivos. No olvidar colocar el prototipo de la función
//en el respectivo archivo .h

// Exportar todas las funciones aquí (.global + nombre_función)
.global asm_pack32to16


// Se recomienda colocar el prototipo de la función en C, como ayuda:
// Prototipo en archivo .h:
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






















