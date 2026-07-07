package com.shivshakti.farmmanger.crop

import java.time.LocalDate

data class CropRequest(

    val cropName: String,

    val variety: String,

    val sowingDate: LocalDate,

    val expectedHarvestDate: LocalDate,

    val notes: String?
)