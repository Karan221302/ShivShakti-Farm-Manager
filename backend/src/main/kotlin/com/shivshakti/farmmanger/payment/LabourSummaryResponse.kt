package com.shivshakti.farmmanger.payment

import java.math.BigDecimal

data class LabourSummaryResponse(

    val labourName: String,

    val earnedAmount: BigDecimal,

    val paidAmount: BigDecimal,

    val pendingAmount: BigDecimal
)