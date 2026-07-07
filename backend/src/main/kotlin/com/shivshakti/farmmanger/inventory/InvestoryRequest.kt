package com.shivshakti.farmmanger.inventory

import java.math.BigDecimal
import jakarta.validation.constraints.*

data class InventoryRequest(

    @field:NotBlank
    val name: String,

    val category: InventoryCategory,

    @field:NotBlank
    val unit: String,

    @field:PositiveOrZero
    val currentStock: Double,

    @field:PositiveOrZero
    val minimumStock: Double,

    @field:PositiveOrZero
    val purchasePrice: BigDecimal,

    val sellingPrice: BigDecimal?,

    val active: Boolean = true

)