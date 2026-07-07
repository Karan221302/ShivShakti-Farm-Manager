package com.shivshakti.farmmanger.inventory

import com.shivshakti.farmmanger.common.BaseEntity
import jakarta.persistence.*
import java.time.LocalDateTime
import java.util.UUID

@Entity
@Table(name = "inventory_transactions")
class InventoryTransaction(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inventory_id")
    var inventory: Inventory,

    @Enumerated(EnumType.STRING)
    var type: TransactionType,

    var quantity: Double,

    var remarks: String,

    var transactionDate: LocalDateTime = LocalDateTime.now()

) : BaseEntity()