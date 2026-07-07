package com.shivshakti.farmmanger.labour

import jakarta.validation.Valid
import org.springframework.web.bind.annotation.*
import java.util.UUID


@RestController
@RequestMapping("/api/labours")
class LabourController(
    private val labourService: LabourService
) {

    @PostMapping
    fun create(
        @Valid
        @RequestBody request: LabourRequest
    ): Labour {
        return labourService.create(request)
    }

    @GetMapping
    fun getAll(): List<Labour> {
        return labourService.findAll()
    }

    @GetMapping("/{id}")
    fun getById(
        @PathVariable id: UUID
    ): Labour {
        return labourService.findById(id)
    }
    @PutMapping("/{id}")
    fun update(
        @PathVariable id: UUID,
        @Valid
        @RequestBody request: LabourRequest
    ): Labour {

        return labourService.update(
            id,
            request
        )
    }
    @DeleteMapping("/{id}")
    fun disable(
        @PathVariable id: UUID
    ) {

        labourService.disable(id)

    }
}