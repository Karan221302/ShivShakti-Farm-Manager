package com.shivshakti.farmmanger.expense

import org.springframework.web.bind.annotation.*
import java.util.UUID
import jakarta.validation.Valid
import java.time.LocalDate

@RestController
@RequestMapping("/api/expenses")
class ExpenseController(

    private val expenseService: ExpenseService
) {



    @GetMapping
    fun getAll() =
        expenseService.findAll()

    @PostMapping
    fun create(

        @Valid
        @RequestBody
        request: ExpenseRequest

    ) = expenseService.create(request)

    @GetMapping("/total")
    fun totalExpense() =
        expenseService.totalExpense()

    @PutMapping("/{id}")
    fun update(

        @PathVariable id: UUID,

        @Valid
        @RequestBody
        request: ExpenseRequest

    ) = expenseService.update(id, request)

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {
        expenseService.delete(id)
    }

    @GetMapping("/{id}")
    fun getById(
        @PathVariable id: UUID
    ) = expenseService.getById(id)


    @GetMapping("/category/{category}")
    fun byCategory(
        @PathVariable category: ExpenseCategory
    ) =
        expenseService.findByCategory(category)



    @GetMapping("/payment/{paymentMode}")
    fun byPaymentMode(
        @PathVariable paymentMode: PaymentMode
    ) =
        expenseService.findByPaymentMode(paymentMode)


    @GetMapping("/date/{date}")
    fun byDate(
        @PathVariable date: LocalDate
    ) =
        expenseService.findByDate(date)

    @GetMapping("/between")
    fun betweenDates(

        @RequestParam start: LocalDate,

        @RequestParam end: LocalDate

    ) =
        expenseService.findBetweenDates(
            start,
            end
        )


    @GetMapping("/filter")
    fun filter(

        @RequestParam(required = false)
        category: ExpenseCategory?,

        @RequestParam(required = false)
        paymentMode: PaymentMode?,

        @RequestParam(required = false)
        startDate: LocalDate?,

        @RequestParam(required = false)
        endDate: LocalDate?

    ) = expenseService.filter(

        category,

        paymentMode,

        startDate,

        endDate

    )
}

