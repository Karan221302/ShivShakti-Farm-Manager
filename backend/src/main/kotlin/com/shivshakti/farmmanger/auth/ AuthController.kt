package com.shivshakti.farmmanger.auth

import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/auth")
class AuthController(

    private val authService: AuthService
) {

    @PostMapping("/login")
    fun login(
        @RequestBody request: LoginRequest
    ): LoginResponse {

        return authService.login(request)
    }
}