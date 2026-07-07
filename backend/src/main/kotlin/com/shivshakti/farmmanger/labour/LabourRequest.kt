package com.shivshakti.farmmanger.labour

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Positive
import java.math.BigDecimal

data class LabourRequest(

    @field:NotBlank(message = "Name is required")
    val name: String,

    @field:NotBlank(message = "Mobile is required")
    val mobile: String,

    val village: String?,

    @field:Positive(message = "Daily wage must be positive")
    val dailyWage: BigDecimal
)