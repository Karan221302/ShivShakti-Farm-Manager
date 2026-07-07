package com.shivshakti.farmmanger.labour

import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface LabourRepository : JpaRepository<Labour, UUID>