package by.bsuir.diplom.controller.command.impl;

import by.bsuir.diplom.controller.command.Command;
import by.bsuir.diplom.service.ServiceException;
import by.bsuir.diplom.service.ServiceProvider;
import by.bsuir.diplom.service.api.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

public class DeleteUser implements Command {
    private static final Logger userLogger = LogManager.getLogger(DeleteUser.class);

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response, File uploadFilePath) throws ServletException, IOException {

        Integer id = Integer.valueOf(request.getParameter("deleteUserId"));

        ServiceProvider provider = ServiceProvider.getInstance();
        UserService userService = provider.getUserService();

        try {
            userService.delete(id);
            response.sendRedirect("enterpriseEfficiency?command=go_to_users_page&message=message.deleteUser.complete");
        } catch (ServiceException e) {
            userLogger.info(e);
            response.sendRedirect("enterpriseEfficiency?command=go_to_users_page&message=message.deleteUser.unsuccessfully");
        }
    }
}
