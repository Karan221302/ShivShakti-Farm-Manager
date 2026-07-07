package com.shivshakti.farmmanger.inventory

import java.math.BigDecimal
import java.util.UUID

data class InventoryResponse(

    val id: UUID,

    val name: String,

    val category: String,

    val unit: String,

    val currentStock: Double,

    val minimumStock: Double,

    val purchasePrice: BigDecimal,

    val sellingPrice: BigDecimal?,

    val active: Boolean,

    val lowStock: Boolean

)