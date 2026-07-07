package com.shivshakti.farmmanger.crop

import org.springframework.web.bind.annotation.*
import java.util.UUID


@RestController
@RequestMapping("/api/crops")
class CropController(

    private val cropService: CropService
) {

    @PostMapping
    fun create(
        @RequestBody request: CropRequest
    ) = cropService.create(request)

    @GetMapping
    fun getAll() =
        cropService.findAll()

    @PutMapping("/{id}")
    fun update(

        @PathVariable id: UUID,

        @RequestBody request: CropRequest

    ) = cropService.update(
        id,
        request
    )

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {

        cropService.delete(id)

    }
}