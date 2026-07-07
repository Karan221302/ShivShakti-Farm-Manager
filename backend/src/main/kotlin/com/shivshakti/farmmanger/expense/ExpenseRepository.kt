package com.shivshakti.farmmanger.expense

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID
import org.springframework.data.jpa.repository.JpaSpecificationExecutor


interface ExpenseRepository : JpaRepository<Expense, UUID>,
    JpaSpecificationExecutor<Expense> {

    fun findTop5ByOrderByExpenseDateDesc(): List<Expense>

    fun findByCategory(category: ExpenseCategory): List<Expense>

    fun findByPaymentMode(paymentMode: PaymentMode): List<Expense>

    fun findByExpenseDate(expenseDate: LocalDate): List<Expense>

    fun findByExpenseDateBetween(
        startDate: LocalDate,
        endDate: LocalDate
    ): List<Expense>

    @Query(
        """
        SELECT COALESCE(SUM(e.amount),0)
        FROM Expense e
        """
    )
    fun totalExpense(): BigDecimal
}