package com.shivshakti.farmmanger.labour

import java.math.BigDecimal
import java.util.UUID

data class LabourResponse(

    val id: UUID,

    val name: String,

    val mobile: String?,

    val village: String?,

    val dailyWage: BigDecimal,

    val active: Boolean
)