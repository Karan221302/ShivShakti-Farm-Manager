package com.shivshakti.farmmanger.harvest

import com.shivshakti.farmmanger.crop.CropRepository
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class HarvestService(

    private val cropRepository: CropRepository,
    private val harvestRepository: HarvestRepository

) {

    fun create(request: HarvestRequest): Harvest {

        val crop = cropRepository.findById(request.cropId)
            .orElseThrow {
                RuntimeException("Crop not found")
            }

        val revenue = request.quantity * request.rate

        val harvest = Harvest(
            crop = crop,
            harvestDate = request.harvestDate,
            quantity = request.quantity,
            unit = request.unit,
            rate = request.rate,
            revenue = revenue
        )

        return harvestRepository.save(harvest)
    }

    fun findAll() =
        harvestRepository.findAll()

    fun findById(id: UUID): Harvest =
        harvestRepository.findById(id)
            .orElseThrow {
                RuntimeException("Harvest not found")
            }

    fun update(
        id: UUID,
        request: HarvestRequest
    ): Harvest {

        val harvest = findById(id)

        val crop = cropRepository.findById(request.cropId)
            .orElseThrow {
                RuntimeException("Crop not found")
            }

        harvest.crop = crop
        harvest.harvestDate = request.harvestDate
        harvest.quantity = request.quantity
        harvest.unit = request.unit
        harvest.rate = request.rate
        harvest.revenue = request.quantity * request.rate

        return harvestRepository.save(harvest)
    }

    fun delete(id: UUID) {

        val harvest = findById(id)

        harvestRepository.delete(harvest)
    }

}