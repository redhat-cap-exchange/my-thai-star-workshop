package com.example.springbootmanagementexample;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CrashController {
    @GetMapping("/crash")
	public void crash() {
	    Runtime.getRuntime().halt(0);
	}
}
