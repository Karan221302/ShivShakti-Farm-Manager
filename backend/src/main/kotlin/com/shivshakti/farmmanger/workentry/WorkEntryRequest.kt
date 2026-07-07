package com.shivshakti.farmmanger.workentry

import java.time.LocalDate
import java.util.UUID

data class WorkEntryRequest(

    val labourId: UUID,

    val workDate: LocalDate,

    val workType: WorkType,

    val manday: MandayType,

    val remarks: String?
)