package com.shivshakti.farmmanger.inventory

import com.shivshakti.farmmanger.common.BaseEntity
import jakarta.persistence.*
import java.math.BigDecimal
import java.util.UUID

@Entity
@Table(name = "inventory")
class Inventory(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    var name: String,

    @Enumerated(EnumType.STRING)
    var category: InventoryCategory,

    var unit: String,

    var currentStock: Double,

    var minimumStock: Double,

    var purchasePrice: BigDecimal,

    var sellingPrice: BigDecimal? = null,

    var active: Boolean,




) : BaseEntity()