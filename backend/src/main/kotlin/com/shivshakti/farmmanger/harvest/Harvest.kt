package com.shivshakti.farmmanger.harvest

import com.shivshakti.farmmanger.crop.Crop
import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID
import com.shivshakti.farmmanger.common.BaseEntity

@Entity
@Table(name = "harvests")
class Harvest(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "crop_id")
    var crop: Crop,

    var harvestDate: LocalDate,

    var quantity: BigDecimal,

    @Enumerated(EnumType.STRING)
    var unit: UnitType,

    var rate: BigDecimal,

    var revenue: BigDecimal
): BaseEntity()