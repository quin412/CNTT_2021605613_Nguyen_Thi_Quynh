package com.example.laptopaz;

import com.example.laptopaz.service.RoleService;
import com.example.laptopaz.service.impl.CustomerServiceImpl;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;


@Slf4j
@EnableAsync
@EnableScheduling
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@SpringBootApplication
public class LaptopazApplication {
	RoleService roleService;

	CustomerServiceImpl customerService;
	public static void main(String[] args) {
		Environment env = SpringApplication.run(LaptopazApplication.class, args).getEnvironment();

		String appName = env.getProperty("spring.application.name");
		if (appName != null) {
			appName = appName.toUpperCase();
		}
		String port = env.getProperty("server.port");

		log.info("-------------------------START {} Application------------------------------", appName);
		log.info("   Application         : {}", appName);
		log.info("   Client UI           : http://localhost:{}", port);
		log.info("-------------------------START SUCCESS {} Application------------------------------", appName);
	}

	@Bean
	CommandLineRunner init() {
		return args -> {
			roleService.initRoles();
			customerService.initAdmin();
		};
	}
}
