package com.shivshakti.farmmanger.dashboard

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/dashboard")
class DashboardController(

    private val dashboardService: DashboardService
) {

    @GetMapping
    fun dashboard() =
        dashboardService.getDashboard()

    @GetMapping("/profit")
    fun profit() =
        dashboardService.getProfit()

    @GetMapping("/recent")
    fun recent() =
        dashboardService.getRecentActivities()
}
