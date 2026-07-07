package com.shivshakti.farmmanger.health

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api")
class HealthController {

    @GetMapping("/health")
    fun health(): String {
        return "ShivShakti Farm Manager Backend Running"
    }
}