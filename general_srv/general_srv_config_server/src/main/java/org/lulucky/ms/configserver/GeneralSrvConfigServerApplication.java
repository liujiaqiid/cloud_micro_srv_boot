package org.lulucky.ms.configserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableConfigServer
public class GeneralSrvConfigServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(GeneralSrvConfigServerApplication.class, args);
    }

}

