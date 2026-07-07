package com.shivshakti.farmmanger.dashboard

import java.math.BigDecimal

data class ProfitResponse(

    val totalRevenue: BigDecimal,

    val totalExpenses: BigDecimal,

    val netProfit: BigDecimal,

    val cropWiseRevenue: List<CropRevenueResponse>

)