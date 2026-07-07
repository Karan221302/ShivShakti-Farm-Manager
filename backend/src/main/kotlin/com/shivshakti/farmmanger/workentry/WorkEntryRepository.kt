package com.shivshakti.farmmanger.workentry

import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface WorkEntryRepository : JpaRepository<WorkEntry, UUID>