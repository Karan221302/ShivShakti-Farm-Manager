package com.shivshakti.farmmanger.expense

import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

data class ExpenseResponse(

    val id: UUID,

    val expenseDate: LocalDate,

    val amount: BigDecimal,

    val category: ExpenseCategory,

    val paymentMode: PaymentMode,

    val description: String?

)