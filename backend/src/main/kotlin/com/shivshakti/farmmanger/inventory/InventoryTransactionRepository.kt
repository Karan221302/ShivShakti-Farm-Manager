package com.shivshakti.farmmanger.inventory

import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface InventoryTransactionRepository :
    JpaRepository<InventoryTransaction, UUID> {

    fun findByInventoryIdOrderByTransactionDateDesc(
        inventoryId: UUID
    ): List<InventoryTransaction>

}