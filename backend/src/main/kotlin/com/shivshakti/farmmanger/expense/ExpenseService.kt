package com.shivshakti.farmmanger.expense

import org.springframework.stereotype.Service
import java.math.BigDecimal
import java.util.UUID

@Service
class ExpenseService(

    private val expenseRepository: ExpenseRepository

) {

    fun create(
        request: ExpenseRequest
    ): Expense {

        val expense = Expense(
            expenseDate = request.expenseDate,
            amount = request.amount,
            category = request.category,
            paymentMode = request.paymentMode,
            description = request.description
        )

        return expenseRepository.save(expense)
    }

    fun findAll() =
        expenseRepository.findAll()

    fun findById(id: UUID): Expense =
        expenseRepository.findById(id)
            .orElseThrow {
                RuntimeException("Expense not found")
            }

    fun update(
        id: UUID,
        request: ExpenseRequest
    ): Expense {

        val expense = findById(id)

        expense.expenseDate = request.expenseDate
        expense.amount = request.amount
        expense.category = request.category
        expense.paymentMode = request.paymentMode
        expense.description = request.description

        return expenseRepository.save(expense)
    }

    fun delete(id: UUID) {

        val expense = findById(id)

        expenseRepository.delete(expense)
    }

    fun totalExpense(): BigDecimal =
        expenseRepository.findAll()
            .sumOf { it.amount }
}