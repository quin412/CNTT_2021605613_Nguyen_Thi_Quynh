package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.domain.dto.request.RevenueDto;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.annotation.Nullable;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.util.List;

@Service
public class ExportPDFServiceImpl {

    public byte[] exportToPdf(
            @Nullable String date,
            @Nullable int month,
            @Nullable int year,
            Long totalRevenue,
            int totalBill,
            int totalCustomer,
            int totalProduct,
            List<CategoryMarketShareDto> categories,
            List<ProductDto> products,
            @Nullable List<RevenueDto> revenuedays,
            @Nullable List<RevenueDto> revenuemonths
    ) throws Exception {
        Document document = new Document();
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        PdfWriter.getInstance(document, out);
        document.open();

        // Add Title
        String fontPath = "src/main/webapp/resources/vuArial.ttf"; // Update with the correct path to your font file
        BaseFont baseFont = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font font1 = new Font(baseFont, 24, Font.NORMAL, BaseColor.BLACK);
        Font font = new Font(baseFont, 16, Font.NORMAL, BaseColor.BLACK);
        Font font2 = new Font(baseFont, 12, Font.NORMAL, BaseColor.BLACK);
        Paragraph titlemain = new Paragraph("Thống kê", font1);
        titlemain.setAlignment(Element.ALIGN_CENTER);
        document.add(titlemain);

        if (date != null) {
            document.add(Chunk.NEWLINE);
            Paragraph titleDate = new Paragraph("Ngày " + date, font1);
            titleDate.setAlignment(Element.ALIGN_CENTER);
            document.add(titleDate);
        }

        if (month != 0 && year != 0) {
            document.add(Chunk.NEWLINE);
            Paragraph titleMonth = new Paragraph("Tháng " + month + " năm " + year, font1);
            titleMonth.setAlignment(Element.ALIGN_CENTER);
            document.add(titleMonth);
        }

        document.add(Chunk.NEWLINE);
        Paragraph total3 = new Paragraph("Doanh thu: " + totalRevenue, font);
        document.add(total3);

        document.add(Chunk.NEWLINE);
        Paragraph total = new Paragraph("Tổng sản phẩm mới: " + totalProduct, font);
        document.add(total);

        document.add(Chunk.NEWLINE);
        Paragraph total1 = new Paragraph("Tổng số đơn hàng: " + totalBill, font);
        document.add(total1);

        document.add(Chunk.NEWLINE);
        Paragraph total2 = new Paragraph("Tổng số khách hàng: " + totalCustomer, font);
        document.add(total2);

        if (revenuedays != null) {
            document.add(Chunk.NEWLINE);
            Paragraph title_RevenueDay = new Paragraph("Doanh thu ngày", font);
            title_RevenueDay.setAlignment(Element.ALIGN_LEFT);
            document.add(title_RevenueDay);
            document.add(Chunk.NEWLINE);
            PdfPTable table1 = new PdfPTable(2); // 3 columns
            table1.setWidthPercentage(100);
            table1.setWidths(new int[]{2, 3});

            PdfPCell header1 = new PdfPCell(new Phrase("Ngày", font2));
            PdfPCell header2 = new PdfPCell(new Phrase("Doanh thu", font2));

            table1.addCell(header1);
            table1.addCell(header2);
            for (RevenueDto revenueday : revenuedays) {
                table1.addCell(revenueday.getLabel().toString());
                table1.addCell(revenueday.getTotalRevenue().toString());
            }
            document.add(table1);
        }

        if (revenuemonths != null) {
            document.add(Chunk.NEWLINE);
            Paragraph title_RevenueMonth = new Paragraph("Doanh thu tháng", font);
            title_RevenueMonth.setAlignment(Element.ALIGN_LEFT);
            document.add(title_RevenueMonth);
            document.add(Chunk.NEWLINE);
            PdfPTable table2 = new PdfPTable(2); // 3 columns
            table2.setWidthPercentage(100);
            table2.setWidths(new int[]{3, 3});

            PdfPCell header1 = new PdfPCell(new Phrase("Tháng", font2));
            PdfPCell header2 = new PdfPCell(new Phrase("Doanh thu", font2));

            table2.addCell(header1);
            table2.addCell(header2);
            for (RevenueDto revenue : revenuemonths) {
                table2.addCell(revenue.getLabel().toString());
                table2.addCell(revenue.getTotalRevenue().toString());
            }
            document.add(table2);
        }

        document.add(Chunk.NEWLINE);
        Paragraph title_Category = new Paragraph("Thị phần các nhãn hàng", font);
        title_Category.setAlignment(Element.ALIGN_LEFT);
        document.add(title_Category);
        document.add(Chunk.NEWLINE);
        PdfPTable table3 = new PdfPTable(3); // 3 columns
        table3.setWidthPercentage(100);
        table3.setWidths(new int[]{3, 3, 3});

        PdfPCell header1 = new PdfPCell(new Phrase("Tên nhãn hàng", font2));
        PdfPCell header2 = new PdfPCell(new Phrase("Doanh thu", font2));
        PdfPCell header3 = new PdfPCell(new Phrase("Thị phần", font2));

        table3.addCell(header1);
        table3.addCell(header2);
        table3.addCell(header3);

        for (CategoryMarketShareDto category : categories) {
            table3.addCell(category.getName().toString());
            table3.addCell(category.getCategoryRevenue().toString());
            table3.addCell(String.valueOf(category.getMarketShare()));
        }
        document.add(table3);

        document.add(Chunk.NEWLINE);
        Paragraph title = new Paragraph("Top sản phẩm", font);
        title.setAlignment(Element.ALIGN_LEFT);
        document.add(title);
        document.add(Chunk.NEWLINE);

        // Create Table
        PdfPTable table = new PdfPTable(5); // 5 columns
        table.setWidthPercentage(100);
        table.setWidths(new int[]{2, 4, 3, 3, 2});

        PdfPCell header4 = new PdfPCell(new Phrase("Mã sản phẩm", font2));
        PdfPCell header5 = new PdfPCell(new Phrase("Tên sản phẩm", font2));
        PdfPCell header6 = new PdfPCell(new Phrase("Nhà sản xuất", font2));
        PdfPCell header7 = new PdfPCell(new Phrase("Giá", font2));
        PdfPCell header8 = new PdfPCell(new Phrase("Doanh số", font2));

        // Add Table Headers
        table.addCell(header4);
        table.addCell(header5);
        table.addCell(header6);
        table.addCell(header7);
        table.addCell(header8);

        // Add Rows
        for (ProductDto product : products) {
            table.addCell(product.getProductId().toString());
            table.addCell(product.getName().toString());
            table.addCell(product.getCategoryName().toString());
            table.addCell(product.getPrice().toString());
            table.addCell(product.getTotalSales().toString());
        }

        document.add(table);

        document.close();

        return out.toByteArray();
    }
}

