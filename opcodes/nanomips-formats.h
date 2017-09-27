/* nanomips-formats.h
   Copyright (C) 2017 Free Software Foundation, Inc.
   Contributed by Imagination Technologies Ltd.

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   It is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
   License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING3. If not,
   see <http://www.gnu.org/licenses/>.  */

#include "mips-formats.h"

#define IMM_INT_BIAS(SIZE, LSB, MAX_VAL, BIAS, SHIFT, PRINT_HEX) \
  { \
    static const struct mips_int_operand op = { \
      { OP_IMM_INT, SIZE, LSB, 0, 0 }, MAX_VAL, BIAS, SHIFT, PRINT_HEX \
    }; \
    return &op.root; \
  }

#define IMM_INT_ADJ(SIZE, LSB, MAX_VAL, SHIFT, PRINT_HEX) \
  IMM_INT_BIAS(SIZE, LSB, MAX_VAL, 0, SHIFT, PRINT_HEX)

#define UINT_SPLIT(SIZE, LSB, SHIFT, SIZE_TOP, LSB_TOP)	\
  { \
    static const struct mips_int_operand op = { \
      { OP_INT, SIZE, LSB, SIZE_TOP, LSB_TOP }, \
      (1 << (SIZE)) - 1, 0, SHIFT, 0	\
    }; \
    return &op.root; \
  }

#define SINT_SPLIT(SIZE, LSB, SHIFT, SIZE_TOP, LSB_TOP, BIAS)	\
  { \
    static const struct mips_int_operand op = { \
      { OP_INT, SIZE, LSB, SIZE_TOP, LSB_TOP }, \
      (1 << ((SIZE) -1)) - 1, BIAS, SHIFT, 0	\
    }; \
    return &op.root; \
  }

#define IMM_SINT_SPLIT(SIZE, LSB, SHIFT, SIZE_TOP, LSB_TOP, BIAS) \
  { \
    static const struct mips_int_operand op = { \
      { OP_IMM_INT, SIZE, LSB, SIZE_TOP, LSB_TOP }, \
      (1 << ((SIZE) -1)) - 1, BIAS, SHIFT, FALSE \
    }; \
    return &op.root; \
  }

#define HINT_SPLIT(SIZE, LSB, SIZE_T, LSB_T)	\
  SINT_SPLIT(SIZE, LSB, 0, SIZE_T, LSB_T)

#define SPLIT_MAPPED_REG_PAIR(SIZE, LSB, SIZE_T, LSB_T, BANK, MAP1, MAP2)	\
  { \
    typedef char ATTRIBUTE_UNUSED \
      static_assert1[(1 << (SIZE)) == ARRAY_SIZE (MAP1)]; \
    typedef char ATTRIBUTE_UNUSED \
      static_assert2[(1 << (SIZE)) == ARRAY_SIZE (MAP2)]; \
    static const struct mips_reg_pair_operand op = { \
      { OP_REG_PAIR, SIZE, LSB, SIZE_T, LSB_T }, OP_REG_##BANK, \
      MAP1, MAP2 \
    }; \
    return &op.root; \
  }

#define BRANCH_UNORD_SPLIT(SIZE, SHIFT) \
  { \
    static const struct mips_pcrel_operand op = { \
      { { OP_PCREL, SIZE, 1, 1, 0 }, \
	(1 << ((SIZE) - 1)) - 1, 0, SHIFT, TRUE }, \
      0, FALSE, FALSE \
    }; \
    return &op.root.root; \
  }

#define BRANCH_SPLIT(SIZE, LSB, SHIFT, SIZE_TOP, LSB_TOP)	\
  { \
    static const struct mips_pcrel_operand op = { \
      { { OP_PCREL, SIZE, 1, SIZE_TOP, LSB_TOP }, \
	(1 << ((SIZE) - 1)) - 1, LSB, SHIFT, TRUE }, \
      0, FALSE, FALSE \
    }; \
    return &op.root.root; \
  }

#define SPECIAL_SPLIT(SIZE, LSB, SIZE_T, LSB_T, TYPE)	\
  { \
    static const struct mips_operand op = { OP_##TYPE, SIZE, LSB, SIZE_T, LSB_T }; \
    return &op; \
  }

#define SPECIAL_WORD(BIAS, TYPE) \
  { \
    static const struct mips_int_operand op = { { OP_##TYPE, 0, 0, 0, 0 }, \
						0x7fffffff, BIAS, 0, FALSE }; \
    return &op.root; \
  }

#define MAPPED_PREV_CHECK(SIZE, LSB, BANK, MAP, GT_OK, LT_OK, EQ_OK, ZERO_OK) \
  { \
    typedef char ATTRIBUTE_UNUSED \
      static_assert[(1 << (SIZE)) == ARRAY_SIZE (MAP)]; \
    static const struct nanomips_mapped_check_prev_operand op = { \
      { OP_MAPPED_CHECK_PREV, SIZE, LSB, 0, 0 }, OP_REG_##BANK, MAP, \
      GT_OK, LT_OK, EQ_OK, ZERO_OK \
    }; \
    return &op.root; \
  }

#define BASE_OFFSET_CHECK(SIZE, LSB, CONST_OK, EXPR_OK) \
  { \
    static const struct nanomips_base_check_offset_operand op = { \
      { OP_BASE_CHECK_OFFSET, SIZE, LSB, 0, 0 }, OP_REG_GP, \
      CONST_OK, EXPR_OK					    \
    }; \
    return &op.root; \
  }
