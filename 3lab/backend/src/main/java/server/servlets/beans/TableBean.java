package server.servlets.beans;

import jakarta.enterprise.context.ApplicationScoped;

import jakarta.inject.Named;
import server.servlets.database.PointRepository;
import server.servlets.database.models.Point;

import java.util.ArrayList;
import java.util.List;

@Named("tableBean")
@ApplicationScoped
public class TableBean {
    private List<Point> points = new ArrayList<>();

    public TableBean() {
        points = getPoints();
    }

    public List<Point> getPoints() {
        return PointRepository.getLastPoints();
    }
}