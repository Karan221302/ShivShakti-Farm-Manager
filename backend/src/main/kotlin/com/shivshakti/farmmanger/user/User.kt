package com.shivshakti.farmmanager.user

import jakarta.persistence.*
import java.util.UUID

@Entity
@Table(name = "users")
class User(

    @Id
    @GeneratedValue
    var id: UUID? = null,

    var name: String,

    @Column(unique = true)
    var username: String,

    var password: String,

    var role: String
)