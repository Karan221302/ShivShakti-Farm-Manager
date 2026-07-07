package com.shivshakti.farmmanger.expense

import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface ExpenseRepository :
    JpaRepository<Expense, UUID>{
    fun findTop5ByOrderByExpenseDateDesc(): List<Expense>
    }