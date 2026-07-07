package com.shivshakti.farmmanger.inventory

data class InventorySummaryResponse(

    val totalItems: Long,

    val activeItems: Long,

    val lowStockItems: Int,

    val outOfStockItems: Int

)