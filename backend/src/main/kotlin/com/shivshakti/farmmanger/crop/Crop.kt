package com.shivshakti.farmmanger.crop

import jakarta.persistence.*
import java.time.LocalDate
import java.util.UUID
import com.shivshakti.farmmanger.common.BaseEntity

@Entity
@Table(name = "crops")
class Crop(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    var cropName: String,

    var variety: String,

    var sowingDate: LocalDate,

    var expectedHarvestDate: LocalDate,

    var notes: String? = null
): BaseEntity()