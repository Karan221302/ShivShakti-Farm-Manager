package com.shivshakti.farmmanger.expense

import org.springframework.stereotype.Service
import java.math.BigDecimal
import java.util.UUID
import java.time.LocalDate

@Service
class ExpenseService(

    private val expenseRepository: ExpenseRepository

) {

    fun create(
        request: ExpenseRequest
    ): ExpenseResponse {

        val expense = Expense(

            expenseDate = request.expenseDate,

            amount = request.amount,

            category = request.category,

            paymentMode = request.paymentMode,

            description = request.description

        )

        return expenseRepository
            .save(expense)
            .toResponse()

    }

    fun findAll(): List<ExpenseResponse> {

        return expenseRepository.findAll()
            .map {
                it.toResponse()
            }

    }

    fun findById(id: UUID): Expense {

        return expenseRepository.findById(id)
            .orElseThrow {
                RuntimeException("Expense not found")
            }

    }

    fun getById(id: UUID): ExpenseResponse {

        return findById(id)
            .toResponse()

    }

    fun update(
        id: UUID,
        request: ExpenseRequest
    ): ExpenseResponse {

        val expense = findById(id)

        expense.expenseDate = request.expenseDate
        expense.amount = request.amount
        expense.category = request.category
        expense.paymentMode = request.paymentMode
        expense.description = request.description

        return expenseRepository
            .save(expense)
            .toResponse()

    }

    fun delete(id: UUID) {

        val expense = findById(id)

        expenseRepository.delete(expense)
    }

    fun totalExpense(): BigDecimal =
        expenseRepository.totalExpense()

    fun findByCategory(
        category: ExpenseCategory
    ): List<ExpenseResponse> {

        return expenseRepository
            .findByCategory(category)
            .map { it.toResponse() }

    }

    fun findByPaymentMode(
        paymentMode: PaymentMode
    ): List<ExpenseResponse> {

        return expenseRepository
            .findByPaymentMode(paymentMode)
            .map { it.toResponse() }

    }

    fun findByDate(
        date: LocalDate
    ): List<ExpenseResponse> {

        return expenseRepository
            .findByExpenseDate(date)
            .map { it.toResponse() }

    }

    fun findBetweenDates(
        start: LocalDate,
        end: LocalDate
    ): List<ExpenseResponse> {

        return expenseRepository
            .findByExpenseDateBetween(start, end)
            .map { it.toResponse() }

    }

    fun filter(

        category: ExpenseCategory?,

        paymentMode: PaymentMode?,

        startDate: LocalDate?,

        endDate: LocalDate?

    ): List<ExpenseResponse> {

        return expenseRepository.findAll(

            ExpenseSpecification.filter(

                category,

                paymentMode,

                startDate,

                endDate

            )

        ).map {

            it.toResponse()

        }

    }

}
