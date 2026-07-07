package com.shivshakti.farmmanger.payment

import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

data class LabourPaymentRequest(

    val labourId: UUID,

    val paymentDate: LocalDate,

    val amount: BigDecimal,

    val paymentMode: PaymentMode,

    val remarks: String?
)