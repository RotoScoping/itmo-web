package server.servlets.beans;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.context.RequestScoped;
import server.servlets.Area;
import server.servlets.database.PointRepository;
import server.servlets.database.models.Point;

import jakarta.inject.Named;

import java.math.BigDecimal;
import java.math.RoundingMode;


@Named("formBean")
@ApplicationScoped
public class FormBean {
    private double x;
    private double y;
    private double r;

    public void check() {
        BigDecimal roundedX = BigDecimal.valueOf(x).setScale(2, RoundingMode.HALF_UP);
        BigDecimal roundedY = BigDecimal.valueOf(y).setScale(2, RoundingMode.HALF_UP);
        BigDecimal roundedR = BigDecimal.valueOf(r).setScale(2, RoundingMode.HALF_UP);
        double roundedXValue = roundedX.doubleValue();
        double roundedYValue = roundedY.doubleValue();
        double roundedRValue = roundedR.doubleValue();
        boolean isHit = Area.Checker.hit(roundedXValue, roundedYValue, roundedRValue);
        PointRepository.insertPoint(new Point(roundedXValue, roundedYValue, roundedRValue, isHit));
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public double getR() {
        return r;
    }

    public void setR(double r) {
        this.r = r;
    }
}