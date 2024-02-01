package com.dts.core.export;

import java.io.ByteArrayOutputStream;
import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

public class ExportPDF extends HttpServlet
{
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException
	{
		res.setContentType("application/pdf");

		// step 1: creation of a document-object
		Document document = new Document();

		ByteArrayOutputStream buffer = new ByteArrayOutputStream();
		try
		{
			// step 2: we create a writer that listens to the document
			// and directs a PDF-stream to a temporary buffer
			PdfWriter.getInstance(document, buffer);

			// step 3: we open the document
			document.open();

			// step 4: we add a paragraph to the document
			document.add(new Paragraph("Hello World"));

			// step 5: we close the document
			document.close();
		}
		catch (DocumentException de)
		{
			
		}

		// step 6: we output the writer as bytes to the response output
		DataOutput output;
		try
		{
			output = new DataOutputStream(res.getOutputStream());
			byte[] bytes = buffer.toByteArray();
			res.setContentLength(bytes.length);
			for (int i = 0; i < bytes.length; i++)
				output.writeByte(bytes[i]);
		}
		catch (IOException ioe)
		{
			
		}
	}
}
