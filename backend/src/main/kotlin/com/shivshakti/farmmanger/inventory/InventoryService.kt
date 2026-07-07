package com.shivshakti.farmmanger.inventory

import org.springframework.stereotype.Service
import java.util.UUID

@Service
class InventoryService(

    private val inventoryRepository: InventoryRepository,

    private val transactionRepository: InventoryTransactionRepository

) {

    fun getAll(): List<Inventory> {
        return inventoryRepository.findByActiveTrue()
    }

    fun getById(id: UUID): Inventory {

        return inventoryRepository.findById(id)
            .orElseThrow {
                RuntimeException("Inventory Item Not Found")
            }

    }

    fun create(request: InventoryRequest): Inventory {

        val inventory = Inventory(

            name = request.name,

            category = request.category,

            unit = request.unit,

            currentStock = request.currentStock,

            minimumStock = request.minimumStock,

            purchasePrice = request.purchasePrice,

            sellingPrice = request.sellingPrice,

            active = request.active

        )

        return inventoryRepository.save(inventory)

    }

    fun update(
        id: UUID,
        request: InventoryRequest
    ): Inventory {

        val inventory = getById(id)

        inventory.name = request.name
        inventory.category = request.category
        inventory.unit = request.unit
        inventory.currentStock = request.currentStock
        inventory.minimumStock = request.minimumStock
        inventory.purchasePrice = request.purchasePrice
        inventory.sellingPrice = request.sellingPrice
        inventory.active = request.active

        return inventoryRepository.save(inventory)

    }

    fun delete(id: UUID) {

        val inventory = getById(id)

        inventory.active = false

        inventoryRepository.save(inventory)

    }

    fun stockIn(
        id: UUID,
        request: StockTransactionRequest
    ): Inventory {

        val inventory = getById(id)

        inventory.currentStock += request.quantity

        val savedInventory =
            inventoryRepository.save(inventory)

        transactionRepository.save(

            InventoryTransaction(

                inventory = savedInventory,

                type = TransactionType.STOCK_IN,

                quantity = request.quantity,

                remarks = request.remarks

            )

        )

        return savedInventory

    }

    fun stockOut(
        id: UUID,
        request: StockTransactionRequest
    ): Inventory {

        val inventory = getById(id)

        if (inventory.currentStock < request.quantity) {

            throw RuntimeException("Insufficient Stock")

        }

        inventory.currentStock -= request.quantity

        val savedInventory =
            inventoryRepository.save(inventory)

        transactionRepository.save(

            InventoryTransaction(

                inventory = savedInventory,

                type = TransactionType.STOCK_OUT,

                quantity = request.quantity,

                remarks = request.remarks

            )

        )

        return savedInventory

    }

    fun lowStock(): List<Inventory> {

        return inventoryRepository.findAll()
            .filter {

                it.active &&
                        it.currentStock <= it.minimumStock

            }

    }

    fun getTransactions(
        inventoryId: UUID
    ): List<InventoryTransaction> {

        return transactionRepository
            .findByInventoryIdOrderByTransactionDateDesc(
                inventoryId
            )

    }

    fun getSummary(): InventorySummaryResponse {

        val allItems = inventoryRepository.findAll()

        return InventorySummaryResponse(

            totalItems = allItems.size.toLong(),

            activeItems = allItems.count { it.active }.toLong(),

            lowStockItems = allItems.count {

                it.active &&
                        it.currentStock <= it.minimumStock &&
                        it.currentStock > 0

            },

            outOfStockItems = allItems.count {

                it.active &&
                        it.currentStock == 0.0

            }

        )

    }

}