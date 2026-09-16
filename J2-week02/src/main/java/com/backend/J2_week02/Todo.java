package com.backend.J2_week02;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder

public class Todo {
    private long id;
    private String body;
}
