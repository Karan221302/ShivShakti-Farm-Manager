package com.shivshakti.farmmanger.expense

import org.springframework.data.jpa.domain.Specification
import java.time.LocalDate

object ExpenseSpecification {

    fun filter(

        category: ExpenseCategory?,

        paymentMode: PaymentMode?,

        startDate: LocalDate?,

        endDate: LocalDate?

    ): Specification<Expense> {

        return Specification { root, _, cb ->

            val predicates = mutableListOf<jakarta.persistence.criteria.Predicate>()

            category?.let {

                predicates.add(
                    cb.equal(root.get<ExpenseCategory>("category"), it)
                )

            }

            paymentMode?.let {

                predicates.add(
                    cb.equal(root.get<PaymentMode>("paymentMode"), it)
                )

            }

            if (startDate != null && endDate != null) {

                predicates.add(

                    cb.between(

                        root.get<LocalDate>("expenseDate"),

                        startDate,

                        endDate

                    )

                )

            }

            cb.and(*predicates.toTypedArray())

        }

    }

}