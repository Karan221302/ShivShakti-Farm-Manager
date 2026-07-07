package com.shivshakti.farmmanger.crop

import org.springframework.stereotype.Service
import java.util.UUID

@Service
class CropService(

    private val cropRepository: CropRepository

) {

    fun create(
        request: CropRequest
    ): Crop {

        val crop = Crop(
            cropName = request.cropName,
            variety = request.variety,
            sowingDate = request.sowingDate,
            expectedHarvestDate = request.expectedHarvestDate,
            notes = request.notes
        )

        return cropRepository.save(crop)
    }

    fun findAll() =
        cropRepository.findAll()

    fun findById(id: UUID): Crop =
        cropRepository.findById(id)
            .orElseThrow {
                RuntimeException("Crop not found")
            }

    fun update(
        id: UUID,
        request: CropRequest
    ): Crop {

        val crop = findById(id)

        crop.cropName = request.cropName
        crop.variety = request.variety
        crop.sowingDate = request.sowingDate
        crop.expectedHarvestDate =
            request.expectedHarvestDate
        crop.notes = request.notes

        return cropRepository.save(crop)
    }

    fun delete(id: UUID) {

        val crop = findById(id)

        cropRepository.delete(crop)
    }

}