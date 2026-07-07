package com.shivshakti.farmmanger.inventory

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Positive

data class StockTransactionRequest(

    @field:Positive
    val quantity: Double,

    @field:NotBlank
    val remarks: String

)