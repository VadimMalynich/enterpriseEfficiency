package by.bsuir.diplom.dao.api;

import by.bsuir.diplom.bean.Company;
import by.bsuir.diplom.dao.exception.DaoException;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.query.Query;

import java.util.List;

public class CompanyDao extends AbstractDao<Integer, Company> {
    private static final String GET_ALL = "SELECT * FROM company";
    private static final String GET_ALL_YNN = "SELECT ynn FROM company";
    private static final String GET_COMPANY = "SELECT * FROM company WHERE ynn=:ynn";
    private static final String FILTER_BY_AREA = "SELECT company.* FROM company_db.company LEFT JOIN address ON company.ynn = address.ynn where area=:area";
    private static final String FILTER_BY_DISTRICT = "SELECT company.* FROM company_db.company LEFT JOIN address ON company.ynn = address.ynn where district=:district";
    private static final String FILTER_BY_ABBREVIATION = "SELECT * FROM company where name like ";
    private static final String SEARCH_BY_NAME = "SELECT * FROM company where name or full_name like ";
    private static final String GET_BETWEEN_ID = "SELECT * FROM company_db.company where id between :first_id and :second_id";

    @Override
    public List<Company> getAll() throws DaoException {
        try {
            return session.createNativeQuery(GET_ALL).addEntity(Company.class).list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    @Override
    public void delete(Integer id) throws DaoException {
        try {
            Company company = session.find(Company.class, id);
            session.remove(company);
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public Company getCompany(Integer ynn) throws DaoException {
        try {
            Query query = session.createNativeQuery(GET_COMPANY).addEntity(Company.class);
            query.setParameter("ynn", ynn);
            return (Company) query.getSingleResult();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Company> getSortedById() throws DaoException {
        try {
            Criteria criteria = session.createCriteria(Company.class, "company");
            criteria.addOrder(Order.asc("id"));
            return criteria.list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Company> getFilterByArea(String area) throws DaoException {
        try {
            Query query = session.createNativeQuery(FILTER_BY_AREA).addEntity(Company.class);
            query.setParameter("area", area);
            return query.list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Company> getFilterByDistrict(String district) throws DaoException {
        try {
            Query query = session.createNativeQuery(FILTER_BY_DISTRICT).addEntity(Company.class);
            query.setParameter("district", district);
            return query.list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Company> filterByAbbreviation(String text) throws DaoException {
        try {
            Query query = session.createNativeQuery(FILTER_BY_ABBREVIATION + text).addEntity(Company.class);
            return query.list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Company> searchByName(String text) throws DaoException {
        try {
            Query query = session.createNativeQuery(SEARCH_BY_NAME + text).addEntity(Company.class);
            return query.list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Company> getBetweenId(Integer firstId, Integer secondId) throws DaoException {
        try {
            Query query = session.createNativeQuery(GET_BETWEEN_ID).addEntity(Company.class);
            query.setParameter("first_id", firstId);
            query.setParameter("second_id", secondId);
            return query.list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }

    public List<Integer> getAllYnn() throws DaoException {
        try {
            return session.createNativeQuery(GET_ALL_YNN).list();
        } catch (Exception ex) {
            throw new DaoException(ex);
        }
    }
}
