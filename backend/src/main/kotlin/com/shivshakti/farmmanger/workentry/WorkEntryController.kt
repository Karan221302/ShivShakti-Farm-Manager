package com.shivshakti.farmmanger.workentry


import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/api/work-entries")
class WorkEntryController(
    private val workEntryService: WorkEntryService
) {

    @PostMapping
    fun create(
        @RequestBody request: WorkEntryRequest
    ) = workEntryService.create(request)

    @GetMapping
    fun getAll() =
        workEntryService.findAll()
    @PutMapping("/{id}")
    fun update(
        @PathVariable id: UUID,
        @RequestBody request: WorkEntryRequest
    ) =
        workEntryService.update(
            id,
            request
        )

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {

        workEntryService.delete(id)

    }
}