package com.shivshakti.farmmanger.harvest

import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface HarvestRepository :
    JpaRepository<Harvest, UUID>{
    fun findTop5ByOrderByHarvestDateDesc(): List<Harvest>

}