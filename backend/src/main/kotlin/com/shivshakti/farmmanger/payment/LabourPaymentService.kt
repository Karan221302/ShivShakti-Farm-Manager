package com.shivshakti.farmmanger.payment

import com.shivshakti.farmmanger.labour.LabourRepository
import com.shivshakti.farmmanger.workentry.WorkEntryRepository
import org.springframework.stereotype.Service
import java.math.BigDecimal
import java.util.UUID

@Service
class LabourPaymentService(

    private val labourRepository: LabourRepository,
    private val paymentRepository: LabourPaymentRepository,
    private val workEntryRepository: WorkEntryRepository

) {

    fun create(
        request: LabourPaymentRequest
    ): LabourPayment {

        val labour = labourRepository
            .findById(request.labourId)
            .orElseThrow {
                RuntimeException("Labour not found")
            }

        val payment = LabourPayment(
            labour = labour,
            paymentDate = request.paymentDate,
            amount = request.amount,
            paymentMode = request.paymentMode,
            remarks = request.remarks
        )

        return paymentRepository.save(payment)
    }

    fun getSummary(
        labourId: UUID
    ): LabourSummaryResponse {

        val labour = labourRepository
            .findById(labourId)
            .orElseThrow {
                RuntimeException("Labour not found")
            }

        val earned = workEntryRepository
            .findAll()
            .filter { it.labour.id == labourId }
            .sumOf { it.wageAmount }

        val paid = paymentRepository
            .findByLabour(labour)
            .sumOf { it.amount }

        return LabourSummaryResponse(
            labourName = labour.name,
            earnedAmount = earned,
            paidAmount = paid,
            pendingAmount = earned - paid
        )
    }


    fun findAll() =
        paymentRepository.findAll()

    fun findById(id: UUID): LabourPayment =
        paymentRepository.findById(id)
            .orElseThrow {
                RuntimeException("Payment not found")
            }

    fun update(
        id: UUID,
        request: LabourPaymentRequest
    ): LabourPayment {

        val payment = findById(id)

        val labour = labourRepository
            .findById(request.labourId)
            .orElseThrow {
                RuntimeException("Labour not found")
            }

        payment.labour = labour
        payment.paymentDate = request.paymentDate
        payment.amount = request.amount
        payment.paymentMode = request.paymentMode
        payment.remarks = request.remarks

        return paymentRepository.save(payment)
    }

    fun delete(id: UUID) {

        val payment = findById(id)

        paymentRepository.delete(payment)
    }
}