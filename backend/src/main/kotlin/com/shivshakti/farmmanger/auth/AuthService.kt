package com.shivshakti.farmmanger.auth

import org.springframework.stereotype.Service

@Service
class AuthService(

    private val jwtService: JwtService
) {

    fun login(
        request: LoginRequest
    ): LoginResponse {

        if (
            request.username != "admin"
            || request.password != "admin123"
        ) {
            throw RuntimeException(
                "Invalid credentials"
            )
        }

        return LoginResponse(
            token = jwtService.generateToken(
                request.username
            )
        )
    }
}