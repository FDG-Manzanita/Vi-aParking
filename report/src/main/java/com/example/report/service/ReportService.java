package com.example.report.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.report.model.Report;
import com.example.report.repository.ReportRepository;

@Service
public class ReportService {

    @Autowired
    private ReportRepository reportRepository;

    @Autowired
    private JavaMailSender emailSender;

    @SuppressWarnings("unused")
    private final String uploadDir = "uploads/";

    public String saveReport(Report report) throws IOException {
        // Guardar el reporte en la base de datos
        reportRepository.save(report);

        // Enviar correo
        sendEmail(report);

        return "Reporte enviado con éxito!";
    }

    private void sendEmail(Report report) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo("terren3324@gmail.com");
        message.setSubject("Nuevo Reporte: " + report.getIssue());
        message.setText("Localización: " + report.getLatitude() + ", " + report.getLongitude() + "\nImagen: " + report.getImagePath());
        emailSender.send(message);
    }
}
