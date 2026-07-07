package com.shivshakti.farmmanger.expense

import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Positive
import jakarta.validation.constraints.Size
import java.math.BigDecimal
import java.time.LocalDate

data class ExpenseRequest(

    @field:NotNull(message = "Expense date is required")
    val expenseDate: LocalDate,

    @field:Positive(message = "Amount must be greater than zero")
    val amount: BigDecimal,

    @field:NotNull(message = "Category is required")
    val category: ExpenseCategory,

    @field:NotNull(message = "Payment mode is required")
    val paymentMode: PaymentMode,

    @field:Size(max = 500, message = "Description cannot exceed 500 characters")
    val description: String?

)