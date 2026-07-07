package com.shivshakti.farmmanger.dashboard

import java.math.BigDecimal

data class DashboardResponse(

    val totalLabours: Long,

    val totalCrops: Long,

    val totalHarvests: Long,

    val totalWorkEntries: Long,

    val totalExpenses: BigDecimal,

    val totalRevenue: BigDecimal,

    val totalWagesEarned: BigDecimal,

    val totalPaymentsMade: BigDecimal,

    val totalPendingPayments: BigDecimal,

    val netProfit: BigDecimal

)