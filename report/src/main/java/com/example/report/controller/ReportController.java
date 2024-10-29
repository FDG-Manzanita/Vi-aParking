package com.example.report.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.report.model.Report;
import com.example.report.service.ReportService;

@RestController
@RequestMapping("/api/report")
public class ReportController {

    @Autowired
    private ReportService reportService;

    @PostMapping
    public String sendReport(@RequestParam("issue") String issue,
                             @RequestParam("latitude") String latitude,
                             @RequestParam("longitude") String longitude,
                             @RequestParam("image") MultipartFile image) throws IOException {

        // Guardar la imagen
        String imagePath = "uploads/" + image.getOriginalFilename();
        image.transferTo(new File(imagePath));

        // Crear objeto Report
        Report report = new Report();
        report.setIssue(issue);
        report.setLatitude(latitude);
        report.setLongitude(longitude);
        report.setImagePath(imagePath);

        // Guardar el reporte
        return reportService.saveReport(report);
    }
}
