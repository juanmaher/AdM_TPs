/*
 * asm_func.h
 *
 *  Created on: May 16, 2024
 *      Author: flealu
 */

#ifndef INC_ASM_FUNC_H_
#define INC_ASM_FUNC_H_

void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
void asm_invertir (uint16_t * vector, uint32_t longitud);
uint32_t asm_max (int32_t * vectorIn, uint32_t longitud);
void asm_downSample (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N);

#endif /* INC_ASM_FUNC_H_ */
