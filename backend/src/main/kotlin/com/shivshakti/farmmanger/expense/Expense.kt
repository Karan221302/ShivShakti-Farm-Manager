package com.shivshakti.farmmanger.expense

import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID
import com.shivshakti.farmmanger.common.BaseEntity

@Entity
@Table(name = "expenses")
class Expense(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    var expenseDate: LocalDate,

    var amount: BigDecimal,

    @Enumerated(EnumType.STRING)
    var category: ExpenseCategory,

    @Enumerated(EnumType.STRING)
    var paymentMode: PaymentMode,

    var description: String? = null
): BaseEntity()

fun Expense.toResponse() = ExpenseResponse(

    id = id!!,

    expenseDate = expenseDate,

    amount = amount,

    category = category,

    paymentMode = paymentMode,

    description = description

)