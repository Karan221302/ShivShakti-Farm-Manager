package com.shivshakti.farmmanger.workentry

import com.shivshakti.farmmanger.labour.LabourRepository
import org.springframework.stereotype.Service
import java.math.BigDecimal
import java.util.UUID

@Service
class WorkEntryService(

    private val workEntryRepository: WorkEntryRepository,
    private val labourRepository: LabourRepository

) {

    fun create(
        request: WorkEntryRequest
    ): WorkEntry {

        val labour = labourRepository.findById(
            request.labourId
        ).orElseThrow {
            RuntimeException("Labour not found")
        }

        val wage = when (request.manday) {

            MandayType.FULL_DAY ->
                labour.dailyWage

            MandayType.HALF_DAY ->
                labour.dailyWage.divide(BigDecimal(2))
        }

        val workEntry = WorkEntry(
            labour = labour,
            workDate = request.workDate,
            workType = request.workType,
            manday = request.manday,
            remarks = request.remarks,
            wageAmount = wage
        )

        return workEntryRepository.save(workEntry)
    }

    fun findAll() =
        workEntryRepository.findAll()

    fun findById(id: UUID): WorkEntry =
        workEntryRepository.findById(id)
            .orElseThrow {
                RuntimeException("Work Entry not found")
            }

    fun update(
        id: UUID,
        request: WorkEntryRequest
    ): WorkEntry {

        val workEntry = findById(id)

        val labour = labourRepository.findById(
            request.labourId
        ).orElseThrow {
            RuntimeException("Labour not found")
        }

        val wage = when (request.manday) {

            MandayType.FULL_DAY ->
                labour.dailyWage

            MandayType.HALF_DAY ->
                labour.dailyWage.divide(BigDecimal(2))
        }

        workEntry.labour = labour
        workEntry.workDate = request.workDate
        workEntry.workType = request.workType
        workEntry.manday = request.manday
        workEntry.remarks = request.remarks
        workEntry.wageAmount = wage

        return workEntryRepository.save(workEntry)
    }

    fun delete(id: UUID) {

        val workEntry = findById(id)

        workEntryRepository.delete(workEntry)
    }

}