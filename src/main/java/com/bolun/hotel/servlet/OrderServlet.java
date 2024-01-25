package com.bolun.hotel.servlet;

import jakarta.servlet.annotation.WebServlet;
import com.bolun.hotel.dto.CreateOrderDto;
import com.bolun.hotel.dto.ReadUserDto;
import com.bolun.hotel.helper.JspHelper;
import com.bolun.hotel.service.ApartmentService;
import com.bolun.hotel.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import com.bolun.hotel.service.impl.OrderServiceImpl;
import com.bolun.hotel.service.impl.ApartmentServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.bolun.hotel.exception.InvalidDateException;

import java.io.IOException;
import java.time.LocalDateTime;

import static com.bolun.hotel.helper.UrlPath.*;

@WebServlet(ORDER)
public class OrderServlet extends HttpServlet {

    private final ApartmentService apartmentService = ApartmentServiceImpl.getInstance();
    private final OrderService orderService = OrderServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LocalDateTime currentDateTime = LocalDateTime.now().withSecond(0).withNano(0);

        req.setAttribute("apartments", apartmentService.findAll());
        req.setAttribute("current", currentDateTime);
        req.getRequestDispatcher(JspHelper.getPath(ORDER))
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ReadUserDto readUserDto = (ReadUserDto) req.getSession().getAttribute("user");

        CreateOrderDto createOrderDto = new CreateOrderDto(
                readUserDto,
                req.getParameter("check-in"),
                req.getParameter("check-out"),
                req.getParameter("apartment")
        );

        try {
            orderService.create(createOrderDto);
            resp.sendRedirect(APARTMENT);
        } catch (InvalidDateException ex) {
            req.setAttribute("errors", ex.getErrors());
            doGet(req, resp);
        }
    }
}
