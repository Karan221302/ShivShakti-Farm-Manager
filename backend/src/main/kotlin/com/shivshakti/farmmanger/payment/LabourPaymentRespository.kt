package com.shivshakti.farmmanger.payment

import com.shivshakti.farmmanger.labour.Labour
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface LabourPaymentRepository :
    JpaRepository<LabourPayment, UUID> {
    fun findTop5ByOrderByPaymentDateDesc(): List<LabourPayment>

    fun findByLabour(
        labour: Labour
    ): List<LabourPayment>
}