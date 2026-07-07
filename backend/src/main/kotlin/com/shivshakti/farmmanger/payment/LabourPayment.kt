package com.shivshakti.farmmanger.payment

import com.shivshakti.farmmanger.labour.Labour
import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID
import com.shivshakti.farmmanger.common.BaseEntity

@Entity
@Table(name = "labour_payments")
class LabourPayment(

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "labour_id")
    var labour: Labour,

    var paymentDate: LocalDate,

    var amount: BigDecimal,

    @Enumerated(EnumType.STRING)
    var paymentMode: PaymentMode,

    var remarks: String? = null
): BaseEntity()