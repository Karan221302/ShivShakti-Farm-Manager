package com.shivshakti.farmmanger.harvest

import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/api/harvests")
class HarvestController(

    private val harvestService: HarvestService
) {

    @PostMapping
    fun create(
        @RequestBody request: HarvestRequest
    ) =
        harvestService.create(request)

    @GetMapping
    fun getAll() =
        harvestService.findAll()

    @PutMapping("/{id}")
    fun update(

        @PathVariable id: UUID,

        @RequestBody request: HarvestRequest

    ) = harvestService.update(id, request)

    @DeleteMapping("/{id}")
    fun delete(
        @PathVariable id: UUID
    ) {

        harvestService.delete(id)

    }
}