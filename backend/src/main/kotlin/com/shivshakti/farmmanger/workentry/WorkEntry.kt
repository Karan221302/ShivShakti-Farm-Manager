package com.shivshakti.farmmanger.workentry

import com.shivshakti.farmmanger.labour.Labour
import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

@Entity
@Table(name = "work_entries")
class WorkEntry(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "labour_id")
    var labour: Labour,

    var workDate: LocalDate,

    @Enumerated(EnumType.STRING)
    var workType: WorkType,

    @Enumerated(EnumType.STRING)
    var manday: MandayType,

    var remarks: String? = null,

    var wageAmount: BigDecimal
)