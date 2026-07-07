package com.shivshakti.farmmanger.inventory

import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/api/inventory")
class InventoryController(

    private val inventoryService: InventoryService

) {

    @GetMapping
    fun getAll() =
        inventoryService.getAll()
    @GetMapping("/summary")
    fun summary() =
        inventoryService.getSummary()

    @GetMapping("/{id}")
    fun getById(
        @PathVariable id: UUID
    ) =
        inventoryService.getById(id)

    @PostMapping
    fun create(
        @RequestBody request: InventoryRequest
    ) =
        inventoryService.create(request)

    @PutMapping("/{id}")
    fun update(

        @PathVariable id: UUID,

        @RequestBody request: InventoryRequest

    ) =
        inventoryService.update(id, request)

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {
        inventoryService.delete(id)
    }

    @PutMapping("/{id}/stock-in")
    fun stockIn(

        @PathVariable id: UUID,

        @RequestBody request: StockTransactionRequest

    ) =
        inventoryService.stockIn(id, request)

    @PutMapping("/{id}/stock-out")
    fun stockOut(

        @PathVariable id: UUID,

        @RequestBody request: StockTransactionRequest

    ) =
        inventoryService.stockOut(id, request)

    @GetMapping("/low-stock")
    fun lowStock() =
        inventoryService.lowStock()

    @GetMapping("/{id}/transactions")
    fun getTransactions(
        @PathVariable id: UUID
    ) =
        inventoryService.getTransactions(id)



}