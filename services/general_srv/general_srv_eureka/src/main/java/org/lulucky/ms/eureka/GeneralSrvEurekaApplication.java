package org.lulucky.ms.eureka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class GeneralSrvEurekaApplication {

    public static void main(String[] args) {
        SpringApplication.run(GeneralSrvEurekaApplication.class, args);
    }

}

