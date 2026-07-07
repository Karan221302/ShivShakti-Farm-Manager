package com.shivshakti.farmmanger.common

import jakarta.persistence.MappedSuperclass
import java.time.LocalDateTime

@MappedSuperclass
abstract class BaseEntity(

    var createdAt: LocalDateTime =
        LocalDateTime.now(),

    var updatedAt: LocalDateTime =
        LocalDateTime.now()
)