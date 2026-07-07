package com.shivshakti.farmmanger.inventory

import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface InventoryRepository :
    JpaRepository<Inventory, UUID> {

    fun findByActiveTrue(): List<Inventory>

    fun findByCurrentStockLessThanEqual(
        stock: Double
    ): List<Inventory>

}