package com.shivshakti.farmmanger.payment

import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/api/payments")
class LabourPaymentController(

    private val labourPaymentService: LabourPaymentService
) {

    @PostMapping
    fun create(
        @RequestBody request: LabourPaymentRequest
    ) =
        labourPaymentService.create(request)

    @GetMapping("/summary/{labourId}")
    fun summary(
        @PathVariable labourId: UUID
    ) =
        labourPaymentService.getSummary(
            labourId
        )

    @GetMapping
    fun getAll() =
        labourPaymentService.findAll()

    @PutMapping("/{id}")
    fun update(

        @PathVariable id: UUID,

        @RequestBody request: LabourPaymentRequest

    ) =
        labourPaymentService.update(id, request)

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {
        labourPaymentService.delete(id)
    }

}