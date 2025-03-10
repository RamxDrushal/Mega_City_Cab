import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.entity.Booking;
import com.dao.BookingDAO;
import com.conn.DbConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"Booking_Bill_" + request.getParameter("cid") + ".pdf\"");

        try {
            
            int bookingId = Integer.parseInt(request.getParameter("cid"));
            
            
            BookingDAO dao = new BookingDAO(DbConnect.getConn());
            Booking booking = dao.getBookingById(bookingId); 

            if (booking == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                return;
            }

            
            String driverName = "Not Assigned";
            String driverPhoneNumber = "Not Available";
            if ("Accepted".equals(booking.getStatus()) && booking.getDriverId() != null) {
                String[] driverDetails = dao.getDriverDetailsByDriverId(booking.getDriverId());
                if (driverDetails != null) {
                    driverName = driverDetails[0];
                    driverPhoneNumber = driverDetails[1];
                }
            }

            
            Document document = new Document();
            OutputStream out = response.getOutputStream();
            PdfWriter.getInstance(document, out);

            
            document.open();

            
            document.add(new Paragraph("===== Cab Booking Bill ====="));
            document.add(new Paragraph(" "));
            document.add(new Paragraph("Booking ID: " + booking.getID()));
            document.add(new Paragraph("Start Location: " + booking.getStart()));
            document.add(new Paragraph("End Location: " + booking.getEnd()));
            document.add(new Paragraph("Customer Name: " + booking.getName()));
            document.add(new Paragraph("Phone: " + booking.getPhno()));
            document.add(new Paragraph("Email: " + booking.getEmail()));
            document.add(new Paragraph("Address: " + booking.getAddress()));
            document.add(new Paragraph("About: " + booking.getAbout()));
            document.add(new Paragraph("Amount: LKR " + booking.getAmount()));
            document.add(new Paragraph("Booking Date: " + booking.getBookingDate()));
            document.add(new Paragraph("Status: " + booking.getStatus()));
            document.add(new Paragraph("Driver: " + driverName));
            document.add(new Paragraph("Driver Contact: " + driverPhoneNumber));
            document.add(new Paragraph(" "));
            document.add(new Paragraph("Thank you for choosing our service!"));

            
            document.close();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating bill");
        }
    }
}