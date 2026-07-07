package com.shivshakti.farmmanger.dashboard

import java.math.BigDecimal

data class RecentActivityResponse(

    val type: String,

    val title: String,

    val subtitle: String,

    val amount: BigDecimal

)