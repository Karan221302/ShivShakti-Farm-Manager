package com.shivshakti.farmmanger.labour

import jakarta.persistence.*
import java.math.BigDecimal
import java.util.UUID
import com.shivshakti.farmmanger.common.BaseEntity

@Entity
@Table(name = "labours")
class Labour(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    @Column(nullable = false)
    var name: String,

    var mobile: String? = null,

    var village: String? = null,

    @Column(nullable = false)
    var dailyWage: BigDecimal,

    var active: Boolean = true
): BaseEntity()