package com.shivshakti.farmmanger.labour

fun Labour.toResponse() =
    LabourResponse(
        id = id!!,
        name = name,
        mobile = mobile,
        village = village,
        dailyWage = dailyWage,
        active = active
    )