package com.shivshakti.farmmanger.auth

import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.security.Keys
import org.springframework.stereotype.Service
import java.util.*
import javax.crypto.SecretKey

@Service
class JwtService {

    private val secretKey: SecretKey =
        Keys.hmacShaKeyFor(
            "shivshaktifarmmanagerjwtsecretkey123456789".toByteArray()
        )

    fun generateToken(
        username: String
    ): String {

        return Jwts.builder()
            .subject(username)
            .issuedAt(Date())
            .expiration(
                Date(
                    System.currentTimeMillis()
                            + 1000 * 60 * 60 * 24
                )
            )
            .signWith(secretKey)
            .compact()
    }

    fun extractUsername(
        token: String
    ): String {

        return extractClaims(token)
            .subject
    }

    fun isValid(
        token: String
    ): Boolean {

        return try {

            extractClaims(token)

            true

        } catch (ex: Exception) {

            false
        }
    }

    private fun extractClaims(
        token: String
    ): Claims {

        return Jwts.parser()
            .verifyWith(secretKey)
            .build()
            .parseSignedClaims(token)
            .payload
    }
}