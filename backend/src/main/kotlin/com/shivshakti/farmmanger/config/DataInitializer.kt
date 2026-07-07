package com.shivshakti.farmmanager.config

import com.shivshakti.farmmanager.user.User
import com.shivshakti.farmmanager.user.UserRepository
import org.springframework.boot.CommandLineRunner
import org.springframework.stereotype.Component

@Component
class DataInitializer(
    private val userRepository: UserRepository
) : CommandLineRunner {

    override fun run(vararg args: String) {

        if (userRepository.count() == 0L) {

            userRepository.save(
                User(
                    name = "Admin",
                    username = "admin",
                    password = "admin123",
                    role = "ADMIN"
                )
            )
        }
    }
}
