package com.shivshakti.farmmanger.expense

import java.math.BigDecimal
import java.time.LocalDate

data class ExpenseRequest(

    val expenseDate: LocalDate,

    val amount: BigDecimal,

    val category: ExpenseCategory,

    val paymentMode: PaymentMode,

    val description: String?
)