package com.shivshakti.farmmanger.auth

import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

@Component
class JwtFilter(

    private val jwtService: JwtService

) : OncePerRequestFilter() {

    override fun doFilterInternal(

        request: HttpServletRequest,

        response: HttpServletResponse,

        filterChain: FilterChain

    ) {

        val authHeader =
            request.getHeader(
                "Authorization"
            )

        if (
            authHeader == null
            || !authHeader.startsWith("Bearer ")
        ) {

            filterChain.doFilter(
                request,
                response
            )

            return
        }

        val token =
            authHeader.substring(7)

        if (
            jwtService.isValid(token)
        ) {

            val username =
                jwtService.extractUsername(
                    token
                )

            val auth =
                UsernamePasswordAuthenticationToken(
                    username,
                    null,
                    emptyList()
                )

            auth.details =
                WebAuthenticationDetailsSource()
                    .buildDetails(request)

            SecurityContextHolder
                .getContext()
                .authentication = auth
        }

        filterChain.doFilter(
            request,
            response
        )
    }
}