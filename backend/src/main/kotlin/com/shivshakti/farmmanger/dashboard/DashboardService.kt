package com.shivshakti.farmmanger.dashboard

import com.shivshakti.farmmanger.expense.ExpenseRepository
import com.shivshakti.farmmanger.harvest.HarvestRepository
import com.shivshakti.farmmanger.labour.LabourRepository
import com.shivshakti.farmmanger.payment.LabourPaymentRepository
import com.shivshakti.farmmanger.workentry.WorkEntryRepository
import com.shivshakti.farmmanger.crop.CropRepository
import org.springframework.stereotype.Service
import com.shivshakti.farmmanger.dashboard.CropRevenueResponse
import java.math.BigDecimal

@Service
class DashboardService(

    private val labourRepository: LabourRepository,
    private val workEntryRepository: WorkEntryRepository,
    private val expenseRepository: ExpenseRepository,
    private val paymentRepository: LabourPaymentRepository,
    private val harvestRepository: HarvestRepository,
    private val cropRepository: CropRepository,

) {

    fun getDashboard(): DashboardResponse {

        val totalExpenses =
            expenseRepository.findAll()
                .sumOf { it.amount }

        val totalWages =
            workEntryRepository.findAll()
                .sumOf { it.wageAmount }

        val totalPayments =
            paymentRepository.findAll()
                .sumOf { it.amount }

        val totalRevenue =
            harvestRepository.findAll()
                .sumOf { it.revenue }

        return DashboardResponse(

            totalLabours =
                labourRepository.count(),

            totalCrops =
                cropRepository.count(),

            totalHarvests =
                harvestRepository.count(),

            totalWorkEntries =
                workEntryRepository.count(),

            totalExpenses =
                totalExpenses,

            totalRevenue =
                totalRevenue,

            totalWagesEarned =
                totalWages,

            totalPaymentsMade =
                totalPayments,

            totalPendingPayments =
                totalWages - totalPayments,

            netProfit =
                totalRevenue - totalExpenses

        )

    }

    fun getProfit(): ProfitResponse {

        val harvests = harvestRepository.findAll()
        val revenue =
            harvests.sumOf { it.revenue }

        val expenses =
            expenseRepository.findAll()
                .sumOf { it.amount }

        val cropRevenue =
            harvests
                .groupBy { it.crop.cropName }
                .map { (cropName, records) ->

                    CropRevenueResponse(
                        cropName = cropName,
                        revenue = records.sumOf {
                            it.revenue
                        })
                }

        return ProfitResponse(
            totalRevenue = revenue,
            totalExpenses = expenses,
            netProfit = revenue - expenses,
            cropWiseRevenue = cropRevenue
        )
    }
    fun getRecentActivities(): List<RecentActivityResponse> {

        val activities = mutableListOf<RecentActivityResponse>()

        harvestRepository.findTop5ByOrderByHarvestDateDesc()
            .forEach {

                activities.add(

                    RecentActivityResponse(

                        type = "HARVEST",

                        title = it.crop.cropName,

                        subtitle = it.harvestDate.toString(),

                        amount = it.revenue

                    )

                )

            }

        expenseRepository.findTop5ByOrderByExpenseDateDesc()
            .forEach {

                activities.add(

                    RecentActivityResponse(

                        type = "EXPENSE",

                        title = it.category.name,

                        subtitle = it.expenseDate.toString(),

                        amount = it.amount

                    )

                )

            }

        paymentRepository.findTop5ByOrderByPaymentDateDesc()
            .forEach {

                activities.add(

                    RecentActivityResponse(

                        type = "PAYMENT",

                        title = it.labour.name,

                        subtitle = it.paymentMode.name,

                        amount = it.amount

                    )

                )

            }

        return activities
    }
}