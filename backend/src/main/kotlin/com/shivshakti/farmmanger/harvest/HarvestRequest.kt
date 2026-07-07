package com.shivshakti.farmmanger.harvest

import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

data class HarvestRequest(

    val cropId: UUID,

    val harvestDate: LocalDate,

    val quantity: BigDecimal,

    val unit: UnitType,

    val rate: BigDecimal
)