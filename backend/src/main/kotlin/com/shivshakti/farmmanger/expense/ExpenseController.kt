package com.shivshakti.farmmanger.expense

import org.springframework.web.bind.annotation.*
import java.util.UUID

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
        @RequestBody request: ExpenseRequest
    ) = expenseService.create(request)

    @GetMapping("/total")
    fun totalExpense() =
        expenseService.totalExpense()

    @PutMapping("/{id}")
    fun update(
        @PathVariable id: UUID,
        @RequestBody request: ExpenseRequest
    ) =
        expenseService.update(
            id,
            request
        )

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {
        expenseService.delete(id)
    }
}