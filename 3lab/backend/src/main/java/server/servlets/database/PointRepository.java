package server.servlets.database;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import server.servlets.database.models.Point;

import java.util.List;

public class PointRepository {
    private static final SessionFactory sessionFactory;

    static {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static Session getSession() {
        return sessionFactory.openSession();
    }

    public static void insertPoint(Point point) {
        try (Session session = getSession()) {
            session.beginTransaction();
            session.save(point);
            session.getTransaction().commit();
        }
    }

    public static List<Point> getLastPoints() {
        try (Session session = getSession()) {
            return session.createQuery("FROM Point ORDER BY id DESC", Point.class)
                    .setMaxResults(11)
                    .getResultList();
        }
    }
}
