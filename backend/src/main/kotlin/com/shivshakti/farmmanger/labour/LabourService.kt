package com.shivshakti.farmmanger.labour

import org.springframework.stereotype.Service
import java.util.UUID

@Service
class LabourService(
    private val labourRepository: LabourRepository
) {

    fun create(request: LabourRequest): Labour {

        val labour = Labour(
            name = request.name,
            mobile = request.mobile,
            village = request.village,
            dailyWage = request.dailyWage
        )

        return labourRepository.save(labour)
    }

    fun findAll(): List<Labour> =
        labourRepository.findAll()

    fun findById(id: UUID): Labour =
        labourRepository.findById(id)
            .orElseThrow {
                RuntimeException("Labour not found")
            }

    fun update(
        id: UUID,
        request: LabourRequest
    ): Labour {

        val labour = findById(id)

        labour.name = request.name
        labour.mobile = request.mobile
        labour.village = request.village
        labour.dailyWage = request.dailyWage

        return labourRepository.save(labour)
    }

    fun disable(id: UUID) {

        val labour = findById(id)

        labour.active = false

        labourRepository.save(labour)
    }

}